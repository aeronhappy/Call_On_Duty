import 'dart:async';

import 'package:call_on_duty/bloc/question/bloc/question_bloc.dart';
import 'package:call_on_duty/designs/colors/app_colors.dart';
import 'package:call_on_duty/designs/fonts/text_style.dart';
import 'package:call_on_duty/model/question_model.dart';
import 'package:call_on_duty/repository/injection_container.dart';
import 'package:call_on_duty/types/question_difficulty.dart';
import 'package:call_on_duty/views/game_mode_page.dart';
import 'package:call_on_duty/views/video_player.dart';
import 'package:call_on_duty/widgets/bg_music.dart';
import 'package:call_on_duty/widgets/unlock_level_popup.dart';
import 'package:call_on_duty/widgets/wrong_answer_popup.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PlayTimePage extends StatefulWidget {
  final QuestionDifficulty questionDifficulty;
  const PlayTimePage({super.key, required this.questionDifficulty});

  @override
  State<PlayTimePage> createState() => _PlayTimePageState();
}

class _PlayTimePageState extends State<PlayTimePage> {
  //Timers
  late Timer timers;
  int newTimer = 0;
  String displaytime = '00.00';
  // bool isPaused = true;

  int myScore = 0;

  PageController pageController = PageController();
  List<QuestionModel> listOfQuestion = [];
  int questionIndex = 0;
  List<int> indexList = [];
  int indexCount = 1;
  bool isBloodyDone = false;
  bool isTutorialOpen = false;
  bool isScenarioCompleted = false;
  bool isLessonCompleted = false;

  @override
  void initState() {
    super.initState();
    context
        .read<QuestionBloc>()
        .add(GetRandomQuestions(questionDifficulty: widget.questionDifficulty));
    textToSpeech(bloodySpeech(widget.questionDifficulty));
    timers = Timer.periodic(const Duration(milliseconds: 0), ((timer) {}));
  }

  @override
  void dispose() {
    super.dispose();
    speechStop();
    timers.cancel();
  }

  void startTimer() {
    timers = Timer.periodic(const Duration(milliseconds: 10), ((timer) {
      setState(() {
        newTimer++;
        double min = (newTimer / 100) / 60;
        double secs = ((newTimer / 100) % 60);
        displaytime =
            '${min.toInt().toString().padLeft(2, '0')} : ${secs.toInt().toString().padLeft(2, '0')}';
      });
    }));
  }

  speech(QuestionModel question) async {
    playMusicLowVolume();
    await flutterTts
        .setVoice({"name": "fil-ph-x-fie-local", "locale": "fil-PH"});
    await flutterTts.setSpeechRate(.5);
    await flutterTts.setPitch(.7);
    await flutterTts.speak(question.text +
        "Sagutan kung anong kailangan gawin o kailangan gamitin ng pasyente.");
    await flutterTts.awaitSpeakCompletion(true).whenComplete(() {
      playMusic();
    });
  }

  answerSpeech(String text) async {
    playMusicLowVolume();
    await flutterTts
        .setVoice({"name": "fil-ph-x-fie-local", "locale": "fil-PH"});
    await flutterTts.setSpeechRate(.5);
    await flutterTts.setPitch(.7);
    await flutterTts.speak(text);
    await flutterTts.awaitSpeakCompletion(true).whenComplete(() {
      playMusic();
    });
  }

