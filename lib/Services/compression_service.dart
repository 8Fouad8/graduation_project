import 'dart:io';
import 'package:path/path.dart' as path;
import 'package:video_compress/video_compress.dart';

class CompressService {
  /// Compresses a video and saves it to a permanent directory.
  /// Returns the compressed [File], or throws an exception on failure.
  static Future<File> compressVideo(File originalFile) async {
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

      const String dirPath = "/storage/emulated/0/Movies/MyAppVideos";
      await Directory(dirPath).create(recursive: true);

      final String finalPath = path.join(
        dirPath,
        'video_${DateTime.now().millisecondsSinceEpoch}.mp4',
      );

      final File savedFile = await File(compressedVideo.path!).copy(finalPath);

      // Clean up
      await VideoCompress.deleteAllCache();

      return savedFile;
    } catch (e) {
      throw Exception('Video compression error: $e');
    }
  }
}
