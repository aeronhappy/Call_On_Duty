import 'dart:async';
import 'package:flutter/material.dart';

class TimerWidget extends StatefulWidget {
  @override
  _TimerWidgetState createState() => _TimerWidgetState();
}

class _TimerWidgetState extends State<TimerWidget> {
  //Timers
  late Timer timers;
  int newTimer = 0;
  String displaytime = '00.00';
  bool isPaused = false;

  @override
  void initState() {
    super.initState();
    startTimer();
  }

  void startTimer() {
    if (!isPaused) {
      timers = Timer.periodic(const Duration(milliseconds: 10), ((timer) {
        setState(() {
          newTimer++;
          double min = (newTimer / 100) / 60;
          double secs = ((newTimer / 100) % 60);
          displaytime =
              '${min.toInt().toString().padLeft(2, '0')} : ${secs.toInt().toString().padLeft(2, '0')}';
        });
      }));
    }
  }

  void pauseTimer() {
    timers.cancel();
    isPaused = true;
  }

  void continueTimer() {
    isPaused = false;
    startTimer();
  }

  @override
  void dispose() {
    timers.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(displaytime.toString()),
        TextButton(onPressed: pauseTimer, child: Text("pause")),
        TextButton(onPressed: continueTimer, child: Text("continue"))
      ],
    );
  }
}
