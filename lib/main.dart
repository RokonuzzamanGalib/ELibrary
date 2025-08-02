import 'package:flutter/material.dart';
import 'package:registration_ui_flutter/login.dart';
import 'package:registration_ui_flutter/register.dart';
import 'package:registration_ui_flutter/home.dart'; // Add this line

import 'AdminDashboard.dart';
import 'AdminLogin.dart';
import 'AdminRegister.dart';
import 'UserDashboard.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: HomePage(), // 👈 Set HomePage as the first screen
    routes: {
      'register': (context) => MyRegister(),
      'login': (context) => MyLogin(),
      'admin_login': (context) => AdminLogin(),
      'admin_dashboard': (context) => AdminDashboard(),
      'admin_register': (context) => AdminRegister(),
      'user_dashboard': (context) => UserDashboard(
        userName: '', // Dummy values
        academicYear: '',
        semester: '',
      ),
    },
  ));
}
