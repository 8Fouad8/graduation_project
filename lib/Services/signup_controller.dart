import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

class SignupController {
  static final Dio _dio = Dio(
    BaseOptions(
      baseUrl: "https://mentorai-be-a9c7hnevhpgzh0fv.canadacentral-01.azurewebsites.net",
      connectTimeout: const Duration(seconds: 10),
      receiveTimeout: const Duration(seconds: 10),
      headers: {
        'Content-Type': 'application/json',
      },
    ),
  );

  static Future<bool> registerUser({
    required String name,
    required String email,
    required String password,
  }) async {
    const String endpoint = "/api/auth/signup";

    try {
      final response = await _dio.post(
        endpoint,
        data: {
          "name": name,
          "email": email,
          "password": password,
        },
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        if (kDebugMode) {
          print('User registered successfully: ${response.data}');
        }
        return true;
      } else {
        if (kDebugMode) {
          print('Failed to register user: ${response.data}');
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
