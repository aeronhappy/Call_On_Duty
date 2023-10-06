part of 'question_bloc.dart';

abstract class QuestionEvent extends Equatable {
  const QuestionEvent();

  @override
  List<Object> get props => [];
}

class GetRandomQuestions extends QuestionEvent {
  final int numberOfQuestions;
  const GetRandomQuestions({required this.numberOfQuestions});
}
