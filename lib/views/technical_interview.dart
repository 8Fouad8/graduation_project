import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:graduation_project/components/button.dart';
import 'package:graduation_project/components/timer.dart';
import 'package:graduation_project/models/styles.dart';
import 'package:graduation_project/views/evaluation_interview.dart';

class TechnicalInterview extends StatefulWidget {
  const TechnicalInterview({super.key});
  @override
  _TechnicalInterviewState createState() => _TechnicalInterviewState();
}
class _TechnicalInterviewState extends State<TechnicalInterview> {
  final GlobalKey<CountdownTimerState> _timerKey =
      GlobalKey<CountdownTimerState>();
  @override
  Widget build(BuildContext context) {
    int time = 0;  // Initialize with default value
    double width = MediaQuery.of(context).size.width * .95;
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colorize.Theme,
          title: Text("Technical Interview", style: Styles.HeaderText()),
        ),
        body: Container(
          decoration: const BoxDecoration(color: Colorize.Theme),
          width: double.infinity,
          child: Column(
            children: [
              Container(
                width: width,
                height: (width / 16)* 9,
                decoration: const BoxDecoration(
                  color: Colorize.white,
                  borderRadius: BorderRadius.all(Radius.circular(30)),
                ),
                child:
                    Image.asset("Assets/robot-3d-illustration-download-i.png"),
              ),
              Padding(
                padding:
                    EdgeInsets.all(MediaQuery.of(context).size.width * .05),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.end,
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
              Text(
                "Maybe print transcription for the questions if we need",
                style: Styles.TitleText(),
              ),
              const Spacer(),
              Container(
                width: MediaQuery.of(context).size.width * .95,
                height: MediaQuery.of(context).size.height * .25,
                decoration: const BoxDecoration(
                  color: Colorize.white,
                  borderRadius: BorderRadius.all(Radius.circular(30)),
                ),
                child:
                    Image.asset("Assets/creative-illustration-default-av.jpg"),
              ),
              Align(
                alignment: Alignment.bottomRight,
                child: Padding(
                  padding:
                      EdgeInsets.all(MediaQuery.of(context).size.width * .05),
                  child: Button(
                    text: "Finish",
                    fontSize: 22,
                    width: 90,
                    navigate: Evaluation(time: time,),
                    onpressed: () {
                      _timerKey.currentState?.stopTimer();
                      time = _timerKey.currentState?.timeLeft ?? 0;
                      if (kDebugMode) {
                        print(time);
                      }
                    },
                  ),
                ),
              ),
            ],
          ),
        ));
  }
}
