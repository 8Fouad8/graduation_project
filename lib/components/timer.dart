import 'dart:async';
import 'package:flutter/material.dart';
import 'package:graduation_project/models/styles.dart';

class CountdownTimer extends StatefulWidget {
  @override
  final Key? key;

  const CountdownTimer({this.key}) : super(key: key);

  @override
  CountdownTimerState createState() => CountdownTimerState();
}

class CountdownTimerState extends State<CountdownTimer> {
  int _timeLeft = 0;
  int get timeLeft => _timeLeft;
  Timer? _timer;
  bool _isRunning = false;

  /// Formats time as MM:SS (e.g., 00:05)
  String get formattedTime {
    int minutes = _timeLeft ~/ 60;
    int seconds = _timeLeft % 60;
    return "${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}";
  }

  /// Start the timer when "Ready" is pressed
  void startTimer() {
    if (!_isRunning) {
      _isRunning = true;
      _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
        setState(() {
          _timeLeft++;
        });
      });
    }
  }

  /// Stop the timer
  void stopTimer() {
    _timer?.cancel();
    _isRunning = false;
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          formattedTime,
          style: const TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.bold,
              color: Colorize.SecondColor),
        ),
        const Text( 
          " / 30:00",
          style: TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.bold,
              color: Colorize.ThirdColor),
        )
      ],
    );
  }
}
