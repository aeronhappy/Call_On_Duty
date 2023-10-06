part of 'question_bloc.dart';

abstract class QuestionState extends Equatable {
  const QuestionState();
  @override
  List<Object> get props => [];
}

class QuestionInitial extends QuestionState {}

class LoadedRandomQuestions extends QuestionState {
  final List<QuestionModel> randomQuestions;
  const LoadedRandomQuestions({required this.randomQuestions});
}

class FailedQuestion extends QuestionState {
  final String error;
  const FailedQuestion({required this.error});
}

class LoadingQuestion extends QuestionState {}

class NoNetworkConnection extends QuestionState {}
