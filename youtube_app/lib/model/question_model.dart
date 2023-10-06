import 'package:call_on_duty/types/question_difficulty.dart';
import 'package:call_on_duty/types/question_type.dart';
import 'answer_model.dart';

class QuestionModel {
  final String id;
  final String text;
  final QuestionType type;
  final QuestionDifficulty difficulty;
  final String answerId;
  final List<AnswerModel>? choices;

  const QuestionModel({
    required this.id,
    required this.text,
    required this.type,
    required this.difficulty,
    required this.answerId,
    required this.choices,
  });

  Map toJson() => {
        'id': id,
        'text': text,
        'type': type.toString(),
        'difficulty': difficulty.toString(),
        'answerId': answerId
      };

  factory QuestionModel.fromJson(Map<String, dynamic> json) {
    return QuestionModel(
        id: json['id'] as String,
        text: json['text'] as String,
        type: QuestionType.values[json['type']],
        difficulty: QuestionDifficulty.values[json['difficulty']],
        answerId: json['answerId'] as String,
        choices: json['choices'] != null
            ? (json['choices'] as List)
                .map((e) => AnswerModel.fromJson(e))
                .toList()
            : null);
  }
}



// class QuestionModel {
//   final String id;
//   final String text;
//   final QuestionType type;
//   final QuestionDifficulty difficulty;
//   final String answerId;
//   final List<AnswerModel> choices;
//   const QuestionModel({
//     required this.id,
//     required this.text,
//     required this.type,
//     required this.difficulty,
//     required this.answerId,
//     required this.choices,
//   });
// }

// List<QuestionModel> questions = <QuestionModel>[
//   const QuestionModel(
//       id: 'q1',
//       text: 'Pray everyday, Everyday ok.',
//       type: QuestionType.trueOfFalse,
//       difficulty: QuestionDifficulty.easy,
//       answerId: 'c1',
//       choices: <AnswerModel>[
//         AnswerModel(id: 'c1', value: 'true'),
//         AnswerModel(id: 'c2', value: 'false')
//       ]),
//   const QuestionModel(
//       id: 'q2',
//       text: 'If you hate someone, Kill them.',
//       type: QuestionType.trueOfFalse,
//       difficulty: QuestionDifficulty.easy,
//       answerId: 'c2',
//       choices: <AnswerModel>[
//         AnswerModel(id: 'c1', value: 'true'),
//         AnswerModel(id: 'c2', value: 'false')
//       ]),
//   const QuestionModel(
//       id: 'q3',
//       text:
//           'Making love to your neighbors even if you\'re not in a relationship.',
//       type: QuestionType.trueOfFalse,
//       difficulty: QuestionDifficulty.easy,
//       answerId: 'c2',
//       choices: <AnswerModel>[
//         AnswerModel(id: 'c1', value: 'true'),
//         AnswerModel(id: 'c2', value: 'false')
//       ]),
//   const QuestionModel(
//       id: 'q4',
//       text: 'If you wake up in the morning, what will you do first ?',
//       type: QuestionType.multipleChoice,
//       difficulty: QuestionDifficulty.easy,
//       answerId: 'cm3',
//       choices: <AnswerModel>[
//         AnswerModel(id: 'cm1', value: 'magsilos'),
//         AnswerModel(id: 'cm2', value: 'take a bath'),
//         AnswerModel(id: 'cm3', value: 'pray'),
//         AnswerModel(id: 'cm4', value: 'choke duck')
//       ]),
//   const QuestionModel(
//       id: 'q5',
//       text: 'If you wake up in the morning, what will you do first ?',
//       type: QuestionType.multipleChoice,
//       difficulty: QuestionDifficulty.easy,
//       answerId: 'cm3',
//       choices: <AnswerModel>[
//         AnswerModel(id: 'cm1', value: 'magsilos'),
//         AnswerModel(id: 'cm2', value: 'take a bath'),
//         AnswerModel(id: 'cm3', value: 'pray'),
//         AnswerModel(id: 'cm4', value: 'choke duck')
//       ]),
//   const QuestionModel(
//       id: 'q6',
//       text: 'If you wake up in the morning, what will you do first ?',
//       type: QuestionType.multipleChoice,
//       difficulty: QuestionDifficulty.easy,
//       answerId: 'cm3',
//       choices: <AnswerModel>[
//         AnswerModel(id: 'cm1', value: 'magsilos'),
//         AnswerModel(id: 'cm2', value: 'take a bath'),
//         AnswerModel(id: 'cm3', value: 'pray'),
//         AnswerModel(id: 'cm4', value: 'choke duck')
//       ]),
//   const QuestionModel(
//       id: 'q7',
//       text: 'If you wake up in the morning, what will you do first ?',
//       type: QuestionType.multipleChoice,
//       difficulty: QuestionDifficulty.easy,
//       answerId: 'cm3',
//       choices: <AnswerModel>[
//         AnswerModel(id: 'cm1', value: 'magsilos'),
//         AnswerModel(id: 'cm2', value: 'take a bath'),
//         AnswerModel(id: 'cm3', value: 'pray'),
//         AnswerModel(id: 'cm4', value: 'choke duck')
//       ]),
//   const QuestionModel(
//       id: 'q8',
//       text: 'If you wake up in the morning, what will you do first ?',
//       type: QuestionType.multipleChoice,
//       difficulty: QuestionDifficulty.easy,
//       answerId: 'cm3',
//       choices: <AnswerModel>[
//         AnswerModel(id: 'cm1', value: 'magsilos'),
//         AnswerModel(id: 'cm2', value: 'take a bath'),
//         AnswerModel(id: 'cm3', value: 'pray'),
//         AnswerModel(id: 'cm4', value: 'choke duck')
//       ]),
//   const QuestionModel(
//       id: 'q9',
//       text: 'If you wake up in the morning, what will you do first ?',
//       type: QuestionType.multipleChoice,
//       difficulty: QuestionDifficulty.easy,
//       answerId: 'cm3',
//       choices: <AnswerModel>[
//         AnswerModel(id: 'cm1', value: 'magsilos'),
//         AnswerModel(id: 'cm2', value: 'take a bath'),
//         AnswerModel(id: 'cm3', value: 'pray'),
//         AnswerModel(id: 'cm4', value: 'choke duck')
//       ]),
//   const QuestionModel(
//       id: 'q10',
//       text: 'If you wake up in the morning, what will you do first ?',
//       type: QuestionType.multipleChoice,
//       difficulty: QuestionDifficulty.easy,
//       answerId: 'cm3',
//       choices: <AnswerModel>[
//         AnswerModel(id: 'cm1', value: 'magsilos'),
//         AnswerModel(id: 'cm2', value: 'take a bath'),
//         AnswerModel(id: 'cm3', value: 'pray'),
//         AnswerModel(id: 'cm4', value: 'choke duck')
//       ]),
// ];
