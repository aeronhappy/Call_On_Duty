import 'package:call_on_duty/bloc/question/bloc/question_bloc.dart';
import 'package:call_on_duty/designs/colors/app_colors.dart';
import 'package:call_on_duty/designs/fonts/text_style.dart';
import 'package:call_on_duty/repository/injection_container.dart';
import 'package:call_on_duty/types/question_difficulty.dart';
import 'package:call_on_duty/views/play_time_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class GameModePage extends StatefulWidget {
  const GameModePage({super.key});

  @override
  State<GameModePage> createState() => _GameModePageState();
}

class _GameModePageState extends State<GameModePage> {
  List<QuestionDifficulty> gameModes = [];

  @override
  void initState() {
    super.initState();
    context.read<QuestionBloc>().add(GetGameMode());
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<QuestionBloc, QuestionState>(
      listener: (context, state) {
        if (state is LoadedGameMode) {
          setState(() {
            gameModes = state.modes;
          });
        }
      },
      child: Scaffold(
        backgroundColor: secondaryColor,
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 100, width: double.infinity),
              Text(
                'GAME MODE',
                textAlign: TextAlign.center,
                style: titleText(24, FontWeight.bold, Colors.white),
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: gameModes.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 5),
                      child: InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) {
                                return MultiBlocProvider(
                                  providers: [
                                    BlocProvider(
                                      create: (context) => QuestionBloc(
                                          questionRepository: sl(),
                                          networkInfoServices: sl()),
                                    ),
                                  ],
                                  child: PlayTimePage(
                                      questionDifficulty: gameModes[index]),
                                );
                              },
                            ),
                          );
                        },
                        child: Container(
                          height: 50,
                          decoration: const ShapeDecoration(
                              color: Colors.white,
                              shape: StadiumBorder(side: BorderSide())),
                          child: Center(
                            child: Text(
                              gameModes[index].name.toUpperCase(),
                              style:
                                  bodyText(18, FontWeight.w500, secondaryColor)
                                      .copyWith(),
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

// String gameModeConverter(QuestionDifficulty questionDifficulty) {
//   if (questionDifficulty == QuestionDifficulty.mild) {
//     return 'Mild';
//   }
//   if(questionDifficulty == QuestionDifficulty.moderate){
//     return ''
//   }
// }
