import 'dart:io';
import 'package:flutter/material.dart';
import 'package:graduation_project/Services/compression_service.dart';
import 'package:graduation_project/Services/upload_video_service.dart';

class RecordButton extends StatefulWidget {
  final Future<String?> Function() onPressed;
  final String userId;

  const RecordButton({
    super.key,
    required this.onPressed,
    required this.userId,
  });

  @override
  _RecordButtonState createState() => _RecordButtonState();
}

class _RecordButtonState extends State<RecordButton> {
  bool isUploading = false;
  bool isRecording = false;

  Future<void> handleUpload(String? path) async {
    if (path == null || !File(path).existsSync()) {
      debugPrint("❌ No video file selected or file does not exist.");
      return;
    }

    setState(() => isUploading = true);

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
      setState(() => isUploading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ElevatedButton(
          onPressed: isUploading
              ? null
              : () async {
                  setState(() => isRecording = !isRecording);
                  final path = await widget.onPressed();
                  if (!isRecording && path != null) {
                    await handleUpload(path);
                  }
                },
          style: ElevatedButton.styleFrom(
            backgroundColor: isRecording ? Colors.red : Colors.green,
            padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30),
            ),
          ),
          child: isUploading
              ? const CircularProgressIndicator(color: Colors.white)
              : Text(
                  isRecording ? 'Stop' : 'Start',
                  style: const TextStyle(fontSize: 20, color: Colors.white),
                ),
        ),
      ],
    );
  }
}
