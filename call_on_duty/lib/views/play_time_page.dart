import 'dart:async';

import 'package:call_on_duty/bloc/question/bloc/question_bloc.dart';
import 'package:call_on_duty/designs/colors/app_colors.dart';
import 'package:call_on_duty/designs/fonts/text_style.dart';
import 'package:call_on_duty/model/answer_model.dart';
import 'package:call_on_duty/model/question_model.dart';
import 'package:call_on_duty/router/route_type.dart';
import 'package:call_on_duty/types/question_difficulty.dart';
import 'package:call_on_duty/views/game_mode_page.dart';
import 'package:call_on_duty/widgets/bg_music.dart';
import 'package:call_on_duty/widgets/string_converter.dart';
import 'package:call_on_duty/widgets/unlock_level_popup.dart';
import 'package:call_on_duty/widgets/wrong_answer_popup.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
  String displaytime = '00:00';
  bool isPaused = true;

  int myScore = 0;

  PageController pageController = PageController();
  List<QuestionModel> listOfQuestion = [];
  int questionIndex = 0;
  List<int> indexList = [];
  int indexCount = 1;

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
    timers = Timer.periodic(const Duration(seconds: 0), ((timer) {}));
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

  void playVideo(QuestionModel questionModel) async {
    timers.cancel();

    var isTimerStart = await Navigator.pushNamed(
        context, PageRouter.videoPlayerPage,
        arguments: questionModel);

    if (isTimerStart == true) {
      startTimer();
    }
  }

  void playCorrectVideo(AnswerModel answerModel) async {
    timers.cancel();

    var isTimerStart = await Navigator.pushNamed(
        context, PageRouter.correctVideoPlayerPage,
        arguments: answerModel);

    if (isTimerStart == true) {
      startTimer();
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
              myScore = myScore + 5;
              isScenarioCompleted = state.isScenarioCompleted;
            });
            playCorrectVideo(state.answerModel);
          }
          if (state is WrongAnswer) {
            setState(() {
              newTimer = newTimer + 5;
              if (myScore != 0) {
                myScore = myScore - 5;
              }
            });
            wrongAnswerDialog(context);
          }
          if (state is StartTimer) {
            startTimer();
          }
          if (state is PauseTimer) {
            timers.cancel();
          }
          if (state is NextPage) {
            setState(() {
              isScenarioCompleted = false;
            });
            if (indexCount != listOfQuestion.length) {
              pageController.nextPage(
                  duration: Duration(milliseconds: 1), curve: Curves.easeIn);
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
                      playVideo(listOfQuestion[index]);
                    },
                    itemCount: listOfQuestion.length,
                    itemBuilder: (context, questionIndex) {
                      return Column(
                        children: [
                          SizedBox(height: 50),
                          Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Text("Score: $myScore",
                                  style: titleText(
                                      20, FontWeight.bold, Colors.white)),
                              Row(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.alarm,
                                      size: 30,
                                      color: Colors.white,
                                    ),
                                    SizedBox(width: 10),
                                    Text(displaytime,
                                        style: bodyText(
                                            20, FontWeight.bold, Colors.white)),
                                    SizedBox(width: 20),
                                  ]),
                            ],
                          ),
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
                                                radius: 50,
                                                backgroundColor: Colors.black45,
                                                child: Padding(
                                                  padding: EdgeInsets.all(5),
                                                  child: Image.asset(
                                                    listOfQuestion[
                                                            questionIndex]
                                                        .choices[answerIndex]
                                                        .image,
                                                    fit: BoxFit.cover,
                                                  ),
                                                ),
                                              ),
                                              SizedBox(height: 5),
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
            AnimatedContainer(
                duration: Duration(milliseconds: 100),
                height: !isPaused ? MediaQuery.of(context).size.height : 0,
                color: transparentBlackColor),
            Positioned(
              bottom: 50,
              right: 10,
              child: Material(
                  elevation: 10,
                  borderRadius: BorderRadius.circular(100),
                  color: Colors.red,
                  child: InkWell(
                    borderRadius: BorderRadius.circular(100),
                    onTap: () {
                      if (isPaused) {
                        context.read<QuestionBloc>().add(TimerPause());

                        setState(() {
                          isPaused = false;
                        });
                      } else {
                        context.read<QuestionBloc>().add(TimerStart());
                        setState(() {
                          isPaused = true;
                        });
                      }
                    },
                    child: Container(
                      height: 60,
                      width: 60,
                      child: Icon(
                        !isPaused ? Icons.play_arrow : Icons.pause,
                        color: Colors.white,
                        size: 30,
                      ),
                    ),
                  )),
            ),

            ////
            ////////
            ////////
            ////

            isScenarioCompleted
                ? Container(
                    color: transparentBlackColor,
                    child: Center(
                        child: Padding(
                      padding: EdgeInsets.all(20),
                      child: Material(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                        child: Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Icon(
                                    Icons.check_circle_outline,
                                    color: Colors.greenAccent,
                                    size: 80,
                                  ),
                                  SizedBox(height: 50),
                                  InkWell(
                                    onTap: () {
                                      isScenarioCompleted = false;
                                      timers.cancel();
                                      context
                                          .read<QuestionBloc>()
                                          .add(ClickNextPage());

                                      setState(() {});
                                    },
                                    child: Container(
                                      margin:
                                          EdgeInsets.symmetric(horizontal: 40),
                                      height: 50,
                                      decoration: BoxDecoration(
                                          color: Colors.red,
                                          borderRadius:
                                              BorderRadius.circular(14)),
                                      child: Center(
                                        child: Text(
                                          'Next',
                                          style: titleText(18, FontWeight.bold,
                                              Colors.white),
                                        ),
                                      ),
                                    ),
                                  )
                                ])),
                      ),
                    )),
                  )
                : Container(),

            //////
            //////
            //////

            isTutorialOpen
                ? Container()
                : InkWell(
                    onTap: () {
                      setState(() {
                        speechStop();
                        isTutorialOpen = true;
                        playVideo(listOfQuestion[0]);
                      });
                    },
                    child: Stack(
                      children: [
                        Container(
                          height: MediaQuery.of(context).size.height,
                          child: Image.asset(
                            "assets/icon/splash_screen.png",
                            fit: BoxFit.fitHeight,
                          ),
                        ),
                        Container(
                          color: transparentBlackColor,
                          height: double.infinity,
                          child: Stack(children: [
                            Center(
                              child: Container(
                                  margin: EdgeInsets.all(20),
                                  padding: EdgeInsets.all(20),
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(12)),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Text(
                                        bloodySpeech(widget.questionDifficulty),
                                        style: bodyText(
                                            18, FontWeight.w500, Colors.black),
                                      ),
                                      SizedBox(height: 10),
                                      Text(
                                        "Tap to continue",
                                        style: bodyText(
                                            12, FontWeight.w400, Colors.black),
                                      )
                                    ],
                                  )),
                            ),
                            Positioned(
                                bottom: -150,
                                left: 50,
                                child: Image.asset(
                                  'assets/character/rman.gif',
                                  height: 500,
                                )),
                          ]),
                        ),
                      ],
                    ),
                  ),

            Positioned(
              top: 40,
              left: 20,
              child: Material(
                  elevation: 10,
                  borderRadius: BorderRadius.circular(8),
                  child: InkWell(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 5),
                        decoration: BoxDecoration(
                            color: secondaryColor,
                            borderRadius: BorderRadius.circular(8)),
                        child: Row(
                          children: [
                            Icon(Icons.arrow_back_ios, color: Colors.white),
                            SizedBox(width: 5),
                            Hero(
                              tag: widget.questionDifficulty.name,
                              child: Text(
                                gameConverter(widget.questionDifficulty),
                                style: titleText(
                                    20, FontWeight.bold, Colors.white),
                              ),
                            ),
                          ],
                        )),
                  )),
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
          isScenarioCompleted: indexList.length == 2 ? true : false,
          answerModel: listOfQuestion[questionIndex].choices[answerIndex]));
    } else {
      context.read<QuestionBloc>().add(SubmitAnswer(
          isCorrect: false,
          isScenarioCompleted: false,
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
          isScenarioCompleted: false,
          answerModel: listOfQuestion[questionIndex].choices[answerIndex]));
    } else if (indexList.length == 1 &&
        listOfQuestion[questionIndex].answersId[1] ==
            listOfQuestion[questionIndex].choices[answerIndex].id) {
      setState(() {
        indexList.add(answerIndex);
      });
      context.read<QuestionBloc>().add(SubmitAnswer(
          isCorrect: true,
          isScenarioCompleted: false,
          answerModel: listOfQuestion[questionIndex].choices[answerIndex]));
    } else if (indexList.length == 2 &&
        listOfQuestion[questionIndex].answersId[2] ==
            listOfQuestion[questionIndex].choices[answerIndex].id) {
      setState(() {
        indexList.add(answerIndex);
      });
      context.read<QuestionBloc>().add(SubmitAnswer(
          isCorrect: true,
          isScenarioCompleted: false,
          answerModel: listOfQuestion[questionIndex].choices[answerIndex]));
    } else if (indexList.length == 3 &&
        listOfQuestion[questionIndex].answersId[3] ==
            listOfQuestion[questionIndex].choices[answerIndex].id) {
      setState(() {
        indexList.add(answerIndex);
      });
      context.read<QuestionBloc>().add(SubmitAnswer(
          isCorrect: true,
          isScenarioCompleted: true,
          answerModel: listOfQuestion[questionIndex].choices[answerIndex]));
    } else {
      context.read<QuestionBloc>().add(SubmitAnswer(
          isCorrect: false,
          isScenarioCompleted: false,
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
          isScenarioCompleted: false,
          answerModel: listOfQuestion[questionIndex].choices[answerIndex]));
    } else if (indexList.length == 1 &&
        listOfQuestion[questionIndex].answersId[1] ==
            listOfQuestion[questionIndex].choices[answerIndex].id) {
      setState(() {
        indexList.add(answerIndex);
      });
      context.read<QuestionBloc>().add(SubmitAnswer(
          isCorrect: true,
          isScenarioCompleted: false,
          answerModel: listOfQuestion[questionIndex].choices[answerIndex]));
    } else if (indexList.length == 2 &&
        listOfQuestion[questionIndex].answersId[2] ==
            listOfQuestion[questionIndex].choices[answerIndex].id) {
      setState(() {
        indexList.add(answerIndex);
      });
      context.read<QuestionBloc>().add(SubmitAnswer(
          isCorrect: true,
          isScenarioCompleted: false,
          answerModel: listOfQuestion[questionIndex].choices[answerIndex]));
    } else if (indexList.length == 3 &&
        listOfQuestion[questionIndex].answersId[3] ==
            listOfQuestion[questionIndex].choices[answerIndex].id) {
      setState(() {
        indexList.add(answerIndex);
      });
      context.read<QuestionBloc>().add(SubmitAnswer(
          isCorrect: true,
          isScenarioCompleted: true,
          answerModel: listOfQuestion[questionIndex].choices[answerIndex]));
    } else {
      context.read<QuestionBloc>().add(SubmitAnswer(
          isCorrect: false,
          isScenarioCompleted: false,
          answerModel: listOfQuestion[questionIndex].choices[answerIndex]));
    }
  }
}
