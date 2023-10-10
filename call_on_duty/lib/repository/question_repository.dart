import 'package:call_on_duty/model/answer_model.dart';
import 'package:call_on_duty/types/question_difficulty.dart';
import '../model/question_model.dart';

abstract class IQuestionRepository {
  Future<List<QuestionModel>> getRandomQuestions(
      QuestionDifficulty questionDifficulty);
  Future<List<QuestionDifficulty>> getMode();
}

class QuestionRepository implements IQuestionRepository {
  @override
  Future<List<QuestionModel>> getRandomQuestions(
      QuestionDifficulty questionDifficulty) async {
    try {
      List<QuestionModel> newQuestions = [];
      listOfQuestion.shuffle();
      for (var item in listOfQuestion) {
        if (item.difficulty == questionDifficulty) {
          newQuestions.add(item);
        }
      }

      for (var item in newQuestions) {
        item.choices.shuffle();
      }
      return newQuestions;
    } on Exception catch (_) {
      throw UnimplementedError();
    }
  }

  @override
  Future<List<QuestionDifficulty>> getMode() async {
    try {
      Set<QuestionDifficulty> mode = {};
      for (var item in listOfQuestion) {
        mode.add(item.difficulty);
      }
      return mode.toList();
    } on Exception catch (_) {
      throw UnimplementedError();
    }
  }

  List<QuestionModel> listOfQuestion = [
    QuestionModel(
      id: 'q1',
      text: 'Anong gamot ang dapat niyang gamitin? ',
      difficulty: QuestionDifficulty.mild,
      video: 'assets/video/video_1.mp4',
      answersId: ['a1', 'a2'],
      choices: <AnswerModel>[
        const AnswerModel(
            id: 'a1', value: 'Alcohol', image: 'assets/icon/alcohol.png'),
        const AnswerModel(
            id: 'a2', value: 'Betadine', image: 'assets/icon/betadine.png'),
        const AnswerModel(
            id: 'a3', value: 'Tubig', image: 'assets/icon/water.png'),
        const AnswerModel(
            id: 'a4', value: 'Dahon', image: 'assets/icon/dahon.png'),
      ],
    ),
    QuestionModel(
      id: 'q2',
      text: 'Anong gamot ang dapat niyang gamitin? ',
      difficulty: QuestionDifficulty.mild,
      video: 'assets/video/video_1.mp4',
      answersId: ['a1', 'a2'],
      choices: <AnswerModel>[
        const AnswerModel(
            id: 'a1', value: 'Alcohol', image: 'assets/icon/alcohol.png'),
        const AnswerModel(
            id: 'a2', value: 'Betadine', image: 'assets/icon/betadine.png'),
        const AnswerModel(
            id: 'a3', value: 'Tubig', image: 'assets/icon/water.png'),
        const AnswerModel(
            id: 'a4', value: 'Dahon', image: 'assets/icon/dahon.png'),
      ],
    ),
    QuestionModel(
      id: 'q3',
      text: 'Anong gamot ang dapat niyang gamitin? ',
      difficulty: QuestionDifficulty.mild,
      video: 'assets/video/video_1.mp4',
      answersId: ['a1', 'a2'],
      choices: <AnswerModel>[
        const AnswerModel(
            id: 'a1', value: 'Alcohol', image: 'assets/icon/alcohol.png'),
        const AnswerModel(
            id: 'a2', value: 'Betadine', image: 'assets/icon/betadine.png'),
        const AnswerModel(
            id: 'a3', value: 'Tubig', image: 'assets/icon/water.png'),
        const AnswerModel(
            id: 'a4', value: 'Dahon', image: 'assets/icon/dahon.png'),
      ],
    ),
    QuestionModel(
      id: 'q4',
      text: 'Anong gamot ang dapat niyang gamitin? ',
      difficulty: QuestionDifficulty.mild,
      video: 'assets/video/video_1.mp4',
      answersId: ['a1', 'a2'],
      choices: <AnswerModel>[
        const AnswerModel(
            id: 'a1', value: 'Alcohol', image: 'assets/icon/alcohol.png'),
        const AnswerModel(
            id: 'a2', value: 'Betadine', image: 'assets/icon/betadine.png'),
        const AnswerModel(
            id: 'a3', value: 'Tubig', image: 'assets/icon/water.png'),
        const AnswerModel(
            id: 'a4', value: 'Dahon', image: 'assets/icon/dahon.png'),
      ],
    ),
    QuestionModel(
      id: 'q5',
      text: 'Anong gamot ang dapat niyang gamitin? ',
      difficulty: QuestionDifficulty.mild,
      video: 'assets/video/video_1.mp4',
      answersId: ['a1', 'a2'],
      choices: <AnswerModel>[
        const AnswerModel(
            id: 'a1', value: 'Alcohol', image: 'assets/icon/alcohol.png'),
        const AnswerModel(
            id: 'a2', value: 'Betadine', image: 'assets/icon/betadine.png'),
        const AnswerModel(
            id: 'a3', value: 'Tubig', image: 'assets/icon/water.png'),
        const AnswerModel(
            id: 'a4', value: 'Dahon', image: 'assets/icon/dahon.png'),
      ],
    ),
    QuestionModel(
      id: 'q6',
      text: 'Anong gamot ang dapat niyang gamitin? ',
      difficulty: QuestionDifficulty.moderate,
      video: 'assets/video/video_1.mp4',
      answersId: ['a1', 'a2'],
      choices: <AnswerModel>[
        const AnswerModel(
            id: 'a1', value: 'Alcohol', image: 'assets/icon/alcohol.png'),
        const AnswerModel(
            id: 'a2', value: 'Betadine', image: 'assets/icon/betadine.png'),
        const AnswerModel(
            id: 'a3', value: 'Tubig', image: 'assets/icon/water.png'),
        const AnswerModel(
            id: 'a4', value: 'Dahon', image: 'assets/icon/dahon.png'),
      ],
    ),
    QuestionModel(
      id: 'q7',
      text: 'Anong gamot ang dapat niyang gamitin? ',
      difficulty: QuestionDifficulty.severe,
      video: 'assets/video/video_1.mp4',
      answersId: ['a1', 'a2'],
      choices: <AnswerModel>[
        const AnswerModel(
            id: 'a1', value: 'Alcohol', image: 'assets/icon/alcohol.png'),
        const AnswerModel(
            id: 'a2', value: 'Betadine', image: 'assets/icon/betadine.png'),
        const AnswerModel(
            id: 'a3', value: 'Tubig', image: 'assets/icon/water.png'),
        const AnswerModel(
            id: 'a4', value: 'Dahon', image: 'assets/icon/dahon.png'),
      ],
    ),
  ];
}
