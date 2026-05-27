import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'edit_post_screen.dart';
import '../../services/post_service.dart';

class PostDetailsScreen extends StatelessWidget {

  final Map<String, dynamic> post;

  const PostDetailsScreen({
    super.key,
    required this.post,
  });

  @override
  Widget build(BuildContext context) {

    final currentUser =
        FirebaseAuth.instance.currentUser;

    final bool isOwner =
        currentUser != null &&
            currentUser.uid ==
                post['userId'];

    final PostService postService =
    PostService();

    return Scaffold(

      backgroundColor:
      Color(0xFFFFFFE3),

      appBar: AppBar(

        backgroundColor:
        Color(0xFFFFFFE3),

        elevation: 0,

        title: Text(
          'Post Details',

          style: TextStyle(
            color: Colors.black87,
            fontWeight:
            FontWeight.bold,
          ),
        ),

        iconTheme: IconThemeData(
          color: Colors.black87,
        ),
      ),

      body: SingleChildScrollView(

        physics:
        BouncingScrollPhysics(),

        padding: EdgeInsets.all(20),

        child: Column(

          crossAxisAlignment:
          CrossAxisAlignment.start,

          children: [

            Container(

              width: double.infinity,

              padding: EdgeInsets.all(16),

              decoration: BoxDecoration(

                color: Colors.white,

                borderRadius:
                BorderRadius.circular(
                  24,
                ),

                boxShadow: [

                  BoxShadow(
                    color:
                    Colors.black12,

                    blurRadius: 10,

                    offset: Offset(0, 4),
                  ),
                ],
              ),

              child: Row(

                crossAxisAlignment:
                CrossAxisAlignment.start,

                children: [

                  CircleAvatar(
                    radius: 28,

                    backgroundImage:
                    NetworkImage(
                      post['userAvatar'],
                    ),
                  ),

                  SizedBox(width: 14),

                  Expanded(

                    child: Column(

                      crossAxisAlignment:
                      CrossAxisAlignment.start,

                      children: [

                        Text(
                          post['userName'],

                          style: TextStyle(
                            fontSize: 18,
                            fontWeight:
                            FontWeight.bold,
                            color:
                            Colors.black87,
                          ),
                        ),

                        SizedBox(height: 6),

                        Container(

                          padding:
                          EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 5,
                          ),

                          decoration: BoxDecoration(

                            color:
                            post['type'] ==
                                'lost'
                                ? Color(
                              0xFFFFD7D7,
                            )
                                : Color(
                              0xFFC8E6C9,
                            ),

                            borderRadius:
                            BorderRadius.circular(
                              18,
                            ),
                          ),

                          child: Text(
                            post['type']
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
                  ),

                  Container(

                    padding:
                    EdgeInsets.symmetric(
                      horizontal: 14,
                      vertical: 7,
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
                        18,
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
            ),

            SizedBox(height: 22),

            Text(
              post['itemName'],

              style: TextStyle(
                fontSize: 28,
                fontWeight:
                FontWeight.bold,
                color: Colors.black87,
              ),
            ),

            SizedBox(height: 15),

            Container(

              padding:
              EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 10,
              ),

              decoration: BoxDecoration(

                color: Colors.white,

                borderRadius:
                BorderRadius.circular(
                  18,
                ),
              ),

              child: Text(
                post['category'],

                style: TextStyle(
                  fontSize: 15,
                  fontWeight:
                  FontWeight.w600,
                  color: Colors.black87,
                ),
              ),
            ),

            SizedBox(height: 20),

            buildSectionTitle(
              'Location',
            ),

            SizedBox(height: 8),

            buildInfoContainer(

              Row(

                children: [

                  Icon(
                    Icons.location_on_outlined,
                    color:
                    Colors.black54,
                  ),

                  SizedBox(width: 10),

                  Expanded(

                    child: Text(
                      post['location'],

                      style: TextStyle(
                        fontSize: 16,
                        color:
                        Colors.black87,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(height: 20),

            buildSectionTitle(
              'Description',
            ),

            SizedBox(height: 8),

            buildInfoContainer(

              Text(
                post['description'],

                style: TextStyle(
                  fontSize: 16,
                  height: 1.5,
                  color: Colors.black87,
                ),
              ),
            ),

            SizedBox(height: 20),

            buildSectionTitle(
              'Contact Information',
            ),

            SizedBox(height: 8),

            buildInfoContainer(

              Text(
                post['contactInfo'],

                style: TextStyle(
                  fontSize: 16,
                  color: Colors.black87,
                ),
              ),
            ),

            if (isOwner) ...[

              SizedBox(height: 28),

              SizedBox(

                width: double.infinity,

                child: ElevatedButton.icon(

                  style:
                  ElevatedButton
                      .styleFrom(

                    backgroundColor:
                    Colors.black87,

                    padding:
                    EdgeInsets.symmetric(
                      vertical: 15,
                    ),

                    shape:
                    RoundedRectangleBorder(
                      borderRadius:
                      BorderRadius.circular(
                        18,
                      ),
                    ),
                  ),

                  onPressed:
                  post['status'] ==
                      'resolved'
                      ? null
                      : () {

                    Navigator.push(

                      context,

                      MaterialPageRoute(

                        builder:
                            (context) =>
                            EditPostScreen(
                              post: post,
                            ),
                      ),
                    );
                  },

                  icon: Icon(
                    Icons.edit,
                    color: Colors.white,
                  ),

                  label: Text(
                    'Edit Post',

                    style: TextStyle(
                      color:
                      Colors.white,
                      fontSize: 16,
                    ),
                  ),
                ),
              ),

              SizedBox(height: 14),

              SizedBox(

                width: double.infinity,

                child: ElevatedButton.icon(

                  style:
                  ElevatedButton
                      .styleFrom(

                    backgroundColor:
                    Colors.green,

                    padding:
                    EdgeInsets.symmetric(
                      vertical: 15,
                    ),

                    shape:
                    RoundedRectangleBorder(
                      borderRadius:
                      BorderRadius.circular(
                        18,
                      ),
                    ),
                  ),

                  onPressed:
                  post['status'] ==
                      'resolved'
                      ? null
                      : () async {

                    await postService
                        .markPostResolved(
                      post['id'],
                    );

                    Navigator.pop(
                      context,
                    );

                    ScaffoldMessenger.of(
                      context,
                    ).showSnackBar(

                      SnackBar(
                        content: Text(
                          'Post marked as resolved',
                        ),
                      ),
                    );
                  },

                  icon: Icon(
                    Icons.check_circle,
                    color: Colors.white,
                  ),

                  label: Text(
                    'Mark as Resolved',

                    style: TextStyle(
                      color:
                      Colors.white,
                      fontSize: 16,
                    ),
                  ),
                ),
              ),

              SizedBox(height: 14),

              SizedBox(

                width: double.infinity,

                child: ElevatedButton.icon(

                  style:
                  ElevatedButton
                      .styleFrom(

                    backgroundColor:
                    Colors.redAccent,

                    padding:
                    EdgeInsets.symmetric(
                      vertical: 15,
                    ),

                    shape:
                    RoundedRectangleBorder(
                      borderRadius:
                      BorderRadius.circular(
                        18,
                      ),
                    ),
                  ),

                  onPressed: () async {

                    await postService
                        .deletePost(
                      post['id'],
                    );

                    Navigator.pop(
                      context,
                    );

                    ScaffoldMessenger.of(
                      context,
                    ).showSnackBar(

                      SnackBar(
                        content: Text(
                          'Post deleted',
                        ),
                      ),
                    );
                  },

                  icon: Icon(
                    Icons.delete,
                    color: Colors.white,
                  ),

                  label: Text(
                    'Delete Post',

                    style: TextStyle(
                      color:
                      Colors.white,
                      fontSize: 16,
                    ),
                  ),
                ),
              ),

              SizedBox(height: 20),
            ],
          ],
        ),
      ),
    );
  }

  Widget buildSectionTitle(
      String title,
      ) {

    return Text(
      title,

      style: TextStyle(
        fontSize: 17,
        fontWeight:
        FontWeight.bold,
        color: Colors.black87,
      ),
    );
  }

  Widget buildInfoContainer(
      Widget child,
      ) {

    return Container(

      width: double.infinity,

      padding: EdgeInsets.all(15),

      decoration: BoxDecoration(

        color: Colors.white,

        borderRadius:
        BorderRadius.circular(
          20,
        ),
      ),

      child: child,
    );
  }
}