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
      text:
          'Ang hika ay isang talamak na sakit ng daanan ng hangin sa baga. Sa panahon ng atake ng hika, ang mga daanan ng hangin sa baga ay namamaga, makitid at gumagawa ng dagdag na uhog na ginagawang mahirap huminga.',
      difficulty: QuestionDifficulty.mild,
      video: 'assets/video_question/L1_asthma.mp4',
      answersId: ['a1', 'a2'],
      choices: <AnswerModel>[
        const AnswerModel(
            id: 'a1',
            value: 'Rest',
            image: 'assets/image_choices/rest.png',
            explanation:
                'tulungan ang tao sa isang komportableng posisyon at bigyan siya ng katiyakan.',
            video: 'assets/video_answer/L1_asthma_1.mp4'),
        const AnswerModel(
            id: 'a2',
            value: 'Inhaler',
            image: 'assets/image_choices/inhaler.png',
            explanation: 'makakatulong ito sa pag papaluwag ng pag hinga.',
            video: 'assets/video_answer/L1_asthma_2.mp4'),
        const AnswerModel(
            id: 'a3',
            value: 'Dahon',
            image: 'assets/icon/dahon.png',
            explanation: '',
            video: ''),
        const AnswerModel(
            id: 'a4',
            value: 'Hot Water',
            image: 'assets/image_choices/hot_water.png',
            explanation: '',
            video: ''),
      ],
    ),
    QuestionModel(
      id: 'q2',
      text:
          'Ang lagnat ay karaniwan at normal na tugon upang labanan ang impeksiyon at kadalasang hindi nakakapinsala. ',
      difficulty: QuestionDifficulty.mild,
      video: 'assets/video_question/L1_fever.mp4',
      answersId: ['a1', 'a2'],
      choices: <AnswerModel>[
        const AnswerModel(
            id: 'a1',
            value: 'Paracetamol',
            image: 'assets/image_choices/medicine.png',
            explanation: 'makakatulomg ito upang mawala ang sakit.',
            video: 'assets/video_answer/L1_fever_1.mp4'),
        const AnswerModel(
            id: 'a2',
            value: 'Rest',
            image: 'assets/image_choices/rest.png',
            explanation: 'makakatulong ito sa pag papaluwag ng pag hinga.',
            video: 'assets/video_answer/L1_fever_1.mp4'),
        const AnswerModel(
            id: 'a3',
            value: 'Basketball',
            image: 'assets/icon/dahon.png',
            explanation: '',
            video: ''),
        const AnswerModel(
            id: 'a4',
            value: 'Mobile Games',
            image: 'assets/image_choices/hot_water.png',
            explanation: '',
            video: ''),
      ],
    ),

    ///// MODERATE
    // QuestionModel(
    //   id: 'q6',
    //   text: 'Anong gamot ang dapat niyang gamitin? ',
    //   difficulty: QuestionDifficulty.moderate,
    //   video: 'assets/video/moderate_1.mp4',
    //   answersId: ['a1', 'a2', 'a3', 'a4'],
    //   choices: <AnswerModel>[
    //     const AnswerModel(
    //         id: 'a1',
    //         value: 'upuan kung saan may hangin(upuan)',
    //         image: 'assets/icon/alcohol.png'),
    //     const AnswerModel(
    //         id: 'a2',
    //         value: 'luluwagan ang suot.  (Clothes)',
    //         image: 'assets/icon/betadine.png'),
    //     const AnswerModel(
    //         id: 'a3',
    //         value: 'uminom ng tubig(water)',
    //         image: 'assets/icon/water.png'),
    //     const AnswerModel(
    //         id: 'a4',
    //         value: 'punasan ang katawan(towel)',
    //         image: 'assets/icon/dahon.png'),
    //   ],
    // ),
    // QuestionModel(
    //   id: 'q7',
    //   text: 'Anong gamot ang dapat niyang gamitin? ',
    //   difficulty: QuestionDifficulty.severe,
    //   video: 'assets/video/severe_1.mp4',
    //   answersId: ['a1', 'a2', 'a3', 'a4'],
    //   choices: <AnswerModel>[
    //     const AnswerModel(
    //         id: 'a1', value: 'rest', image: 'assets/icon/alcohol.png'),
    //     const AnswerModel(
    //         id: 'a2', value: 'ice', image: 'assets/icon/betadine.png'),
    //     const AnswerModel(
    //         id: 'a3', value: 'bandage', image: 'assets/icon/water.png'),
    //     const AnswerModel(
    //         id: 'a4', value: 'elevation', image: 'assets/icon/dahon.png'),
    //     const AnswerModel(
    //         id: 'a5', value: 'dahon', image: 'assets/icon/betadine.png'),
    //     const AnswerModel(
    //         id: 'a6', value: 'tumayo', image: 'assets/icon/water.png'),
    //     const AnswerModel(
    //         id: 'a7', value: 'hilutin', image: 'assets/icon/dahon.png'),
    //   ],
    // ),
  ];
}
