import 'package:flutter/material.dart';

import 'lost_items_screen.dart';
import 'found_items_screen.dart';
import 'add_post_screen.dart';
import 'profile_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() =>
      _HomeScreenState();
}

class _HomeScreenState
    extends State<HomeScreen> {

  int currentIndex = 0;

  final List<Widget> screens = [
    LostItemsScreen(),
    FoundItemsScreen(),
    AddPostScreen(),
    ProfileScreen(),
  ];

  final List<String> titles = [
    'Lost',
    'Found',
    'Post',
    'Profile',
  ];

  final List<IconData> icons = [
    Icons.help_outline_rounded,
    Icons.search_rounded,
    Icons.edit_note_rounded,
    Icons.person_outline_rounded,
  ];

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      backgroundColor:
      Color(0xFFFFFFE3),

      body: SafeArea(

        child: Column(

          children: [

            Padding(

              padding: EdgeInsets.symmetric(
                horizontal: 20,
                vertical: 16,
              ),

              child: Row(

                children: [

                  Icon(
                    icons[currentIndex],

                    size: 30,
                    color: Colors.black87,
                  ),

                  SizedBox(width: 10),

                  Text(
                    titles[currentIndex],

                    style: TextStyle(
                      fontSize: 28,
                      fontWeight:
                      FontWeight.bold,
                      color:
                      Colors.black87,
                    ),
                  ),
                ],
              ),
            ),

            Expanded(
              child:
              screens[currentIndex],
            ),
          ],
        ),
      ),

      bottomNavigationBar:
      BottomNavigationBar(

        backgroundColor:
        Colors.white,

        currentIndex: currentIndex,

        onTap: (index) {

          setState(() {
            currentIndex = index;
          });
        },

        type:
        BottomNavigationBarType.fixed,

        selectedItemColor:
        Colors.black87,

        unselectedItemColor:
        Colors.black45,

        elevation: 8,

        items: [

          BottomNavigationBarItem(
            icon: Icon(
              Icons.help_outline_rounded,
            ),
            label: 'Lost',
          ),

          BottomNavigationBarItem(
            icon: Icon(
              Icons.search_rounded,
            ),
            label: 'Found',
          ),

          BottomNavigationBarItem(
            icon: Icon(
              Icons.edit_note_rounded,
            ),
            label: 'Post',
          ),

          BottomNavigationBarItem(
            icon: Icon(
              Icons.person_outline_rounded,
            ),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}