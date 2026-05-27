import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../../services/post_service.dart';
import 'post_details_screen.dart';

class LostItemsScreen extends StatelessWidget {
  const LostItemsScreen({super.key});

  @override
  Widget build(BuildContext context) {

    final PostService postService =
    PostService();

    return StreamBuilder<QuerySnapshot>(

      stream: postService.getLostPosts(),

      builder: (context, snapshot) {

        if (snapshot.connectionState ==
            ConnectionState.waiting) {

          return Center(
            child:
            CircularProgressIndicator(),
          );
        }

        if (!snapshot.hasData ||
            snapshot.data!.docs.isEmpty) {

          return Center(
            child: Text(
              'No lost items',
            ),
          );
        }

        final posts = snapshot.data!.docs;

        return ListView.builder(

          padding: EdgeInsets.only(
            bottom: 20,
          ),

          itemCount: posts.length,

          itemBuilder: (context, index) {

            final post = posts[index];

            return GestureDetector(

              onTap: () {

                Navigator.push(

                  context,

                  MaterialPageRoute(

                    builder: (context) =>
                        PostDetailsScreen(
                          post:
                          post.data()
                          as Map<String, dynamic>,
                        ),
                  ),
                );
              },

              child: Container(

                margin: EdgeInsets.symmetric(
                  horizontal: 18,
                  vertical: 8,
                ),

                padding: EdgeInsets.all(16),

                decoration: BoxDecoration(

                  color: Colors.white,

                  borderRadius:
                  BorderRadius.circular(24),

                  boxShadow: [

                    BoxShadow(
                      color:
                      Colors.black12,

                      blurRadius: 10,

                      offset: Offset(0, 4),
                    ),
                  ],
                ),

                child: Column(

                  crossAxisAlignment:
                  CrossAxisAlignment.start,

                  children: [

                    Row(

                      crossAxisAlignment:
                      CrossAxisAlignment.start,

                      children: [

                        CircleAvatar(
                          radius: 24,

                          backgroundImage:
                          NetworkImage(
                            post['userAvatar'],
                          ),
                        ),

                        SizedBox(width: 12),

                        Expanded(

                          child: Column(

                            crossAxisAlignment:
                            CrossAxisAlignment.start,

                            children: [

                              Text(
                                post['userName'],

                                style: TextStyle(
                                  fontSize: 15,
                                  fontWeight:
                                  FontWeight.bold,
                                  color:
                                  Colors.black87,
                                ),
                              ),

                              SizedBox(height: 2),

                              Text(
                                post['category'],

                                style: TextStyle(
                                  fontSize: 13,
                                  color:
                                  Colors.black54,
                                ),
                              ),
                            ],
                          ),
                        ),

                        Container(

                          padding:
                          EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 6,
                          ),

                          decoration: BoxDecoration(

                            color:
                            post['status'] ==
                                'active'
                                ? Color(
                              0xFFFFD27D,
                            )
                                : Color(
                              0xFFA5D6A7,
                            ),

                            borderRadius:
                            BorderRadius.circular(
                              20,
                            ),
                          ),

                          child: Text(
                            post['status']
                                .toString()
                                .toUpperCase(),

                            style: TextStyle(
                              fontSize: 11,
                              fontWeight:
                              FontWeight.bold,
                              color:
                              Colors.black87,
                            ),
                          ),
                        ),
                      ],
                    ),

                    SizedBox(height: 18),

                    Text(
                      post['itemName'],

                      style: TextStyle(
                        fontSize: 22,
                        fontWeight:
                        FontWeight.bold,
                        color: Colors.black87,
                      ),
                    ),

                    SizedBox(height: 10),

                    Text(
                      post['description'],

                      maxLines: 2,

                      overflow:
                      TextOverflow.ellipsis,

                      style: TextStyle(
                        fontSize: 15,
                        height: 1.4,
                        color: Colors.black87,
                      ),
                    ),

                    SizedBox(height: 18),

                    Row(

                      children: [

                        Icon(
                          Icons.location_on_outlined,
                          size: 18,
                          color:
                          Colors.black54,
                        ),

                        SizedBox(width: 5),

                        Expanded(

                          child: Text(
                            post['location'],

                            style: TextStyle(
                              fontSize: 14,
                              color:
                              Colors.black54,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }
}