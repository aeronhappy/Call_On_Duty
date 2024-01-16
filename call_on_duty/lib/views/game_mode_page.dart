import 'package:call_on_duty/bloc/question/bloc/question_bloc.dart';
import 'package:call_on_duty/designs/colors/app_colors.dart';
import 'package:call_on_duty/designs/fonts/text_style.dart';
import 'package:call_on_duty/repository/injection_container.dart';
import 'package:call_on_duty/types/question_difficulty.dart';
import 'package:call_on_duty/views/answer_page.dart';
import 'package:call_on_duty/views/play_time_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

class GameModePage extends StatefulWidget {
  const GameModePage({super.key});

  @override
  State<GameModePage> createState() => _GameModePageState();
}

class _GameModePageState extends State<GameModePage> {
  List<QuestionDifficulty> gameModes = [];
  bool isModerateModeOpen = false;
  bool isSevereModeOpen = false;

  getModeOpen() async {
    var sharedPref = await SharedPreferences.getInstance();
    isModerateModeOpen = sharedPref.getBool('ModerateMode') ?? false;
    isSevereModeOpen = sharedPref.getBool('SevereMode') ?? false;
  }

  @override
  void initState() {
    super.initState();
    context.read<QuestionBloc>().add(GetGameMode());
    getModeOpen();
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
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.transparent,
        ),
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 20, width: double.infinity),
              Text(
                'GAME MODE',
                textAlign: TextAlign.center,
                style: titleText(30, FontWeight.bold, Colors.white),
              ),
              const SizedBox(height: 50, width: double.infinity),
              Expanded(
                child: ListView.builder(
                  itemCount: gameModes.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 10),
                      child: InkWell(
                        onTap: gameModeConverter(gameModes[index],
                                isModerateModeOpen, isSevereModeOpen)
                            ? () {
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
                                            questionDifficulty:
                                                gameModes[index]),
                                      );
                                    },
                                  ),
                                );
                              }
                            : null,
                        child: Container(
                          height: 50,
                          decoration: ShapeDecoration(
                              color: gameModeConverter(gameModes[index],
                                      isModerateModeOpen, isSevereModeOpen)
                                  ? Colors.white
                                  : Colors.grey,
                              shape: StadiumBorder(side: BorderSide())),
                          child: Stack(
                            children: [
                              gameModeConverter(gameModes[index],
                                      isModerateModeOpen, isSevereModeOpen)
                                  ? Container()
                                  : Positioned(
                                      top: 0,
                                      bottom: 0,
                                      left: 5,
                                      child: CircleAvatar(
                                          child: Icon(Icons.lock))),
                              Center(
                                child: Hero(
                                  tag: gameModes[index].name,
                                  child: Text(
                                    gameConverter(gameModes[index]),
                                    style: bodyText(
                                        18,
                                        FontWeight.w500,
                                        secondaryColor.withOpacity(
                                            gameModeConverter(
                                                    gameModes[index],
                                                    isModerateModeOpen,
                                                    isSevereModeOpen)
                                                ? 1
                                                : .3)),
                                  ),
                                ),
                              ),
                            ],
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

bool gameModeConverter(QuestionDifficulty questionDifficulty,
    bool isModerateModeOpen, bool isSevereModeOpen) {
  if (QuestionDifficulty.lesson_2 == questionDifficulty) {
    return isModerateModeOpen ? true : false;
  }
  if (QuestionDifficulty.lesson_3 == questionDifficulty) {
    return isSevereModeOpen ? true : false;
  }
  return true;
}

String gameConverter(QuestionDifficulty questionDifficulty) {
  String text = "";

  if (questionDifficulty == QuestionDifficulty.lesson_1) {
    text = "LESSON 1";
  }
  if (questionDifficulty == QuestionDifficulty.lesson_2) {
    text = "LESSON 2";
  }
  if (questionDifficulty == QuestionDifficulty.lesson_3) {
    text = "LESSON 3";
  }

  return text;
}
