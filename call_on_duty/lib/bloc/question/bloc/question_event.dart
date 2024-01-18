part of 'question_bloc.dart';

abstract class QuestionEvent {}

class GetRandomQuestions extends QuestionEvent {
  final QuestionDifficulty questionDifficulty;
  GetRandomQuestions({required this.questionDifficulty});
}

class GetGameMode extends QuestionEvent {}

class SubmitAnswer extends QuestionEvent {
  final bool isCorrect;
  final bool isScenarioCompleted;
  final AnswerModel answerModel;
  SubmitAnswer(
      {required this.isCorrect,
      required this.isScenarioCompleted,
      required this.answerModel});
}

class ClickNextPage extends QuestionEvent {}

class ScenarioCompleted extends QuestionEvent {}

class LessonEnd extends QuestionEvent {}

class TimerStart extends QuestionEvent {}

class TimerPause extends QuestionEvent {}
