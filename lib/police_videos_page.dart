import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class PoliceVideosPage extends StatefulWidget {
  const PoliceVideosPage({Key? key}) : super(key: key);

  @override
  State<PoliceVideosPage> createState() => _PoliceVideosPageState();
}

class _PoliceVideosPageState extends State<PoliceVideosPage> {
  VideoPlayerController? _controller;
  bool _isLoading = false;
  int? _selectedVideoIndex;

  final List<Map<String, String>> videoData = [
    {'url': 'assets/police1.mp4', 'label': 'Help: My car was stolen'},
    {'url': 'assets/police2.mp4', 'label': 'Help me I have been fraud'},
    {'url': 'assets/police3.mp4', 'label': 'Help a fight in the street'},
  ];

  Future<void> _playVideo(String videoUrl, int index) async {
    setState(() {
      _isLoading = true;
      _selectedVideoIndex = index;
    });

    try {
      if (_controller != null) await _controller!.dispose();
      _controller = VideoPlayerController.asset(videoUrl);
      await _controller!.initialize();
      await _controller!.play();
      setState(() => _isLoading = false);
    } catch (e) {
      setState(() => _isLoading = false);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to load video: ${e.toString()}')),
      );
    }
  }

  void _confirmAndSendVideo() {
    if (_controller != null && _controller!.value.isInitialized) {
      showDialog(
        context: context,
        builder:
            (_) => AlertDialog(
              title: const Text('Confirm Send'),
              content: const Text('Are you sure you want to send this video?'),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text('Cancel'),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Video sent successfully!')),
                    );
                  },
                  child: const Text('Yes'),
                ),
              ],
            ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please select a video first')),
      );
    }
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Police Videos')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            if (_controller != null && _controller!.value.isInitialized)
              Column(
                children: [
                  AspectRatio(
                    aspectRatio: _controller!.value.aspectRatio,
                    child: VideoPlayer(_controller!),
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton.icon(
                    onPressed: _isLoading ? null : _confirmAndSendVideo,
                    icon: const Icon(Icons.send),
                    label: const Text('Send Video'),
                  ),
                  const SizedBox(height: 24),
                ],
              )
            else
              const Padding(
                padding: EdgeInsets.only(bottom: 16),
                child: Text('Select a video to play'),
              ),
            const Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Available Videos:',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(height: 8),
            Expanded(
              child: ListView.builder(
                itemCount: videoData.length,
                itemBuilder: (context, index) {
                  final video = videoData[index];
                  final isSelected = _selectedVideoIndex == index;
                  return Card(
                    color: isSelected ? Colors.lightBlue[50] : Colors.white,
                    shape: RoundedRectangleBorder(
                      side:
                          isSelected
                              ? const BorderSide(color: Colors.blue, width: 2)
                              : BorderSide.none,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    margin: const EdgeInsets.symmetric(vertical: 8),
                    child: ListTile(
                      leading: const Icon(Icons.play_circle_fill, size: 40),
                      title: Text(video['label']!),
                      onTap: () => _playVideo(video['url']!, index),
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
