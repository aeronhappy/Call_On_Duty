import 'package:call_on_duty/bloc/question/bloc/question_bloc.dart';
import 'package:call_on_duty/model/answer_model.dart';
import 'package:call_on_duty/model/question_model.dart';
import 'package:call_on_duty/repository/injection_container.dart';
import 'package:call_on_duty/router/route_type.dart';
import 'package:call_on_duty/types/question_difficulty.dart';
import 'package:call_on_duty/views/correct_video_player.dart';
import 'package:call_on_duty/views/dashboard_page.dart';
import 'package:call_on_duty/views/description_page.dart';
import 'package:call_on_duty/views/game_mode_page.dart';
import 'package:call_on_duty/views/highscore_page.dart';
import 'package:call_on_duty/views/play_time_page.dart';
import 'package:call_on_duty/views/settings_page.dart';
import 'package:call_on_duty/views/video_player.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AppRouter {
  Route onGenerateRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      //Common
      case PageRouter.dashboardPage:
        return MaterialPageRoute(
            builder: ((context) => MultiBlocProvider(
                  providers: [
                    BlocProvider(create: (context) => sl<QuestionBloc>()),
                  ],
                  child: DashboardPage(),
                )));

      case PageRouter.settingPage:
        return MaterialPageRoute(
            builder: ((context) => MultiBlocProvider(
                  providers: [
                    BlocProvider(create: (context) => sl<QuestionBloc>()),
                  ],
                  child: SettingsPage(),
                )));
      case PageRouter.highscorePage:
        return MaterialPageRoute(
            maintainState: false,
            builder: ((context) => MultiBlocProvider(
                  providers: [
                    BlocProvider(create: (context) => sl<QuestionBloc>()),
                  ],
                  child: HighscorePage(),
                )));
      case PageRouter.gameModePage:
        return MaterialPageRoute(
            maintainState: false,
            builder: ((context) => MultiBlocProvider(
                  providers: [
                    BlocProvider(create: (context) => sl<QuestionBloc>()),
                  ],
                  child: GameModePage(),
                )));
      case PageRouter.playPage:
        return MaterialPageRoute(
            builder: ((context) => MultiBlocProvider(
                  providers: [
                    BlocProvider(create: (context) => sl<QuestionBloc>()),
                  ],
                  child: PlayTimePage(
                      questionDifficulty:
                          routeSettings.arguments as QuestionDifficulty),
                )));

      case PageRouter.descriptionPage:
        return MaterialPageRoute(
            maintainState: false,
            builder: ((context) => MultiBlocProvider(
                  providers: [
                    BlocProvider(create: (context) => sl<QuestionBloc>()),
                  ],
                  child: DescriptionPage(
                      questionModel: routeSettings.arguments as QuestionModel),
                )));
      case PageRouter.videoPlayerPage:
        return MaterialPageRoute(
            maintainState: false,
            builder: ((context) => MultiBlocProvider(
                  providers: [
                    BlocProvider(create: (context) => sl<QuestionBloc>()),
                  ],
                  child: VideoPlayerPage(
                      questionModel: routeSettings.arguments as QuestionModel),
                )));

      case PageRouter.correctVideoPlayerPage:
        return MaterialPageRoute(
            maintainState: false,
            builder: ((context) => MultiBlocProvider(
                  providers: [
                    BlocProvider(create: (context) => sl<QuestionBloc>()),
                  ],
                  child: CorrectVideoPlayerPage(
                      answerModel: routeSettings.arguments as AnswerModel),
                )));

      default:
        return MaterialPageRoute(
            maintainState: false,
            builder: ((context) => MultiBlocProvider(
                  providers: [
                    BlocProvider(create: (context) => sl<QuestionBloc>()),
                  ],
                  child: DashboardPage(),
                )));
    }
  }
}
