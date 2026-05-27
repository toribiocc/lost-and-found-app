import 'package:flutter/material.dart';

import '../../services/auth_service.dart';
import '../../services/profile_API_service.dart';
import '../../services/user_service.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() =>
      _ProfileScreenState();
}

class _ProfileScreenState
    extends State<ProfileScreen> {

  final UserService _userService =
  UserService();

  final AuthService _authService =
  AuthService();

  final TextEditingController
  _nameController =
  TextEditingController();

  String avatarUrl = '';

  String email = '';

  bool isLoading = true;

  bool isSaving = false;

  @override
  void initState() {
    super.initState();

    loadUserData();
  }

  Future<void> loadUserData() async {

    final userDoc =
    await _userService.getUserData();

    final userData =
    userDoc.data()
    as Map<String, dynamic>;

    setState(() {

      _nameController.text =
      userData['name'];

      avatarUrl =
      userData['avatarUrl'];

      email =
      userData['email'];

      isLoading = false;
    });
  }

  void generateNewAvatar() {

    setState(() {

      avatarUrl =
          ProfileApiService
              .generateRandomProfile();
    });
  }

  Future<void> saveProfile() async {

    if (_nameController.text
        .trim()
        .isEmpty) {

      ScaffoldMessenger.of(context)
          .showSnackBar(

        SnackBar(
          content: Text(
            'Name cannot be empty',
          ),
        ),
      );

      return;
    }

    setState(() {
      isSaving = true;
    });

    await _userService.updateProfile(

      name:
      _nameController.text.trim(),

      avatarUrl: avatarUrl,
    );

    setState(() {
      isSaving = false;
    });

    ScaffoldMessenger.of(context)
        .showSnackBar(

      SnackBar(
        content: Text(
          'Profile updated',
        ),
      ),
    );
  }

  Future<void> logout() async {

    await _authService.logoutUser();

    Navigator.pushReplacementNamed(
      context,
      '/login',
    );
  }

  @override
  Widget build(BuildContext context) {

    if (isLoading) {

      return Center(
        child:
        CircularProgressIndicator(),
      );
    }

    return SingleChildScrollView(

      physics:
      BouncingScrollPhysics(),

      padding: EdgeInsets.all(20),

      child: Column(

        crossAxisAlignment:
        CrossAxisAlignment.start,

        children: [

          SizedBox(height: 10),

          Container(

            width: double.infinity,

            padding: EdgeInsets.all(24),

            decoration: BoxDecoration(

              color: Colors.white,

              borderRadius:
              BorderRadius.circular(
                28,
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

            child: Column(

              children: [

                CircleAvatar(
                  radius: 60,

                  backgroundImage:
                  NetworkImage(
                    avatarUrl,
                  ),
                ),

                SizedBox(height: 16),

                Text(
                  _nameController.text,

                  style: TextStyle(
                    fontSize: 24,
                    fontWeight:
                    FontWeight.bold,
                    color:
                    Colors.black87,
                  ),
                ),

                SizedBox(height: 6),

                Text(
                  email,

                  style: TextStyle(
                    fontSize: 15,
                    color:
                    Colors.black54,
                  ),
                ),

                SizedBox(height: 20),

                ElevatedButton(

                  style:
                  ElevatedButton
                      .styleFrom(

                    backgroundColor:
                    Colors.black87,

                    padding:
                    EdgeInsets.symmetric(
                      horizontal: 22,
                      vertical: 14,
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
                  generateNewAvatar,

                  child: Text(
                    'Change Avatar',

                    style: TextStyle(
                      color:
                      Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ),

          SizedBox(height: 30),

          Text(
            'Username',

            style: TextStyle(
              fontSize: 16,
              fontWeight:
              FontWeight.bold,
              color: Colors.black87,
            ),
          ),

          SizedBox(height: 10),

          TextField(
            controller:
            _nameController,

            decoration: InputDecoration(

              hintText:
              'Enter username',

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

              onPressed:
              saveProfile,

              child: isSaving
                  ? CircularProgressIndicator(
                color: Colors.white,
              )
                  : Text(
                'Save Profile',

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

          SizedBox(height: 18),

          SizedBox(

            width: double.infinity,

            child: ElevatedButton(

              style:
              ElevatedButton.styleFrom(

                backgroundColor:
                Colors.redAccent,

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

              onPressed: logout,

              child: Text(
                'Logout',

                style: TextStyle(
                  color: Colors.white,
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
    );
  }
}