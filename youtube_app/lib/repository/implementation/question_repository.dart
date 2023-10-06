import 'package:dio/dio.dart';

import '../../helper/api_helper.dart';
import '../../model/question_model.dart';
import '../contract/i_question_repository.dart';

class QuestionRepository implements IQuestionRepository {
  @override
  Future<List<QuestionModel>> getRandomQuestions(int numberOfQuestions) async {
    Response response =
        await client.get('api/questions/random?count=$numberOfQuestions');

    if (response.statusCode == 200) {
      List<QuestionModel> randomQuestions = response.data
          .map<QuestionModel>((e) => QuestionModel.fromJson(e))
          .toList();
      return randomQuestions;
    }
    throw Exception();
  }
}
