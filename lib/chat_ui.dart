import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:video_player/video_player.dart';
import 'dart:io';

class ChatUI extends StatefulWidget {
  const ChatUI({Key? key}) : super(key: key);

  @override
  State<ChatUI> createState() => _ChatUIState();
}

class _ChatUIState extends State<ChatUI> {
  final ImagePicker _picker = ImagePicker();
  VideoPlayerController? _controller;
  XFile? _videoFile;
  bool _isUploading = false;

  // دالة لفتح الكاميرا واختيار فيديو
  Future<void> _pickVideoFromCamera() async {
    final XFile? video = await _picker.pickVideo(
      source: ImageSource.camera,
      maxDuration: const Duration(minutes: 5),
    );

    if (video != null) {
      setState(() {
        _videoFile = video;
        _controller = VideoPlayerController.file(File(video.path))
          ..initialize().then((_) {
            setState(() {}); // إعادة بناء الشاشة بعد تحميل الفيديو
          });
      });
      print('تم تسجيل الفيديو: ${video.path}');
    } else {
      print('لم يتم اختيار أي فيديو');
    }
  }

  // دالة لاختيار الفيديو من المعرض
  Future<void> _pickVideoFromGallery() async {
    final XFile? video = await _picker.pickVideo(
      source: ImageSource.gallery,
      maxDuration: const Duration(minutes: 5),
    );

    if (video != null) {
      setState(() {
        _videoFile = video;
        _controller = VideoPlayerController.file(File(video.path))
          ..initialize().then((_) {
            setState(() {}); // إعادة بناء الشاشة بعد تحميل الفيديو
          });
      });
      print('تم اختيار الفيديو من المعرض: ${video.path}');
    } else {
      print('لم يتم اختيار أي فيديو من المعرض');
    }
  }

  // دالة لإرسال الفيديو
  void _sendVideo() async {
    if (_videoFile != null) {
      setState(() {
        _isUploading = true; // تفعيل مؤشر التحميل
      });

      try {
        // هنا يتم إرسال الفيديو إلى الشات (بناءً على الخلفية)
        // يمكن استبدال هذا الجزء بعملية إرسال الفيديو الفعلي
        await Future.delayed(Duration(seconds: 2)); // لمحاكاة عملية رفع الفيديو

        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text("تم إرسال الفيديو بنجاح!")));

        setState(() {
          _isUploading = false;
          _videoFile = null; // تفريغ المكان بعد الإرسال
          _controller?.dispose(); // تحرير الموارد
          _controller = null;
        });
      } catch (e) {
        setState(() {
          _isUploading = false; // إيقاف مؤشر التحميل
        });
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text("فشل إرسال الفيديو: $e")));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF2E3E3E),
      appBar: AppBar(
        backgroundColor: const Color(0xFF2E3E3E),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            const Expanded(
              child: Center(
                child: Text(
                  "What can I help with?",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 22,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
            if (_controller != null && _controller!.value.isInitialized)
              Container(
                height: 200,
                child: Column(
                  children: [
                    VideoPlayer(_controller!),
                    Text(
                      "Video duration: ${_controller!.value.duration.inSeconds} seconds",
                    ),
                  ],
                ),
              ),
            Padding(
              padding: const EdgeInsets.all(12),
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      height: 45,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Row(
                        children: [
                          const Expanded(
                            child: TextField(
                              decoration: InputDecoration(
                                hintText: 'Type a message',
                                border: InputBorder.none,
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: _pickVideoFromGallery,
                            child: const Icon(Icons.photo_library, size: 20),
                          ),
                          const SizedBox(width: 8),
                          GestureDetector(
                            onTap: _pickVideoFromCamera,
                            child: const Icon(Icons.camera_alt, size: 20),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  ElevatedButton(
                    onPressed:
                        _isUploading || _videoFile == null
                            ? null
                            : _sendVideo, // Disable if uploading or no video
                    child:
                        _isUploading
                            ? const CircularProgressIndicator(
                              color: Colors.white,
                            ) // Loading indicator
                            : const Text('Send Video'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      foregroundColor: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
