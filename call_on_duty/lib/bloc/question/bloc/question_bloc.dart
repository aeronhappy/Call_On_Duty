import 'package:bloc/bloc.dart';
import 'package:call_on_duty/model/answer_model.dart';
import 'package:call_on_duty/repository/question_repository.dart';
import 'package:call_on_duty/types/question_difficulty.dart';
import 'package:call_on_duty/services/contract/i_network_info_services.dart';
import 'package:call_on_duty/widgets/bg_music.dart';
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

    on<ScenarioCompleted>((event, emit) async {
      emit(OpenDescription());
    });

    on<GetGameMode>((event, emit) async {
      try {
        List<QuestionDifficulty> listOfMode = [
          QuestionDifficulty.lesson_1,
          QuestionDifficulty.lesson_2,
          QuestionDifficulty.lesson_3
        ];
        emit(LoadedGameMode(modes: listOfMode));
      } catch (e) {
        emit(FailedQuestion(error: e.toString()));
      }
    });

    on<SubmitAnswer>((event, emit) async {
      try {
        playEffect(event.isCorrect);
        if (event.isCorrect) {
          await Future.delayed(const Duration(milliseconds: 500), () {
            emit(CorrectAnswer(
                isScenarioCompleted: event.isScenarioCompleted,
                answerModel: event.answerModel));
          });
        } else {
          await Future.delayed(const Duration(milliseconds: 500), () {
            emit(WrongAnswer());
          });
        }
      } catch (e) {
        emit(FailedQuestion(error: e.toString()));
      }
    });

    on<ClickNextPage>((event, emit) async {
      try {
        emit(NextPage());
      } catch (e) {
        emit(FailedQuestion(error: e.toString()));
      }
    });

    on<LessonEnd>((event, emit) async {
      try {
        emit(LevelDone());
      } catch (e) {
        emit(FailedQuestion(error: e.toString()));
      }
    });

    on<TimerStart>((event, emit) async {
      try {
        emit(StartTimer());
      } catch (e) {
        emit(FailedQuestion(error: e.toString()));
      }
    });

    on<TimerPause>((event, emit) async {
      try {
        emit(PauseTimer());
      } catch (e) {
        emit(FailedQuestion(error: e.toString()));
      }
    });
  }
}
