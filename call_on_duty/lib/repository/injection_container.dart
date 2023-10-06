import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:call_on_duty/bloc/question/bloc/question_bloc.dart';
import 'package:call_on_duty/repository/contract/i_question_repository.dart';
import 'package:call_on_duty/repository/implementation/question_repository.dart';
import 'package:call_on_duty/services/contract/i_network_info_services.dart';
import 'package:call_on_duty/services/implementation/network_info_services.dart';

final GetIt sl = GetIt.instance;

Future<void> init() async {
// Prio
  sl.registerLazySingleton(() => InternetConnectionChecker());
  sl.registerLazySingleton<INetworkInfoServices>(
      () => NetworkInfoServices(sl()));
  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => sharedPreferences);

  //Bloc Registration
  sl.registerFactory(
      () => QuestionBloc(questionRepository: sl(), networkInfoServices: sl()));

  //Repository Registration
  sl.registerLazySingleton<IQuestionRepository>(() => QuestionRepository());
}
