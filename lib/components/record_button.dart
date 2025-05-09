import 'dart:io';
import 'package:flutter/material.dart';
import 'package:graduation_project/Services/compression_service.dart';
import 'package:graduation_project/Services/upload_video_service.dart';

class RecordButton extends StatefulWidget {
  final bool isRecording;
  final Future<String?> Function() onPressed; // Changed to async callback that returns the file path
  final String userId;

  const RecordButton({
    super.key,
    required this.onPressed,
    required this.userId,
    this.isRecording = false,
  });

  @override
  // ignore: library_private_types_in_public_api
  _RecordButtonState createState() => _RecordButtonState();
}

class _RecordButtonState extends State<RecordButton> {
  bool isUploading = false;

  Future<void> handleUpload(String? path) async {
    if (path == null || !File(path).existsSync()) {
      debugPrint("❌ No video file selected or file does not exist.");
      return;
    }

    setState(() {
      isUploading = true;
    });

    try {
      final compressedFile = await CompressService.compressVideo(File(path));
      await UploadService.uploadCompressedVideo(
        file: compressedFile,
        userId: widget.userId,
      );
      debugPrint("✅ Video uploaded successfully");
    } catch (e) {
      debugPrint("❌ Error during upload: $e");
    } finally {
      setState(() {
        isUploading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ElevatedButton(
          onPressed: () async {
            final path = await widget.onPressed(); // Await stop/start recording and get path
            if (path != null && !widget.isRecording) {
              await handleUpload(path); // Upload only after stopping
            }
          },
          style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
            backgroundColor: widget.isRecording ? Colors.green : Colors.red,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30),
            ),
          ),
          child: Text(
            widget.isRecording ? 'Start' : 'Next',
            style: const TextStyle(fontSize: 20, color: Colors.white),
          ),
        ),

      ],
    );
  }
}
