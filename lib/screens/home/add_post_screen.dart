import 'package:flutter/material.dart';

import '../../services/post_service.dart';

class AddPostScreen extends StatefulWidget {
  const AddPostScreen({super.key});

  @override
  State<AddPostScreen> createState() => _AddPostScreenState();
}

class _AddPostScreenState
    extends State<AddPostScreen> {

  final _itemNameController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _locationController = TextEditingController();
  final _contactController = TextEditingController();
  final PostService _postService = PostService();

  bool isLoading = false;
  String selectedType = 'lost';
  String selectedCategory = 'Electronics';

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

  Future<void> createPost() async {

    if (_itemNameController.text.trim().isEmpty ||
        _descriptionController.text.trim().isEmpty ||
        _locationController.text.trim().isEmpty ||
        _contactController.text.trim().isEmpty) {

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

    String? result =
    await _postService.createPost(

      type: selectedType,

      itemName: _itemNameController.text.trim(),
      description: _descriptionController.text.trim(),
      location: _locationController.text.trim(),
      contactInfo: _contactController.text.trim(),
      category: selectedCategory,
    );

    setState(() {
      isLoading = false;
    });

    if (result == null) {

      ScaffoldMessenger.of(context)
          .showSnackBar(

        SnackBar(
          content: Text(
            'Post Created',
          ),
        ),
      );

      _itemNameController.clear();
      _descriptionController.clear();
      _locationController.clear();
      _contactController.clear();

    } else {

      ScaffoldMessenger.of(context)
          .showSnackBar(

        SnackBar(
          content: Text(result),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {

    return SingleChildScrollView(

      physics:
      BouncingScrollPhysics(),

      padding: EdgeInsets.all(20),

      child: Column(

        crossAxisAlignment:
        CrossAxisAlignment.start,

        children: [

          Text(
            selectedType == 'lost'
                ? 'Lost Something?'
                : 'Found Something?',

            style: TextStyle(
              fontSize: 30,
              fontWeight:
              FontWeight.bold,
              color: Colors.black87,
            ),
          ),

          SizedBox(height: 6),

          Text(
            'Help the community reconnect items.',

            style: TextStyle(
              fontSize: 15,
              color: Colors.black54,
            ),
          ),

          SizedBox(height: 25),

          Row(

            children: [

              ChoiceChip(

                showCheckmark: false,

                label: Text(
                  'Lost',

                  style: TextStyle(
                    color:
                    selectedType ==
                        'lost'
                        ? Colors.white
                        : Colors.black87,

                    fontWeight:
                    FontWeight.w600,
                  ),
                ),

                selected:
                selectedType ==
                    'lost',

                selectedColor:
                Colors.black87,

                backgroundColor:
                Colors.white,

                side: BorderSide(
                  color:
                  Colors.black12,
                ),

                shape:
                RoundedRectangleBorder(
                  borderRadius:
                  BorderRadius.circular(
                    30,
                  ),
                ),

                onSelected: (value) {

                  setState(() {
                    selectedType = 'lost';
                  });
                },
              ),

              SizedBox(width: 12),

              ChoiceChip(

                showCheckmark: false,

                label: Text(
                  'Found',

                  style: TextStyle(
                    color:
                    selectedType ==
                        'found'
                        ? Colors.white
                        : Colors.black87,

                    fontWeight:
                    FontWeight.w600,
                  ),
                ),

                selected:
                selectedType ==
                    'found',

                selectedColor:
                Colors.black87,

                backgroundColor:
                Colors.white,

                side: BorderSide(
                  color:
                  Colors.black12,
                ),

                shape:
                RoundedRectangleBorder(
                  borderRadius:
                  BorderRadius.circular(
                    30,
                  ),
                ),

                onSelected: (value) {

                  setState(() {
                    selectedType = 'found';
                  });
                },
              ),
            ],
          ),

          SizedBox(height: 30),

          TextField(
            controller:
            _itemNameController,

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
            _descriptionController,

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
            _locationController,

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
            _contactController,

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

              onPressed: createPost,

              child: isLoading
                  ? CircularProgressIndicator(
                color: Colors.white,
              )
                  : Text(
                'Create Post',

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

          SizedBox(height: 25),
        ],
      ),
    );
  }
}