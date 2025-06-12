import 'dart:io';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

class CameraService with ChangeNotifier {
  CameraController? _controller;
  bool _isRecording = false;

  bool get isRecording => _isRecording;
  CameraController? get controller => _controller;

  Future<void> initializeCamera() async {
    await _requestPermissions();
    final cameras = await availableCameras();
    final frontCamera = cameras.firstWhere(
      (camera) => camera.lensDirection == CameraLensDirection.front,
    );

    _controller = CameraController(
      frontCamera,
      ResolutionPreset.low,
      enableAudio: false,
    );

    await _controller!.initialize();
    notifyListeners();
  }

  Future<void> _requestPermissions() async {
    final statuses = await [
      Permission.camera,
      Permission.microphone,
      Permission.storage,
    ].request();

    if (statuses.values.any((status) => !status.isGranted)) {
      throw Exception('Camera, microphone, and storage permissions are required.');
    }
  }

  Future<void> startRecording() async {
    if (_controller == null || !_controller!.value.isInitialized) return;
    await _controller!.startVideoRecording();
    _isRecording = true;
    notifyListeners();
  }

  Future<String?> stopRecording() async {
    if (_controller == null || !_controller!.value.isRecordingVideo) return null;

    final XFile file = await _controller!.stopVideoRecording();
    _isRecording = false;
    notifyListeners();

    final File videoFile = File(file.path);
    return videoFile.existsSync() ? videoFile.path : null;
  }

  void disposeController() {
    _controller?.dispose();
  }
}
