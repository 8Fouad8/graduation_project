import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

class LoginController {
  static final Dio _dio = Dio(
    BaseOptions(
      baseUrl: "https://mentorai0-dec3dscpcha4gng2.uaenorth-01.azurewebsites.net/",
      connectTimeout: const Duration(seconds: 10),
      receiveTimeout: const Duration(seconds: 10),
      headers: {
        'Content-Type': 'application/json',
      },
    ),
  );

  static Future<bool> loginUser({
    required String email,
    required String password,
  }) async {
    const String endpoint = "/api/auth/signin";

    try {
      final response = await _dio.post(
        endpoint,
        data: {
          "email": email,
          "password": password,
        },
      );

      if (response.statusCode == 200) {
        if (kDebugMode) {
          print('Login successful: ${response.data}');
        }
        return true;
      } else {
        if (kDebugMode) {
          print('Failed to login: ${response.data}');
        }
        return false;
      }
    } on DioException catch (e) {
      if (e.response != null) {
        if (kDebugMode) {
          print('Dio error response: ${e.response?.data}');
        }
      } else {
        if (kDebugMode) {
          print('Dio error: ${e.message}');
        }
      }
      return false;
    } catch (e) {
      if (kDebugMode) {
        print('Unexpected error: $e');
      }
      return false;
    }
  }
}
