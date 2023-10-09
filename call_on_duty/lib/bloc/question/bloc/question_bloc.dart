import 'package:bloc/bloc.dart';
import 'package:call_on_duty/repository/question_repository.dart';
import 'package:call_on_duty/types/question_difficulty.dart';
import 'package:equatable/equatable.dart';
import 'package:call_on_duty/services/contract/i_network_info_services.dart';
import '../../../model/question_model.dart';

part 'question_event.dart';
part 'question_state.dart';

class QuestionBloc extends Bloc<QuestionEvent, QuestionState> {
  final IQuestionRepository questionRepository;
  final INetworkInfoServices networkInfoServices;

  QuestionBloc(
      {required this.questionRepository, required this.networkInfoServices})
      : super(QuestionInitial()) {
    on<GetRandomQuestions>((event, emit) async {
      try {
        emit(LoadingQuestion());
        List<QuestionModel> listOfQuestions = await questionRepository
            .getRandomQuestions(event.questionDifficulty);
        emit(LoadedRandomQuestions(randomQuestions: listOfQuestions));
      } catch (e) {
        emit(FailedQuestion(error: e.toString()));
      }
    });

    on<GetGameMode>((event, emit) async {
      try {
        List<QuestionDifficulty> listOfMode =
            await questionRepository.getMode();
        emit(LoadedGameMode(modes: listOfMode));
      } catch (e) {
        emit(FailedQuestion(error: e.toString()));
      }
    });
  }
}
