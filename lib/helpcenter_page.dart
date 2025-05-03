import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.light(),
      home: HelpCenterScreen(),
    );
  }
}

class HelpCenterScreen extends StatelessWidget {
  HelpCenterScreen({super.key});

  final List<Map<String, dynamic>> topics = [
    {"title": "Account Settings", "icon": Icons.settings},
    {"title": "Login and Password", "icon": Icons.vpn_key},
    {"title": "Privacy and Security", "icon": Icons.lock},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          "Help Center",
          style: TextStyle(
            color: Color(0xFF2C3E73),
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Color(0xFF2C3E73)),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Container(
        margin: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20),
            const Text(
              "How can we help you?",
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Color(0xFF2C3E73),
              ),
            ),
            const SizedBox(height: 20),
            TextField(
              decoration: InputDecoration(
                hintText: "Search help articles...",
                prefixIcon: const Icon(Icons.search, color: Color(0xFF2C3E73)),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: const BorderSide(color: Color(0xFF2C3E73)),
                ),
              ),
            ),
            const SizedBox(height: 30),
            const Text(
              "Popular Topics",
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Color(0xFF2C3E73),
              ),
            ),
            const SizedBox(height: 10),
            Expanded(
              child: ListView.builder(
                itemCount: topics.length,
                itemBuilder: (context, index) {
                  return Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    elevation: 2,
                    child: ListTile(
                      leading: Icon(
                        topics[index]['icon'],
                        color: Color(0xFF2C3E73),
                      ),
                      title: Text(
                        topics[index]['title'],
                        style: const TextStyle(
                          fontSize: 16,
                          color: Color(0xFF2C3E73),
                        ),
                      ),
                      onTap: () {
                        print("${topics[index]['title']} clicked");
                      },
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
}
