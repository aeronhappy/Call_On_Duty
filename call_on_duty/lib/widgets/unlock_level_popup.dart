import 'package:call_on_duty/designs/colors/app_colors.dart';
import 'package:call_on_duty/designs/fonts/text_style.dart';
import 'package:call_on_duty/types/question_difficulty.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

unlockLevelDialog(BuildContext context, QuestionDifficulty questionDifficulty) {
  void unlockNextLevel(QuestionDifficulty questionDifficulty) async {
    var sharedPref = await SharedPreferences.getInstance();

    if (QuestionDifficulty.lesson_1 == questionDifficulty) {
      sharedPref.setBool('ModerateMode', true);
    }
    if (QuestionDifficulty.lesson_2 == questionDifficulty) {
      sharedPref.setBool('SevereMode', true);
    }
  }

  String unlockMode(QuestionDifficulty questionDifficulty) {
    if (QuestionDifficulty.lesson_1 == questionDifficulty) {
      return 'You unlock Lesson 2 Mode.';
    }
    if (QuestionDifficulty.lesson_2 == questionDifficulty) {
      return 'You unlock Lesson 3 Mode.';
    }
    return '';
  }

  showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => Center(
            child: Container(
              margin: EdgeInsets.all(20),
              padding: EdgeInsets.all(20),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20), color: Colors.white),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Image.asset('assets/icon/trophy.png'),
                  SizedBox(height: 10),
                  Text(
                    'Congratulations',
                    style: titleText(30, FontWeight.bold, Colors.black),
                  ),
                  SizedBox(height: 5),
                  Text(
                    unlockMode(questionDifficulty),
                    style: titleText(14, FontWeight.w500, Colors.black54),
                  ),
                  SizedBox(height: 10),
                  Material(
                    shape: StadiumBorder(),
                    child: InkWell(
                      onTap: () {
                        unlockNextLevel(questionDifficulty);
                        Navigator.pop(context);
                        Navigator.pop(context);
                      },
                      child: Container(
                        margin:
                            EdgeInsets.symmetric(vertical: 10, horizontal: 40),
                        height: 50,
                        decoration: ShapeDecoration(
                            shape: StadiumBorder(), color: secondaryColor),
                        child: Center(
                          child: Text(
                            'Continue',
                            style: titleText(16, FontWeight.w500, Colors.white),
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                ],
              ),
            ),
          ));
}
