import 'dart:io';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
import 'package:video_compress/video_compress.dart';

class CompressService {
  static Future<File> compressVideo(File originalFile) async {
      String? _filePath;


    try {
      final MediaInfo? compressedVideo = await VideoCompress.compressVideo(
        originalFile.path,
        quality: VideoQuality.LowQuality,
        deleteOrigin: true,
        frameRate: 30,
      );

      if (compressedVideo == null || compressedVideo.path == null) {
        throw Exception('Compression failed. Compressed video is null.');
      }

    final dir = await getExternalStorageDirectory();
    final String dirPath = '${dir!.path}/audio_recordings';
    await Directory(dirPath).create(recursive: true);

    _filePath = p.join(dirPath, 'audio_${DateTime.now().millisecondsSinceEpoch}.mp4');

      final File savedFile = await File(compressedVideo.path!).copy(_filePath);

      await VideoCompress.deleteAllCache();

      return savedFile;
    } catch (e) {
      throw Exception('Video compression error: $e');
    }
  }
}
