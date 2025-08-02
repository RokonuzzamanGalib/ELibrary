import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class MyRegister extends StatefulWidget {
  const MyRegister({Key? key}) : super(key: key);

  @override
  _MyRegisterState createState() => _MyRegisterState();
}

class _MyRegisterState extends State<MyRegister> {
  final idController = TextEditingController();
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();
  final academicYearController = TextEditingController();
  final semesterController = TextEditingController();


  Future<void> registerUser() async {
    final id = idController.text.trim();
    final username = usernameController.text.trim();
    final password = passwordController.text.trim();
    final academicYear = academicYearController.text.trim();
    final semester = semesterController.text.trim();

    // Client-side validation
    if (id.isEmpty || username.isEmpty || password.isEmpty) {
      showDialog(
        context: context,
        builder: (_) => AlertDialog(
          title: Text("Missing Field"),
          content: Text("All fields are required."),
        ),
      );
      return;
    }
    if (academicYear.isEmpty || semester.isEmpty) {
      showDialog(
        context: context,
        builder: (_) => AlertDialog(
          title: Text("Missing Field"),
          content: Text("Academic year and semester are required."),
        ),
      );
      return;
    }

    if (password.length > 15) {
      showDialog(
        context: context,
        builder: (_) => AlertDialog(
          title: Text("Password Error"),
          content: Text("Password must be 15 characters or less."),
        ),
      );
      return;
    }

    try {
      //var url = Uri.parse('http://10.0.2.2/flutter_auth/register.php');
      var url = Uri.parse('http://192.168.0.101/flutter_auth/register.php');


      var response = await http.post(url, body: {
        'id': id,
        'username': username,
        'password': password,
        'academic_year': academicYear,
        'semester': semester,
      });

      var jsonResponse = jsonDecode(response.body);

      if (jsonResponse['success']) {
        // Success
        showDialog(
          context: context,
          builder: (_) => AlertDialog(
            title: Text("Registration Successful ✅"),
            content: Text("Welcome, $username!\nPlease login to continue."),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                  Navigator.pushNamed(context, 'login');
                },
                child: Text("Go to Login"),
              )
            ],
          ),
        );
      } else {
        // Server-side error
        showDialog(
          context: context,
          builder: (_) => AlertDialog(
            title: Text("Registration Failed ❌"),
            content: Text(jsonResponse['message']),
          ),
        );
      }
    } catch (e) {
      showDialog(
        context: context,
        builder: (_) => AlertDialog(
          title: Text("Network Error"),
          content: Text("Could not connect to the server."),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/register.png'),
          fit: BoxFit.cover,
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(backgroundColor: Colors.transparent, elevation: 0),
        body: Stack(
          children: [
            Container(
              padding: EdgeInsets.only(left: 35, top: 30),
              child: Text(
                'Create\nAccount',
                style: TextStyle(color: Colors.white, fontSize: 33),
              ),
            ),
            SingleChildScrollView(
              child: Container(
                padding: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height * 0.28),
                margin: EdgeInsets.symmetric(horizontal: 35),
                child: Column(
                  children: [
                    TextField(
                      controller: idController,
                      style: TextStyle(color: Colors.white),
                      decoration: InputDecoration(
                        hintText: "ID",
                        hintStyle: TextStyle(color: Colors.white),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(color: Colors.white),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(color: Colors.black),
                        ),
                      ),
                    ),
                    SizedBox(height: 30),
                    TextField(
                      controller: usernameController,
                      style: TextStyle(color: Colors.white),
                      decoration: InputDecoration(
                        hintText: "Username",
                        hintStyle: TextStyle(color: Colors.white),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(color: Colors.white),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(color: Colors.black),
                        ),
                      ),
                    ),
                    SizedBox(height: 30),
                    TextField(
                      controller: academicYearController,
                      style: TextStyle(color: Colors.white),
                      decoration: InputDecoration(
                        hintText: "Academic Year (e.g. 2024-25)",
                        hintStyle: TextStyle(color: Colors.white),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(color: Colors.white),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(color: Colors.black),
                        ),
                      ),
                    ),
                    SizedBox(height: 30),
                    TextField(
                      controller: semesterController,
                      style: TextStyle(color: Colors.white),
                      decoration: InputDecoration(
                        hintText: "Semester (e.g. Semester 1)",
                        hintStyle: TextStyle(color: Colors.white),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(color: Colors.white),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(color: Colors.black),
                        ),
                      ),
                    ),

                    SizedBox(height: 30),
                    TextField(
                      controller: passwordController,
                      obscureText: true,
                      style: TextStyle(color: Colors.white),
                      decoration: InputDecoration(
                        hintText: "Password",
                        hintStyle: TextStyle(color: Colors.white),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(color: Colors.white),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(color: Colors.black),
                        ),
                      ),
                    ),
                    SizedBox(height: 40),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Sign Up',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 27,
                              fontWeight: FontWeight.w700),
                        ),
                        CircleAvatar(
                          backgroundColor: Color(0xff4c505b),
                          child: IconButton(
                            icon: Icon(Icons.arrow_forward, color: Colors.white),
                            onPressed: registerUser,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 20),
                    TextButton(
                      onPressed: () {
                        Navigator.pushNamed(context, 'login');
                      },
                      child: Text(
                        'Sign In',
                        style: TextStyle(
                          decoration: TextDecoration.underline,
                          color: Colors.white,
                          fontSize: 18,
                        ),
                      ),
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
