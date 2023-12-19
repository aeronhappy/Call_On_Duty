import 'package:call_on_duty/types/question_difficulty.dart';
import 'answer_model.dart';

class QuestionModel {
  final String id;
  final String title;
  final String text;
  final QuestionDifficulty difficulty;
  final String video;
  final List<String> answersId;
  List<AnswerModel> choices;

  QuestionModel({
    required this.id,
    required this.title,
    required this.text,
    required this.difficulty,
    required this.video,
    required this.answersId,
    required this.choices,
  });

  Map toJson() => {
        'id': id,
        'title': title,
        'text': text,
        'difficulty': difficulty.toString(),
        'video': video,
        'answersId': answersId.toList(),
        'choices': choices.toList()
      };

  factory QuestionModel.fromJson(Map<String, dynamic> json) {
    return QuestionModel(
        id: json['id'] as String,
        title: json['title'] as String,
        text: json['text'] as String,
        difficulty: QuestionDifficulty.values[json['difficulty']],
        video: json['video'] as String,
        answersId: json['answersId'] as List<String>,
        choices: (json['choices'] as List)
            .map((e) => AnswerModel.fromJson(e))
            .toList());
  }
}
