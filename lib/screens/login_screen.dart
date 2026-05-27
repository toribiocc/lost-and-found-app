import 'package:flutter/material.dart';

import '../services/auth_service.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() =>
      _LoginScreenState();
}

class _LoginScreenState
    extends State<LoginScreen> {

  final _emailController =
  TextEditingController();

  final _passwordController =
  TextEditingController();

  final AuthService _authService =
  AuthService();

  bool isLoading = false;

  Future<void> loginUser() async {

    if (_emailController.text
        .trim()
        .isEmpty ||
        _passwordController.text
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

    String? result =
    await _authService.loginUser(
      email:
      _emailController.text.trim(),

      password:
      _passwordController.text.trim(),
    );

    setState(() {
      isLoading = false;
    });

    if (result == null) {

      ScaffoldMessenger.of(context)
          .showSnackBar(

        SnackBar(
          content: Text(
            'Login Successful',
          ),
        ),
      );

      Navigator.pushReplacementNamed(
        context,
        '/home',
      );

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

    return Scaffold(

      backgroundColor:
      Color(0xFFFFFFE3),

      body: SafeArea(

        child: SingleChildScrollView(

          padding: EdgeInsets.all(25),

          child: Column(

            crossAxisAlignment:
            CrossAxisAlignment.start,

            children: [

              SizedBox(height: 40),

              Center(
                child: Column(

                  children: [

                    Image.asset(
                      'assets/lost-and-found.png',

                      height: 140,
                    ),

                    SizedBox(height: 20),

                    Text(
                      'Lost & Found',

                      style: TextStyle(
                        fontSize: 32,
                        fontWeight:
                        FontWeight.bold,
                        color:
                        Colors.black87,
                      ),
                    ),

                    SizedBox(height: 8),

                    Text(
                      'Bring back what is lost.',

                      style: TextStyle(
                        fontSize: 16,
                        color:
                        Colors.black54,
                      ),
                    ),
                  ],
                ),
              ),

              SizedBox(height: 50),

              Text(
                'Login',

                style: TextStyle(
                  fontSize: 30,
                  fontWeight:
                  FontWeight.bold,
                  color: Colors.black87,
                ),
              ),

              SizedBox(height: 25),

              TextField(
                controller:
                _emailController,

                decoration: InputDecoration(
                  labelText: 'Email',

                  filled: true,
                  fillColor: Colors.white,

                  border:
                  OutlineInputBorder(
                    borderRadius:
                    BorderRadius.circular(
                      14,
                    ),
                  ),
                ),
              ),

              SizedBox(height: 20),

              TextField(
                controller:
                _passwordController,

                obscureText: true,

                decoration: InputDecoration(
                  labelText: 'Password',

                  filled: true,
                  fillColor: Colors.white,

                  border:
                  OutlineInputBorder(
                    borderRadius:
                    BorderRadius.circular(
                      14,
                    ),
                  ),
                ),
              ),

              SizedBox(height: 35),

              SizedBox(
                width: double.infinity,

                child: ElevatedButton(

                  style:
                  ElevatedButton
                      .styleFrom(

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
                        14,
                      ),
                    ),
                  ),

                  onPressed: loginUser,

                  child: isLoading
                      ? CircularProgressIndicator(
                    color: Colors.white,
                  )
                      : Text(
                    'Login',

                    style: TextStyle(
                      color:
                      Colors.white,
                      fontSize: 16,
                    ),
                  ),
                ),
              ),

              SizedBox(height: 20),

              Center(
                child: TextButton(

                  onPressed: () {

                    Navigator.pushNamed(
                      context,
                      '/register',
                    );
                  },

                  child: Text(
                    'Create an account',

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