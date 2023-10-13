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
      video: 'assets/video/mild_1.mp4',
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
      video: 'assets/video/mild_2.mp4',
      answersId: ['a1', 'a2'],
      choices: <AnswerModel>[
        const AnswerModel(
            id: 'a1', value: 'rest', image: 'assets/icon/alcohol.png'),
        const AnswerModel(
            id: 'a2', value: 'ice packs', image: 'assets/icon/betadine.png'),
        const AnswerModel(
            id: 'a3', value: 'dance', image: 'assets/icon/water.png'),
        const AnswerModel(
            id: 'a4', value: 'cry', image: 'assets/icon/dahon.png'),
      ],
    ),
    QuestionModel(
      id: 'q3',
      text: 'Anong gamot ang dapat niyang gamitin? ',
      difficulty: QuestionDifficulty.mild,
      video: 'assets/video/mild_3.mp4',
      answersId: ['a1', 'a2'],
      choices: <AnswerModel>[
        const AnswerModel(
            id: 'a1',
            value: 'water and soap',
            image: 'assets/icon/alcohol.png'),
        const AnswerModel(
            id: 'a2', value: 'squeeze hand', image: 'assets/icon/betadine.png'),
        const AnswerModel(
            id: 'a3', value: 'towel', image: 'assets/icon/water.png'),
        const AnswerModel(
            id: 'a4', value: 'ice', image: 'assets/icon/dahon.png'),
      ],
    ),
    QuestionModel(
      id: 'q4',
      text: 'Anong gamot ang dapat niyang gamitin? ',
      difficulty: QuestionDifficulty.mild,
      video: 'assets/video/mild_4.mp4',
      answersId: ['a1', 'a2'],
      choices: <AnswerModel>[
        const AnswerModel(
            id: 'a1', value: 'inhalers', image: 'assets/icon/alcohol.png'),
        const AnswerModel(
            id: 'a2', value: 'chair', image: 'assets/icon/betadine.png'),
        const AnswerModel(
            id: 'a3', value: 'running', image: 'assets/icon/water.png'),
        const AnswerModel(
            id: 'a4', value: 'swimming', image: 'assets/icon/dahon.png'),
      ],
    ),

    ///// MODERATE
    QuestionModel(
      id: 'q6',
      text: 'Anong gamot ang dapat niyang gamitin? ',
      difficulty: QuestionDifficulty.moderate,
      video: 'assets/video/moderate_1.mp4',
      answersId: ['a1', 'a2', 'a3', 'a4'],
      choices: <AnswerModel>[
        const AnswerModel(
            id: 'a1',
            value: 'upuan kung saan may hangin(upuan)',
            image: 'assets/icon/alcohol.png'),
        const AnswerModel(
            id: 'a2',
            value: 'luluwagan ang suot.  (Clothes)',
            image: 'assets/icon/betadine.png'),
        const AnswerModel(
            id: 'a3',
            value: 'uminom ng tubig(water)',
            image: 'assets/icon/water.png'),
        const AnswerModel(
            id: 'a4',
            value: 'punasan ang katawan(towel)',
            image: 'assets/icon/dahon.png'),
      ],
    ),
    QuestionModel(
      id: 'q7',
      text: 'Anong gamot ang dapat niyang gamitin? ',
      difficulty: QuestionDifficulty.severe,
      video: 'assets/video/severe_1.mp4',
      answersId: ['a1', 'a2', 'a3', 'a4'],
      choices: <AnswerModel>[
        const AnswerModel(
            id: 'a1', value: 'rest', image: 'assets/icon/alcohol.png'),
        const AnswerModel(
            id: 'a2', value: 'ice', image: 'assets/icon/betadine.png'),
        const AnswerModel(
            id: 'a3', value: 'bandage', image: 'assets/icon/water.png'),
        const AnswerModel(
            id: 'a4', value: 'elevation', image: 'assets/icon/dahon.png'),
        const AnswerModel(
            id: 'a5', value: 'dahon', image: 'assets/icon/betadine.png'),
        const AnswerModel(
            id: 'a6', value: 'tumayo', image: 'assets/icon/water.png'),
        const AnswerModel(
            id: 'a7', value: 'hilutin', image: 'assets/icon/dahon.png'),
      ],
    ),
  ];
}
