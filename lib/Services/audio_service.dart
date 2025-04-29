import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_sound/flutter_sound.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:path/path.dart' as path;

class AudioService with ChangeNotifier {
  final FlutterSoundRecorder _recorder = FlutterSoundRecorder();
  bool _isRecorderInitialized = false;
  bool _isRecording = false;

  AudioService() {
    _initializeRecorder();
  }

  Future<void> _initializeRecorder() async {
    try {
      await _recorder.openRecorder();
      _isRecorderInitialized = true;
    } catch (e) {
      debugPrint('Failed to initialize recorder: $e');
    }
  }

  bool get isRecording => _isRecording;

  Future<void> init() async {
    await _requestPermissions();

    await _recorder.openRecorder();
    _isRecorderInitialized = true;
    notifyListeners();
  }

  Future<void> _requestPermissions() async {
    var status = await [
      Permission.microphone,
      Permission.storage,
    ].request();

    if (status.values.any((s) => !s.isGranted)) {
      throw Exception('Microphone and storage permissions are required.');
    }
  }

  Future<String?> startRecording() async {
    if (!_isRecorderInitialized) await init();

      const String dirPath = "/storage/emulated/0/Movies/MyAppVideos";
      await Directory(dirPath).create(recursive: true);



       String filePath = path.join(
      dirPath,
      'audio_${DateTime.now().millisecondsSinceEpoch}.opus',
    );
Codec codecCross;

if (Platform.isAndroid) {
  codecCross = Codec.opusWebM;
} else if (Platform.isIOS) {
  codecCross = Codec.opusCAF;
} else {
  throw Exception("Unsupported platform");
}
await _recorder.startRecorder(
  toFile: filePath,
  codec: codecCross,
);


    _isRecording = true;
    notifyListeners();
    return filePath;
  }

  Future<String?> stopRecording() async {
    if (!_isRecording) return null;

    final String? path = await _recorder.stopRecorder();
    _isRecording = false;
    notifyListeners();

    if (path == null || !(await File(path).exists())) {
      debugPrint("❌ Recording failed or file not found");
      return null;
    }

    return path;
  }

  void disposeRecorder() {
    _recorder.closeRecorder();
    _isRecorderInitialized = false;
  }
}