  void playVideo(String video) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) {
          return MultiBlocProvider(
            providers: [
              BlocProvider(
                create: (context) => QuestionBloc(
                    questionRepository: sl(), networkInfoServices: sl()),
              ),
            ],
            child: VideoPlayerPage(video: video),
          );
        },
      ),
    );
  }

  String bloodySpeech(QuestionDifficulty questionDifficulty) {
    if (QuestionDifficulty.lesson_1 == questionDifficulty) {
      return 'Ang Lesson 1 Mode ay laro kung saan may mapapanood kang video at pipili ka lamang ng dalawang tamang sagot ayon sa kelangan ng tao sa video.';
    }
    if (QuestionDifficulty.lesson_2 == questionDifficulty) {
      return 'Ang Lesson 2 Mode ay may apat na pamimilian. Lahat ng ito ay tamang sagot, ngunit kelangan mong piliin ayon sa pag kakasunod-sunod.';
    }
    if (QuestionDifficulty.lesson_3 == questionDifficulty) {
      return 'Ang Lesson 3 Mode ay may anim na pamimilian. Apat ang tama at dalawa ang mali, ngunit kelangan mong piliin ayon sa pag kakasunod-sunod.';
    }
    return '';
  }

  saveScore(int score, int time, QuestionDifficulty questionDifficulty) async {
    var sharedPref = await SharedPreferences.getInstance();
    String scorePerLesson = "";
    String timePerLesson = "";

    if (questionDifficulty == QuestionDifficulty.lesson_1) {
      scorePerLesson = "lessonOneScore";
      timePerLesson = "lessonOneTime";
    } else if (questionDifficulty == QuestionDifficulty.lesson_2) {
      scorePerLesson = "lessonTwoScore";
      timePerLesson = "lessonTwoTime";
    } else {
      scorePerLesson = "lessonThreeScore";
      timePerLesson = "lessonThreeTime";
    }

    int topScore = await sharedPref.getInt(scorePerLesson) ?? 0;
    int toptime = await sharedPref.getInt(timePerLesson) ?? 0;

    if (topScore < score) {
      await sharedPref.setInt(scorePerLesson, score);
      await sharedPref.setInt(timePerLesson, time);
    } else if (topScore == score) {
      if (toptime > time) {
        await sharedPref.setInt(timePerLesson, time);
      }
    }
  }

