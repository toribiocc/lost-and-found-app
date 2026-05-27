import 'package:flutter/material.dart';

import '../../services/post_service.dart';

class EditPostScreen extends StatefulWidget {

  final Map<String, dynamic> post;

  const EditPostScreen({
    super.key,
    required this.post,
  });

  @override
  State<EditPostScreen> createState() =>
      _EditPostScreenState();
}

class _EditPostScreenState
    extends State<EditPostScreen> {

  late TextEditingController
  itemNameController;

  late TextEditingController
  descriptionController;

  late TextEditingController
  locationController;

  late TextEditingController
  contactController;

  final PostService postService =
  PostService();

  bool isLoading = false;

  late String selectedCategory;

  final List<String> categories = [
    'Electronics',
    'Wallet',
    'ID Card',
    'Documents',
    'Clothing',
    'Accessories',
    'School Supplies',
    'Others',
  ];

  @override
  void initState() {
    super.initState();

    itemNameController =
        TextEditingController(
          text: widget.post['itemName'],
        );

    descriptionController =
        TextEditingController(
          text: widget.post['description'],
        );

    locationController =
        TextEditingController(
          text: widget.post['location'],
        );

    contactController =
        TextEditingController(
          text: widget.post['contactInfo'],
        );

    selectedCategory =
    widget.post['category'];
  }

  Future<void> updatePost() async {

    if (itemNameController.text
        .trim()
        .isEmpty ||
        descriptionController.text
            .trim()
            .isEmpty ||
        locationController.text
            .trim()
            .isEmpty ||
        contactController.text
            .trim()
            .isEmpty) {

      ScaffoldMessenger.of(context)
          .showSnackBar(

        SnackBar(
          content: Text(
            'Please fill all fields',
          ),
        ),
      );

      return;
    }

    setState(() {
      isLoading = true;
    });

    await postService.updatePost(

      postId: widget.post['id'],

      itemName:
      itemNameController.text
          .trim(),

      description:
      descriptionController.text
          .trim(),

      location:
      locationController.text
          .trim(),

      category: selectedCategory,

      contactInfo:
      contactController.text
          .trim(),
    );

    setState(() {
      isLoading = false;
    });

    Navigator.pop(context);

    ScaffoldMessenger.of(context)
        .showSnackBar(

      SnackBar(
        content: Text(
          'Post updated',
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      backgroundColor:
      Color(0xFFFFFFE3),

      appBar: AppBar(

        backgroundColor:
        Color(0xFFFFFFE3),

        elevation: 0,

        title: Text(
          'Edit Post',

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

            Text(
              'Update Post',

              style: TextStyle(
                fontSize: 30,
                fontWeight:
                FontWeight.bold,
                color: Colors.black87,
              ),
            ),

            SizedBox(height: 6),

            Text(
              'Edit the information below.',

              style: TextStyle(
                fontSize: 15,
                color: Colors.black54,
              ),
            ),

            SizedBox(height: 30),

            TextField(
              controller:
              itemNameController,

              decoration: InputDecoration(

                labelText: 'Item Name',

                filled: true,
                fillColor: Colors.white,

                border:
                OutlineInputBorder(

                  borderRadius:
                  BorderRadius.circular(
                    18,
                  ),

                  borderSide:
                  BorderSide.none,
                ),
              ),
            ),

            SizedBox(height: 20),

            TextField(
              controller:
              descriptionController,

              maxLines: 4,

              decoration: InputDecoration(

                labelText: 'Description',

                filled: true,
                fillColor: Colors.white,

                border:
                OutlineInputBorder(

                  borderRadius:
                  BorderRadius.circular(
                    18,
                  ),

                  borderSide:
                  BorderSide.none,
                ),
              ),
            ),

            SizedBox(height: 20),

            TextField(
              controller:
              locationController,

              decoration: InputDecoration(

                labelText: 'Location',

                filled: true,
                fillColor: Colors.white,

                border:
                OutlineInputBorder(

                  borderRadius:
                  BorderRadius.circular(
                    18,
                  ),

                  borderSide:
                  BorderSide.none,
                ),
              ),
            ),

            SizedBox(height: 20),

            TextField(
              controller:
              contactController,

              decoration: InputDecoration(

                labelText:
                'Contact Details',

                hintText:
                'Phone or Messenger',

                filled: true,
                fillColor: Colors.white,

                border:
                OutlineInputBorder(

                  borderRadius:
                  BorderRadius.circular(
                    18,
                  ),

                  borderSide:
                  BorderSide.none,
                ),
              ),
            ),

            SizedBox(height: 20),

            DropdownButtonFormField<String>(

              value: selectedCategory,

              dropdownColor:
              Colors.white,

              decoration: InputDecoration(

                labelText: 'Category',

                filled: true,
                fillColor: Colors.white,

                border:
                OutlineInputBorder(

                  borderRadius:
                  BorderRadius.circular(
                    18,
                  ),

                  borderSide:
                  BorderSide.none,
                ),
              ),

              items:
              categories.map((category) {

                return DropdownMenuItem(
                  value: category,
                  child: Text(category),
                );

              }).toList(),

              onChanged: (value) {

                setState(() {
                  selectedCategory =
                  value!;
                });
              },
            ),

            SizedBox(height: 35),

            SizedBox(

              width: double.infinity,

              child: ElevatedButton(

                style:
                ElevatedButton.styleFrom(

                  backgroundColor:
                  Colors.black87,

                  padding:
                  EdgeInsets.symmetric(
                    vertical: 16,
                  ),

                  shape:
                  RoundedRectangleBorder(
                    borderRadius:
                    BorderRadius.circular(
                      18,
                    ),
                  ),
                ),

                onPressed: updatePost,

                child: isLoading
                    ? CircularProgressIndicator(
                  color: Colors.white,
                )
                    : Text(
                  'Save Changes',

                  style: TextStyle(
                    color:
                    Colors.white,

                    fontSize: 16,

                    fontWeight:
                    FontWeight.w600,
                  ),
                ),
              ),
            ),

            SizedBox(height: 30),
          ],
        ),
      ),
    );
  }
}