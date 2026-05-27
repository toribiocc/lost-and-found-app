import 'package:flutter/material.dart';

import '../services/auth_service.dart';
import '../services/profile_API_service.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final AuthService _authService = AuthService();
  bool isLoading = false;
  String avatarUrl = ProfileApiService.generateRandomProfile();

  void generateRandomProfile() {
    setState(() {
      avatarUrl = ProfileApiService.generateRandomProfile();
    });
  }

  Future<void> registerUser() async {
    if (_nameController.text.trim().isEmpty ||
        _emailController.text.trim().isEmpty ||
        _passwordController.text.trim().isEmpty) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Please fill all fields')));

      return;
    }

    setState(() {
      isLoading = true;
    });

    String? result = await _authService.registerUser(
      username: _nameController.text.trim(),

      email: _emailController.text.trim(),

      password: _passwordController.text.trim(),

      avatarUrl: avatarUrl,
    );

    setState(() {
      isLoading = false;
    });

    if (result == null) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Registration Successful')));

      Navigator.pop(context);
    } else {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(result)));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFFFFFE3),

      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(25),

          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,

            children: [
              SizedBox(height: 40),

              Text(
                'Register',

                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),

              SizedBox(height: 25),

              Center(
                child: Column(
                  children: [
                    CircleAvatar(
                      radius: 55,

                      backgroundImage: NetworkImage(avatarUrl),
                    ),

                    SizedBox(height: 12),

                    ElevatedButton(
                      onPressed: generateRandomProfile,

                      child: Text('Change Avatar'),
                    ),
                  ],
                ),
              ),

              SizedBox(height: 30),

              TextField(
                controller: _nameController,

                decoration: InputDecoration(
                  labelText: 'Username',

                  filled: true,
                  fillColor: Colors.white,

                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                ),
              ),

              SizedBox(height: 20),

              TextField(
                controller: _emailController,

                decoration: InputDecoration(
                  labelText: 'Email',

                  filled: true,
                  fillColor: Colors.white,

                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                ),
              ),

              SizedBox(height: 20),

              TextField(
                controller: _passwordController,

                obscureText: true,

                decoration: InputDecoration(
                  labelText: 'Password',

                  filled: true,
                  fillColor: Colors.white,

                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                ),
              ),

              SizedBox(height: 35),

              SizedBox(
                width: double.infinity,

                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black87,

                    padding: EdgeInsets.symmetric(vertical: 16),

                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                  ),

                  onPressed: registerUser,

                  child: isLoading
                      ? CircularProgressIndicator(color: Colors.white)
                      : Text(
                          'Register',

                          style: TextStyle(color: Colors.white, fontSize: 16),
                        ),
                ),
              ),

              SizedBox(height: 20),

              Center(
                child: TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },

                  child: Text(
                    'Already have an account? Login',

                    style: TextStyle(
                      color: Colors.black87,
                      decoration:
                      TextDecoration.underline,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