/////////////////
/////////////////
/////////////////

  @override
  Widget build(BuildContext context) {
    return BlocListener<QuestionBloc, QuestionState>(
        listener: (context, state) {
          if (state is LoadedRandomQuestions) {
            setState(() {
              listOfQuestion = state.randomQuestions;
            });
          }
          if (state is CorrectAnswer) {
            setState(() {
              myScore = myScore + 10;
            });
            playVideo(state.answerModel.video);
          }
          if (state is WrongAnswer) {
            setState(() {
              newTimer = newTimer + 5;
              myScore = myScore - 5;
            });

            wrongAnswerDialog(context);
          }
          if (state is NextPage) {
            setState(() {
              isScenarioCompleted = false;
            });
            if (indexCount != listOfQuestion.length) {
              pageController.nextPage(
                  duration: Duration(milliseconds: 200), curve: Curves.easeIn);
            } else {
              unlockLevelDialog(context, widget.questionDifficulty);
              saveScore(myScore, newTimer, widget.questionDifficulty);
            }
          }
        },
        child: Scaffold(
            body: Stack(
          children: [
            Positioned(
                height: MediaQuery.of(context).size.height,
                child: Opacity(
                    opacity: .2,
                    child: Image.asset("assets/icon/splash_screen.png"))),
            Container(
              color: transparentBlackColor,
              child: SafeArea(
                child: PageView.builder(
                    controller: pageController,
                    physics: NeverScrollableScrollPhysics(),
                    onPageChanged: (index) {
                      setState(() {
                        questionIndex = index;
                        indexList.clear();
                        indexCount++;
                      });
                      playVideo(listOfQuestion[index].video);
                    },
                    itemCount: listOfQuestion.length,
                    itemBuilder: (context, questionIndex) {
                      return Column(
                        children: [
                          SizedBox(height: 20),
                          Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.alarm,
                                  size: 40,
                                  color: Colors.white,
                                ),
                                SizedBox(width: 10),
                                Text(displaytime,
                                    style: bodyText(
                                        24, FontWeight.w500, Colors.white)),
                                SizedBox(width: 20),
                              ]),
                          Padding(
                            padding: EdgeInsets.all(20),
                            child: Container(
                              padding: EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(12),
                                  color: Colors.white),
                              child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text(
                                        listOfQuestion.isEmpty
                                            ? "No"
                                            : listOfQuestion[questionIndex]
                                                .title
                                                .toUpperCase(),
                                        style: bodyText(20, FontWeight.bold,
                                            Colors.redAccent)),
                                  ]),
                            ),
                          ),
                          Expanded(
                            child: Center(
                              child: GridView.builder(
                                  shrinkWrap: true,
                                  physics: const NeverScrollableScrollPhysics(),
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 20),
                                  gridDelegate:
                                      const SliverGridDelegateWithMaxCrossAxisExtent(
                                          maxCrossAxisExtent: 200,
                                          childAspectRatio: 1.2,
                                          crossAxisSpacing: 30,
                                          mainAxisSpacing: 30),
                                  itemCount: listOfQuestion[questionIndex]
                                      .choices
                                      .length,
                                  itemBuilder: (context, answerIndex) {
                                    return Draggable(
                                      data: answerIndex,
                                      child: AnimatedOpacity(
                                          opacity:
                                              indexList.contains(answerIndex)
                                                  ? 0
                                                  : 1,
                                          duration: Duration(milliseconds: 500),
                                          child: Column(
                                            mainAxisSize: MainAxisSize.max,
                                            children: [
                                              CircleAvatar(
                                                radius: 60,
                                                backgroundColor: Colors.black45,
                                                child: Padding(
                                                  padding: EdgeInsets.all(10),
                                                  child: Image.asset(
                                                    listOfQuestion[
                                                            questionIndex]
                                                        .choices[answerIndex]
                                                        .image,
                                                    fit: BoxFit.cover,
                                                  ),
                                                ),
                                              ),
                                              SizedBox(height: 10),
                                              Text(
                                                listOfQuestion[questionIndex]
                                                    .choices[answerIndex]
                                                    .value,
                                                style: titleText(
                                                    14,
                                                    FontWeight.w500,
                                                    Colors.white),
                                              ),
                                            ],
                                          )),
                                      feedback: CircleAvatar(
                                          radius: 50,
                                          backgroundColor: Colors.black45,
                                          child: Image.asset(
                                            listOfQuestion[questionIndex]
                                                .choices[answerIndex]
                                                .image,
                                            height: 100,
                                          )),
                                      childWhenDragging: Container(),
                                    );
                                  }),
                            ),
                          ),
                          Positioned(
                            bottom: 0,
                            left: 0,
                            right: 0,
                            child: DragTarget<int>(
                              onAccept: (data) {
                                if (QuestionDifficulty.lesson_1 ==
                                    widget.questionDifficulty) {
                                  mildSubmitAnswer(questionIndex, data);
                                }
                                if (QuestionDifficulty.lesson_2 ==
                                    widget.questionDifficulty) {
                                  moderateSubmitAnswer(questionIndex, data);
                                }
                                if (QuestionDifficulty.lesson_3 ==
                                    widget.questionDifficulty) {
                                  severeSubmitAnswer(questionIndex, data);
                                }
                              },
                              builder: (context, candidateData, rejectedData) {
                                return Container(
                                  height: 80,
                                  color: candidateData.isEmpty
                                      ? Colors.grey
                                      : Colors.red,
                                  child: Center(
                                    child: Text(
                                      candidateData.isEmpty
                                          ? 'Drag here your answer'
                                          : 'Drop here your answer',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 24,
                                      ),
                                    ),
                                  ),
                                );
                              },
                            ),
                          )
                        ],
                      );
                    }),
              ),
            ),

            //////
            //////
            //////

            Container(
              height: MediaQuery.of(context).size.height,
              child: Image.asset(
                "assets/icon/splash_screen.png",
                fit: BoxFit.fitHeight,
              ),
            ),
          ],
        )));
  }

