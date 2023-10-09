part of 'question_bloc.dart';

abstract class QuestionEvent extends Equatable {
  const QuestionEvent();

  @override
  List<Object> get props => [];
}

class GetRandomQuestions extends QuestionEvent {
  final QuestionDifficulty questionDifficulty;
  const GetRandomQuestions({required this.questionDifficulty});
}

class GetGameMode extends QuestionEvent {}
