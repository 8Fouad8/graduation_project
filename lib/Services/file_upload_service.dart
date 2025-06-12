// lib/services/file_upload_service.dart
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:http_parser/http_parser.dart';

class FileUploadService {
  final String apiUrl;
  final Dio _dio;

  FileUploadService({required this.apiUrl}) : _dio = Dio();

  Future<Response> uploadFile(File file, String userId) async {
    FormData formData = FormData.fromMap({
      'user_id': userId,
      'cv_file': await MultipartFile.fromFile(
        file.path,
        filename: file.path.split('/').last,
        contentType: MediaType('application', 'pdf'),
      ),
    });

    return await _dio.post(
      apiUrl,
      data: formData,
      options: Options(headers: {'Content-Type': 'multipart/form-data'}),
    );
  }
}
