part of 'question_bloc.dart';

abstract class QuestionEvent {}

class GetRandomQuestions extends QuestionEvent {
  final QuestionDifficulty questionDifficulty;
  GetRandomQuestions({required this.questionDifficulty});
}

class GetGameMode extends QuestionEvent {}

class SubmitAnswer extends QuestionEvent {
  final bool isCorrect;
  SubmitAnswer({required this.isCorrect});
}

class ClickNextPage extends QuestionEvent {}
