import 'dart:io';
import 'package:flutter/material.dart';
import 'package:graduation_project/Services/api_service.dart';
import 'package:graduation_project/Services/audio_service.dart';
import 'package:graduation_project/Services/camera_service.dart';
import 'package:graduation_project/Services/compression_service.dart';
import 'package:graduation_project/Services/upload_video_service.dart';
import 'package:graduation_project/components/button.dart';
import 'package:graduation_project/components/record_button.dart';
import 'package:graduation_project/models/styles.dart';
import 'package:camera/camera.dart';
import 'package:provider/provider.dart';
import 'dart:math' as math;

class SoftSkillsInterview extends StatefulWidget {
  const SoftSkillsInterview({super.key});

  @override
  _SoftSkillsInterviewState createState() => _SoftSkillsInterviewState();
}

class _SoftSkillsInterviewState extends State<SoftSkillsInterview> {
  late CameraService _cameraService;
  late AudioService _audioService;
  bool isRecording = false;
  String? videoPath;
  String? audioPath;
  String? interviewId;

  int numbee = 0;
  List<String> gg = ["11", '22', "33"];
  bool isLastQuestion = false;

  // @override
  // void dispose() {
  //   _cameraService.disposeController();
  //   super.dispose();
  // }

  @override
  void initState() {
    super.initState();
    _cameraService = CameraService();
    _audioService = AudioService();

    _cameraService.initializeCamera().catchError((e) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(e.toString())),
        );
      });
    });

    _fetchInterviewId(); // 👈 fetch it here
  }

  Future<void> _fetchInterviewId() async {
    try {
      final api = InterviewApiService();
      final response =
          await api.getInterviewIdByUser("334"); // 🔁 use real user ID
      setState(() {
        interviewId = response.interviewId;
      });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Interview ID error: $e")),
      );
    }
  }

Future<String?> _handleInterviewStep() async {
    setState(() => isRecording = true);

    try {
      // Start recording both
      await _audioService.startRecording();
      await _cameraService.startRecording();

      // You can wait here with delay or wait for user input to stop

      await Future.delayed(
          const Duration(seconds: 5)); // ⏳ Replace with your condition

      final audioPath = await _audioService.stopRecording();
      final videoPath = await _cameraService.stopRecording();

      if (videoPath == null || audioPath == null) {
        throw Exception("Recording failed");
      }

      // Compress video
      final compressedVideo =
          await CompressService.compressVideo(File(videoPath));

      // Conditional upload
      if (numbee % 2 == 1) {
        await UploadService.uploadCompressedVideo(
          file: compressedVideo,
          userId: "334",
        );
      }

      // Send to API
      final api = InterviewApiService();
      if (interviewId == null) {
        throw Exception("Interview ID not loaded.");
      }

      final nextQuestion = await api.sendNextQuestion(
        interviewId: interviewId!,
        audioFile: File(audioPath),
        videoFile: compressedVideo,
      );

      setState(() {
        gg.add(nextQuestion.nextQuestionText); // Append next question
        numbee++;
        isLastQuestion = numbee >= gg.length; // Set limit here
      });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error: $e")),
      );
    } finally {
      setState(() => isRecording = false);
    }
  return videoPath; // ✅ make sure videoPath is assigned earlier

  }

  @override
  Widget build(BuildContext context) {
    final String userId = "1234";

    double width = MediaQuery.of(context).size.width * 0.95;
    double height = MediaQuery.of(context).size.height * 0.25;

    return ChangeNotifierProvider.value(
      value: _cameraService,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colorize.Theme,
          title: Text("SoftSkills Interview", style: Styles.HeaderText()),
        ),
        body: Container(
          decoration: const BoxDecoration(color: Colorize.Theme),
          width: double.infinity,
          child: Column(
            children: [
              // Top Robot Image
              Container(
                width: width,
                height: (width / 16) * 9,
                decoration: const BoxDecoration(
                  color: Colorize.white,
                  borderRadius: BorderRadius.all(Radius.circular(30)),
                ),
                child:
                    Image.asset("Assets/robot-3d-illustration-download-i.png"),
              ),

              // Timer & Ready Button
              Padding(
                padding:
                    EdgeInsets.all(MediaQuery.of(context).size.width * 0.05),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    // Ready Button - Starts the Timer
                    Button(
                      text: "Ready",
                      fontSize: 22,
                      width: 90,
                      onpressed: () {},
                    ),
                    const Expanded(child: SizedBox()),

                    // Countdown Timer Widget
                  ],
                ),
              ),

              // Instruction Text
              Text(
                isLastQuestion ? "Interview Completed" : gg[numbee],
                style: Styles.TitleText(),
              ),

              const Spacer(),

              // Camera Preview Container (Fills Completely)
              Container(
                width: width,
                height: height,
                decoration: const BoxDecoration(
                  color: Colorize.white,
                  borderRadius: BorderRadius.all(Radius.circular(30)),
                ),
                child: ClipRRect(
                  borderRadius:
                      BorderRadius.circular(30), // ✅ Keep rounded edges
                  child: Consumer<CameraService>(
                    builder: (context, service, child) {
                      if (service.controller == null ||
                          !service.controller!.value.isInitialized) {
                        return const Center(child: CircularProgressIndicator());
                      }
                      return FittedBox(
                        fit: BoxFit.cover, // ✅ Fills container completely
                        child: Transform(
                          alignment: Alignment.center,
                          transform: Matrix4.rotationY(
                              math.pi), // ✅ Mirror for front cam
                          child: SizedBox(
                            width:
                                service.controller!.value.previewSize!.height,
                            height:
                                service.controller!.value.previewSize!.width,
                            child: CameraPreview(service.controller!),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),

              // Finish Button
              Align(
                alignment: Alignment.bottomRight,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Consumer<CameraService>(
                    builder: (context, service, _) {
                      return RecordButton(
                        userId: userId,
                        onPressed: _handleInterviewStep,
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

                      // return ElevatedButton(
                      //     onPressed: () async {
                      //       if (isRecording) {
                      //         await _cameraService.startRecording();
                      //         await _audioService.startRecording() ; 
                      //       } else {
                      //         await _cameraService.stopRecording();
                      //        await _audioService.stopRecording() ;
                      //       }
                      //       setState(() {
                      //         isRecording = !isRecording;
                      //       });
                      //     },
                      //     child: Text(isRecording? "Next" : "Start"));