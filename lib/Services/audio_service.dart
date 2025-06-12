import 'dart:io';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:record/record.dart';
import 'package:path/path.dart' as p;

class AudioService with ChangeNotifier {
   final AudioRecorder _recorder = AudioRecorder();
  bool _isRecording = false;
  String? _filePath;

  bool get isRecording => _isRecording;
  String? get filePath => _filePath;

  Future<void> _requestPermissions() async {
    final status = await [
      Permission.microphone,
      Permission.storage,
    ].request();

    if (status.values.any((s) => !s.isGranted)) {
      throw Exception('Microphone and storage permissions are required.');
    }
  }

  Future<String?> startRecording() async {
    if (!await _recorder.hasPermission()) {
      await _requestPermissions();
    }

    final dir = await getExternalStorageDirectory();
    final String dirPath = '${dir!.path}/audio_recordings';
    await Directory(dirPath).create(recursive: true);

    _filePath = p.join(dirPath, 'audio_${DateTime.now().millisecondsSinceEpoch}.opus');

await _recorder.start(
  const RecordConfig(
    encoder: AudioEncoder.opus,
    bitRate: 128000,
    sampleRate: 44100,
  ),
  path: _filePath ?? '',
);

    _isRecording = true;
    notifyListeners();
    return _filePath;
  }

  Future<String?> stopRecording() async {
    if (!_isRecording) return null;

    final path = await _recorder.stop();
    _isRecording = false;
    notifyListeners();

    if (path == null || !(await File(path).exists())) {
      debugPrint("❌ Recording failed or file not found");
      return null;
    }

    _filePath = path;
    return path;
  }

  Future<void> disposeRecorder() async {
    await _recorder.dispose();
  }
}
