import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'userDashboard.dart';

class MyLogin extends StatefulWidget {
  const MyLogin({super.key});

  @override
  _MyLoginState createState() => _MyLoginState();
}

class _MyLoginState extends State<MyLogin> {
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();

  Future<void> loginUser() async {
    final username = usernameController.text.trim();
    final password = passwordController.text.trim();

    // Validation
    if (username.isEmpty || password.isEmpty) {
      showDialog(
        context: context,
        builder: (_) => AlertDialog(
          title: Text("Missing Field"),
          content: Text("Both username and password are required."),
        ),
      );
      return;
    }

    try {
      var url = Uri.parse('http://10.0.2.2/flutter_auth/login.php');

      var response = await http.post(url, body: {
        'username': username,
        'password': password,
      });

      var jsonResponse = jsonDecode(response.body);

      if (jsonResponse['success']) {
        // ✅ Login Success Dialog
        showDialog(
          context: context,
          builder: (_) => AlertDialog(
            title: Text("Login Successful ✅"),
            content: Text("Welcome back, $username!"),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context); // Close dialog first
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (_) => UserDashboard(
                        userName: username,
                        academicYear: jsonResponse['academic_year'],
                        semester: jsonResponse['semester'],
                      ),
                    ),
                  );

                },
                child: Text("OK"),
              )
            ],
          ),
        );
      } else {
        // ❌ Wrong username or password
        showDialog(
          context: context,
          builder: (_) => AlertDialog(
            title: Text("Login Failed ❌"),
            content: Text(jsonResponse['message'] ?? 'Login failed'),
          ),
        );

      }
    } catch (e) {
      showDialog(
        context: context,
        builder: (_) => AlertDialog(
          title: Text("Network Error"),
          content: Text("Unable to connect to the server."),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image:
        DecorationImage(image: AssetImage('assets/userlogin.png'), fit: BoxFit.cover),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Stack(
          children: [
            Container(
              padding: EdgeInsets.only(left: 35, top: 130),
              child: Text(
                'Welcome\nBack',
                style: TextStyle(color: Colors.deepPurple, fontSize: 33),
              ),
            ),
            SingleChildScrollView(
              child: Container(
                padding:
                EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.5),
                margin: EdgeInsets.symmetric(horizontal: 35),
                child: Column(
                  children: [
                    TextField(
                      controller: usernameController,
                      style: TextStyle(color: Colors.black),
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.grey.shade100,
                        hintText: "Username",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                    SizedBox(height: 30),
                    TextField(
                      controller: passwordController,
                      obscureText: true,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.grey.shade100,
                        hintText: "Password",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                    SizedBox(height: 40),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Sign in',
                          style:
                          TextStyle(
                              color: Colors.black,
                              fontSize: 27, fontWeight: FontWeight.w700),
                        ),
                        CircleAvatar(
                          backgroundColor: Color(0xff4c505b),
                          child: IconButton(
                            icon: Icon(Icons.arrow_forward, color: Colors.white),
                            onPressed: loginUser,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 40),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        TextButton(
                          onPressed: () {
                            Navigator.pushNamed(context, 'register');
                          },
                          child: Text(
                            'Sign Up',
                            style: TextStyle(
                                decoration: TextDecoration.underline,
                                fontSize: 18),
                          ),
                        ),
                        TextButton(
                          onPressed: () {
                            // Implement forgot password later
                          },
                          child: Text(
                            'Forgot Password',
                            style: TextStyle(
                                decoration: TextDecoration.underline,
                                fontSize: 18),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
