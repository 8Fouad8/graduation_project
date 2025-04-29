import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:path/path.dart';

class UploadService {
  static final Dio _dio = Dio();
  static const String _uploadUrl = "https://mentorai0-dec3dscpcha4gng2.southafricanorth-01.azurewebsites.net/api/auth/upload-video";

static Future<void> uploadCompressedVideo({
    required File file,
    required String userId,
  }) async {
    final fileName = basename(file.path);

    final formData = FormData.fromMap({
      'user_id': userId,
      'file': await MultipartFile.fromFile(file.path, filename: fileName),
    });

    try {
      final response = await _dio.post(_uploadUrl, data: formData);
      if (response.statusCode != 201) {
        throw Exception('Upload failed with status: ${response.statusCode}');
      }
      if (response.statusCode == 201) {
    if (kDebugMode) {
      print('❤️❤️❤️❤️');
    }
      }
    } catch (e) {
      throw Exception('Upload error: $e');
    }
  }
}
