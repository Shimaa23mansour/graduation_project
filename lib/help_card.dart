import 'package:flutter/material.dart';

class HelpCard extends StatelessWidget {
  final String image;
  final Widget readyVideoPage; // صفحة الفيديو
  final Widget chatPage; // صفحة الشات

  const HelpCard({
    super.key,
    required this.image,
    required this.readyVideoPage,
    required this.chatPage,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        image: DecorationImage(
          image: AssetImage(image),
          fit: BoxFit.cover,
          colorFilter: ColorFilter.mode(
            Colors.black.withOpacity(0.4),
            BlendMode.darken,
          ),
        ),
      ),
      child: Column(
        children: [
          const SizedBox(height: 100), //
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => readyVideoPage),
                  );
                },
                style: ElevatedButton.styleFrom(backgroundColor: Colors.blue),
                child: const Text("Select Video"),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => chatPage),
                  );
                },
                style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
                child: const Text("Upload"),
              ),
            ],
          ),
          const SizedBox(height: 10),
        ],
      ),
    );
  }
}