//////////////
//////////////
//////////////

  void mildSubmitAnswer(int questionIndex, int answerIndex) {
    if (listOfQuestion[questionIndex]
        .answersId
        .contains(listOfQuestion[questionIndex].choices[answerIndex].id)) {
      setState(() {
        indexList.add(answerIndex);
      });

      context.read<QuestionBloc>().add(SubmitAnswer(
          isCorrect: true,
          isCompleted: indexList.length == 2 ? true : false,
          answerModel: listOfQuestion[questionIndex].choices[answerIndex]));
    } else {
      context.read<QuestionBloc>().add(SubmitAnswer(
          isCorrect: false,
          isCompleted: false,
          answerModel: listOfQuestion[questionIndex].choices[answerIndex]));
    }
  }

  void moderateSubmitAnswer(int questionIndex, int answerIndex) {
    if (indexList.isEmpty &&
        listOfQuestion[questionIndex].answersId[0] ==
            listOfQuestion[questionIndex].choices[answerIndex].id) {
      setState(() {
        indexList.add(answerIndex);
      });
      context.read<QuestionBloc>().add(SubmitAnswer(
          isCorrect: true,
          isCompleted: false,
          answerModel: listOfQuestion[questionIndex].choices[answerIndex]));
    } else if (indexList.length == 1 &&
        listOfQuestion[questionIndex].answersId[1] ==
            listOfQuestion[questionIndex].choices[answerIndex].id) {
      setState(() {
        indexList.add(answerIndex);
      });
      context.read<QuestionBloc>().add(SubmitAnswer(
          isCorrect: true,
          isCompleted: false,
          answerModel: listOfQuestion[questionIndex].choices[answerIndex]));
    } else if (indexList.length == 2 &&
        listOfQuestion[questionIndex].answersId[2] ==
            listOfQuestion[questionIndex].choices[answerIndex].id) {
      setState(() {
        indexList.add(answerIndex);
      });
      context.read<QuestionBloc>().add(SubmitAnswer(
          isCorrect: true,
          isCompleted: false,
          answerModel: listOfQuestion[questionIndex].choices[answerIndex]));
    } else if (indexList.length == 3 &&
        listOfQuestion[questionIndex].answersId[3] ==
            listOfQuestion[questionIndex].choices[answerIndex].id) {
      setState(() {
        indexList.add(answerIndex);
      });
      context.read<QuestionBloc>().add(SubmitAnswer(
          isCorrect: true,
          isCompleted: true,
          answerModel: listOfQuestion[questionIndex].choices[answerIndex]));
    } else {
      context.read<QuestionBloc>().add(SubmitAnswer(
          isCorrect: false,
          isCompleted: false,
          answerModel: listOfQuestion[questionIndex].choices[answerIndex]));
    }
  }

  void severeSubmitAnswer(int questionIndex, int answerIndex) {
    if (indexList.isEmpty &&
        listOfQuestion[questionIndex].answersId[0] ==
            listOfQuestion[questionIndex].choices[answerIndex].id) {
      setState(() {
        indexList.add(answerIndex);
      });
      context.read<QuestionBloc>().add(SubmitAnswer(
          isCorrect: true,
          isCompleted: false,
          answerModel: listOfQuestion[questionIndex].choices[answerIndex]));
    } else if (indexList.length == 1 &&
        listOfQuestion[questionIndex].answersId[1] ==
            listOfQuestion[questionIndex].choices[answerIndex].id) {
      setState(() {
        indexList.add(answerIndex);
      });
      context.read<QuestionBloc>().add(SubmitAnswer(
          isCorrect: true,
          isCompleted: false,
          answerModel: listOfQuestion[questionIndex].choices[answerIndex]));
    } else if (indexList.length == 2 &&
        listOfQuestion[questionIndex].answersId[2] ==
            listOfQuestion[questionIndex].choices[answerIndex].id) {
      setState(() {
        indexList.add(answerIndex);
      });
      context.read<QuestionBloc>().add(SubmitAnswer(
          isCorrect: true,
          isCompleted: false,
          answerModel: listOfQuestion[questionIndex].choices[answerIndex]));
    } else if (indexList.length == 3 &&
        listOfQuestion[questionIndex].answersId[3] ==
            listOfQuestion[questionIndex].choices[answerIndex].id) {
      setState(() {
        indexList.add(answerIndex);
      });
      context.read<QuestionBloc>().add(SubmitAnswer(
          isCorrect: true,
          isCompleted: true,
          answerModel: listOfQuestion[questionIndex].choices[answerIndex]));
    } else {
      context.read<QuestionBloc>().add(SubmitAnswer(
          isCorrect: false,
          isCompleted: false,
          answerModel: listOfQuestion[questionIndex].choices[answerIndex]));
    }
  }
}
