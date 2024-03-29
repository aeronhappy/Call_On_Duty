part of 'question_bloc.dart';

abstract class QuestionState {}

class QuestionInitial extends QuestionState {}

class LoadedRandomQuestions extends QuestionState {
  final List<QuestionModel> randomQuestions;
  LoadedRandomQuestions({required this.randomQuestions});
}

class LoadedGameMode extends QuestionState {
  final List<QuestionDifficulty> modes;
  LoadedGameMode({required this.modes});
}

class FailedQuestion extends QuestionState {
  final String error;
  FailedQuestion({required this.error});
}

class LoadingQuestion extends QuestionState {}

class NoNetworkConnection extends QuestionState {}

/////
class NextPage extends QuestionState {}

class WrongAnswer extends QuestionState {}

class CorrectAnswer extends QuestionState {
  final bool isScenarioCompleted;
  final AnswerModel answerModel;
  CorrectAnswer({required this.isScenarioCompleted, required this.answerModel});
}

class OpenDescription extends QuestionState {}

class LevelDone extends QuestionState {}

class StartTimer extends QuestionState {}

class PauseTimer extends QuestionState {}
