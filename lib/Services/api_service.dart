import 'dart:io';
import 'package:dio/dio.dart';

class StartInterviewRequest {
  final String userId;
  final String topic;
  final List<String> subtopics;

  StartInterviewRequest({
    required this.userId,
    required this.topic,
    required this.subtopics,
  });

  Map<String, dynamic> toJson() => {
        'user_id': userId,
        'topic': topic,
        'subtopics': "machine learning",
      };
}

class StartInterviewResponse {
  // final String message;
  // final String sessionId;
  final String firstQuestion;

  StartInterviewResponse({
    // required this.message,
    // required this.sessionId,
    required this.firstQuestion,
  });

  factory StartInterviewResponse.fromJson(Map<String, dynamic> json) {
    return StartInterviewResponse(
      // message: json['message'],
      // sessionId: json['session_id'],
      firstQuestion: json['first_question'],
    );
  }
}

class InterviewIdByUserResponse {
  final String interviewId;
  // final String sessionId;

  InterviewIdByUserResponse({
    required this.interviewId,
    // required this.sessionId,
  });

  factory InterviewIdByUserResponse.fromJson(Map<String, dynamic> json) {
    return InterviewIdByUserResponse(
      interviewId: json['interview_id'],
      // sessionId: json['session_id'],
    );
  }
}

// class FullInterview {
//   final String id;  
//   final String sessionId;
//   final List<dynamic> questions;

//   FullInterview({
//     required this.id,
//     required this.sessionId,
//     required this.questions,
//   });

//   factory FullInterview.fromJson(Map<String, dynamic> json) {
//     return FullInterview(
//       id: json['_id'],
//       sessionId: json['session_id'],
//       questions: json['questions'],
//     );
//   }
// }

class NextQuestionResponse {
  // final String message;
 // final int nextQuestionId;
  final String nextQuestionText;
  final String interviewId;

  NextQuestionResponse({
    // required this.message,
  //  required this.nextQuestionId,
    required this.nextQuestionText,
    required this.interviewId,
  });
  
  factory NextQuestionResponse.fromJson(Map<String, dynamic> json) {
    return NextQuestionResponse(
      // message: json['message'],
    //  nextQuestionId: json['next_question_id'],
      nextQuestionText: json['next_question_text'],
      interviewId: json['interview_id'],
    );
  }
}

// class FinishInterviewResponse {
//   final String message;
//   final Map<String, dynamic> finalReport;

//   FinishInterviewResponse({
//     required this.message,
//     required this.finalReport,
//   });

//   factory FinishInterviewResponse.fromJson(Map<String, dynamic> json) {
//     return FinishInterviewResponse(
//       message: json['message'],
//       finalReport: json['final_report'],
//     );
//   }
// }

class InterviewApiService {
  final Dio _dio = Dio(BaseOptions(baseUrl: 'https://e9a7-156-194-64-23.ngrok-free.app'));

  Future<StartInterviewResponse> startInterview(StartInterviewRequest request) async {
    final response = await _dio.post(
      '/interviews/start',
      data: FormData.fromMap(request.toJson()),
    );
    return StartInterviewResponse.fromJson(response.data);
  }

  Future<InterviewIdByUserResponse> getInterviewIdByUser(String userId) async {
    final response = await _dio.get('/interviews/id/by_user/$userId');
    return InterviewIdByUserResponse.fromJson(response.data);
  }

  // Future<FullInterview> getFullInterview(String interviewId) async {
  //   final response = await _dio.get('/interviews/$interviewId');
  //   return FullInterview.fromJson(response.data);
  // }

  Future<NextQuestionResponse> sendNextQuestion({
    required String interviewId,
    required File audioFile,
    File? videoFile,
  }) async {
    final formData = FormData.fromMap({
      'interview_id': interviewId,
      'audio_file': await MultipartFile.fromFile(audioFile.path),
      if (videoFile != null) 'video_file': await MultipartFile.fromFile(videoFile.path),
    });

    final response = await _dio.post('/interviews/next_question', data: formData);
    return NextQuestionResponse.fromJson(response.data);
  }

//   Future<FinishInterviewResponse> finishInterview(String interviewId) async {
//     final response = await _dio.post('/interviews/finish/$interviewId');
//     return FinishInterviewResponse.fromJson(response.data);
//   }
 }

