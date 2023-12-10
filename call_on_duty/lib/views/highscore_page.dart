import 'package:call_on_duty/designs/colors/app_colors.dart';
import 'package:call_on_duty/designs/fonts/text_style.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HighscorePage extends StatefulWidget {
  const HighscorePage({super.key});

  @override
  State<HighscorePage> createState() => _HighscorePageState();
}

class _HighscorePageState extends State<HighscorePage> {
  int lesson1Score = 0;
  int lesson2Score = 0;
  int lesson3Score = 0;

  int lesson1Time = 0;
  int lesson2Time = 0;
  int lesson3Time = 0;

  @override
  void initState() {
    super.initState();

    getScore();
  }

  getScore() async {
    var sharedPref = await SharedPreferences.getInstance();

    lesson1Score = await sharedPref.getInt('lessonOneScore') ?? 0;
    lesson2Score = await sharedPref.getInt('lessonTwoScore') ?? 0;
    lesson3Score = await sharedPref.getInt('lessonThreeScore') ?? 0;

    lesson1Time = await sharedPref.getInt('lessonOneTime') ?? 0;
    lesson2Time = await sharedPref.getInt('lessonTwoTime') ?? 0;
    lesson3Time = await sharedPref.getInt('lessonThreeTime') ?? 0;

    setState(() {});
  }

  String timeConverter(int time) {
    double min = (time / 100) / 60;
    double secs = ((time / 100) % 60);
    return '${min.toInt().toString().padLeft(2, '0')} : ${secs.toInt().toString().padLeft(2, '0')}';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: secondaryColor,
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 50, width: double.infinity),
            Text(
              'Highscore',
              textAlign: TextAlign.center,
              style: titleText(24, FontWeight.bold, Colors.white),
            ),
            SizedBox(height: 20),
            Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width * .3,
                    child: Center(
                      child: Text("Rank",
                          style: titleText(18, FontWeight.w500, Colors.white)),
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width * .2,
                    child: Center(
                      child: Text("Time",
                          style: titleText(18, FontWeight.w500, Colors.white)),
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width * .2,
                    child: Center(
                      child: Text("Score",
                          style: titleText(18, FontWeight.w500, Colors.white)),
                    ),
                  ),
                ]),
            SizedBox(height: 20),
            Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width * .3,
                    child: Center(
                      child: Text("LESSON 1",
                          style: titleText(18, FontWeight.w500, Colors.white)),
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width * .2,
                    child: Center(
                      child: Text(timeConverter(lesson1Time),
                          style: titleText(18, FontWeight.w500, Colors.white)),
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width * .2,
                    child: Center(
                      child: Text(lesson1Score.toString(),
                          style: titleText(18, FontWeight.w500, Colors.white)),
                    ),
                  ),
                ]),
            SizedBox(height: 20),
            Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width * .3,
                    child: Center(
                      child: Text("LESSON 2",
                          style: titleText(18, FontWeight.w500, Colors.white)),
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width * .2,
                    child: Center(
                      child: Text(timeConverter(lesson2Time),
                          style: titleText(18, FontWeight.w500, Colors.white)),
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width * .2,
                    child: Center(
                      child: Text(lesson2Score.toString(),
                          style: titleText(18, FontWeight.w500, Colors.white)),
                    ),
                  ),
                ]),
            SizedBox(height: 20),
            Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width * .3,
                    child: Center(
                      child: Text("LESSON 3",
                          style: titleText(18, FontWeight.w500, Colors.white)),
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width * .2,
                    child: Center(
                      child: Text(timeConverter(lesson3Time),
                          style: titleText(18, FontWeight.w500, Colors.white)),
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width * .2,
                    child: Center(
                      child: Text(lesson3Score.toString(),
                          style: titleText(18, FontWeight.w500, Colors.white)),
                    ),
                  ),
                ]),
          ],
        ),
      ),
    );
  }
}
