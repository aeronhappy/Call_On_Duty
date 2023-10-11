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
  SubmitAnswer({required this.isCorrect, required this.isCompleted});
}

class ClickNextPage extends QuestionEvent {}
