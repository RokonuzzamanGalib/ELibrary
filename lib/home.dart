import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Transparent background for image
      backgroundColor: Colors.transparent,
      body: Stack(
        children: [
          // Background Image
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/hop.png'), // <-- Add your image in assets
                fit: BoxFit.cover,
              ),
            ),
          ),

          // Foreground content
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'CSTU E-Library',
                  style: TextStyle(
                    fontSize: 35,
                    fontWeight: FontWeight.w900,
                    color: Color(0x9C448AFF),
                    shadows: [
                    //  Shadow(color: Colors.black, blurRadius: 8, offset: Offset(1, 2)),
                    ],
                  ),
                ),
                SizedBox(height: 100),

                // User Login Button
                ElevatedButton.icon(
                  onPressed: () {
                    Navigator.pushNamed(context, 'login');
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white24,
                    padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                  ),
                  icon: Icon(Icons.person),
                  label: Text("User ", style: TextStyle(fontSize: 18)),
                ),
                SizedBox(height: 20),

                // Admin Login Button
                ElevatedButton.icon(
                  onPressed: () {
                    Navigator.pushNamed(context, 'admin_login');
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white54,
                    padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                  ),
                  icon: Icon(Icons.admin_panel_settings),
                  label: Text("Admin", style: TextStyle(fontSize: 18)),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
