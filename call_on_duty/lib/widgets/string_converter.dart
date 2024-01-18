import 'package:call_on_duty/types/question_difficulty.dart';
import 'package:shared_preferences/shared_preferences.dart';

String bloodySpeech(QuestionDifficulty questionDifficulty) {
  if (QuestionDifficulty.lesson_1 == questionDifficulty) {
    return 'Ang Lesson 1 Mode ay laro kung saan may mapapanood kang video at pipili ka lamang ng dalawang tamang sagot ayon sa kelangan ng tao sa video.';
  }
  if (QuestionDifficulty.lesson_2 == questionDifficulty) {
    return 'Ang Lesson 2 Mode ay may apat na pamimilian. Lahat ng ito ay tamang sagot, ngunit kelangan mong piliin ayon sa pag kakasunod-sunod.';
  }
  if (QuestionDifficulty.lesson_3 == questionDifficulty) {
    return 'Ang Lesson 3 Mode ay may anim na pamimilian. Apat ang tama at dalawa ang mali, ngunit kelangan mong piliin ayon sa pag kakasunod-sunod.';
  }
  return '';
}

saveScore(int score, int time, QuestionDifficulty questionDifficulty) async {
  var sharedPref = await SharedPreferences.getInstance();
  String scorePerLesson = "";
  String timePerLesson = "";

  if (questionDifficulty == QuestionDifficulty.lesson_1) {
    scorePerLesson = "lessonOneScore";
    timePerLesson = "lessonOneTime";
  } else if (questionDifficulty == QuestionDifficulty.lesson_2) {
    scorePerLesson = "lessonTwoScore";
    timePerLesson = "lessonTwoTime";
  } else {
    scorePerLesson = "lessonThreeScore";
    timePerLesson = "lessonThreeTime";
  }

  int topScore = await sharedPref.getInt(scorePerLesson) ?? 0;
  int toptime = await sharedPref.getInt(timePerLesson) ?? 0;

  if (topScore < score) {
    await sharedPref.setInt(scorePerLesson, score);
    await sharedPref.setInt(timePerLesson, time);
  } else if (topScore == score) {
    if (toptime > time) {
      await sharedPref.setInt(timePerLesson, time);
    }
  }
}
