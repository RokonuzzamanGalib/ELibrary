import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart'; // ✅ Make sure this import exists

class UserDashboard extends StatelessWidget {
  final String userName;
  final String academicYear;
  final String semester;

  UserDashboard({
    required this.userName,
    required this.academicYear,
    required this.semester,
  });

  // ✅ Book data
  final List<Map<String, String>> books = [
    {
      'title': 'Introduction to Algorithms',
      'image': 'https://example.com/images/algorithms.jpg',
      'link': 'https://example.com/book/1',
    },
    {
      'title': 'Artificial Intelligence',
      'image': 'https://example.com/images/ai.jpg',
      'link': 'https://example.com/book/2',
    },
    {
      'title': 'Data Structures',
      'image': 'https://example.com/images/data-structures.jpg',
      'link': 'https://example.com/book/3',
    },
  ];

  void _logout(BuildContext context) {
    Navigator.pushReplacementNamed(context, '/user_login');
  }

  // ✅ Correct use of url_launcher (no need to redefine the real functions)
  void _launchURL(String url) async {
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri); // uses the real package function
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('User Dashboard'),
        actions: [
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: () => _logout(context),
          )
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Welcome, $userName!',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            Text(
              'Academic Year: $academicYear → Semester: $semester',
              style: TextStyle(color: Colors.grey[700]),
            ),
            SizedBox(height: 20),
            Expanded(
              child: GridView.builder(
                itemCount: books.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 12,
                  mainAxisSpacing: 12,
                  childAspectRatio: 0.75,
                ),
                itemBuilder: (context, index) {
                  final book = books[index];
                  return Card(
                    elevation: 4,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Column(
                      children: [
                        Expanded(
                          child: ClipRRect(
                            borderRadius: BorderRadius.vertical(top: Radius.circular(12)),
                            child: Image.network(
                              book['image']!,
                              fit: BoxFit.cover,
                              width: double.infinity,
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.all(8),
                          child: GestureDetector(
                            onTap: () => _launchURL(book['link']!),
                            child: Text(
                              book['title']!,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Colors.blue,
                                decoration: TextDecoration.underline,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

// ❌ REMOVE THESE ↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓
// They are shadowing the real url_launcher functions. Comment or delete them.

// Future<bool> canLaunchUrl(Uri uri) async {}
// Future<void> launchUrl(Uri uri) async {}
}
