import 'package:flutter/material.dart';
import 'package:graduation_project/Services/audio_service.dart';
import 'package:graduation_project/Services/camera_service.dart';
import 'package:graduation_project/components/button.dart';
import 'package:graduation_project/components/record_button.dart';
import 'package:graduation_project/components/timer.dart';
import 'package:graduation_project/models/styles.dart';
import 'package:graduation_project/views/evaluation.dart';
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
  late AudioService _audioService ; 
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
  }

  int numbee = 0;
  List<String> gg = ["11", '22', "33"];
  bool isLastQuestion = false;
  bool isRecording = false;

  final GlobalKey<CountdownTimerState> _timerKey =
      GlobalKey<CountdownTimerState>();
//  bool isButtonRed = false ;
// void togglebuttonColor(){
// setState(() {
//   isButtonRed = !isButtonRed ;
// });
// }

  @override
  Widget build(BuildContext context) {
    int time = 0;
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
                      onpressed: () {
                        _timerKey.currentState?.startTimer();
                      },
                    ),
                    const Expanded(child: SizedBox()),

                    // Countdown Timer Widget
                    CountdownTimer(key: _timerKey),
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
                    builder: (context, service, child) {
                      return ElevatedButton(
                          onPressed: () async {
                            if (isRecording) {
                              await _cameraService.startRecording();
                              await _audioService.startRecording() ; 
                            } else {
                              await _cameraService.stopRecording();
                             await _audioService.stopRecording() ;
                            }
                            setState(() {
                              isRecording = !isRecording;
                            });
                          },
                          child: Text(isRecording? "Start" : "Next"));
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
// RecordButton(
//                         userId: '123',
//                         isRecording: service.isRecording,
//                         onPressed: () async {
//                           if (service.isRecording) {
//                             if (numbee < gg.length - 1) {
//                               setState(() {
//                                 numbee++;
//                               });
//                               return await service.stopRecording();
//                             } else {
//                               await service.startRecording();
//                               isLastQuestion = true;
//                               Navigator.push(
//                                 context,
//                                 MaterialPageRoute(
//                                     builder: (context) =>
//                                         Evaluation(time: time)),
//                               );
//                               return null;
//                             }
//                           }
//                           return null;
//                         },
//                       );
