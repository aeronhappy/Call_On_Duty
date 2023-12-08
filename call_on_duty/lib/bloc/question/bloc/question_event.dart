part of 'question_bloc.dart';

abstract class QuestionEvent {}

class GetRandomQuestions extends QuestionEvent {
  final QuestionDifficulty questionDifficulty;
  GetRandomQuestions({required this.questionDifficulty});
}

class GetGameMode extends QuestionEvent {}

class SubmitAnswer extends QuestionEvent {
  final bool isCorrect;
  final bool isCompleted;
  final AnswerModel answerModel;
  SubmitAnswer(
      {required this.isCorrect,
      required this.isCompleted,
      required this.answerModel});
}

class ClickNextPage extends QuestionEvent {}

class ScenarioEnded extends QuestionEvent {}
