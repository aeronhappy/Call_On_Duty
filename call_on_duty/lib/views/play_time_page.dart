import 'dart:async';

import 'package:call_on_duty/bloc/question/bloc/question_bloc.dart';
import 'package:call_on_duty/designs/colors/app_colors.dart';
import 'package:call_on_duty/designs/fonts/text_style.dart';
import 'package:call_on_duty/model/answer_model.dart';
import 'package:call_on_duty/model/question_model.dart';
import 'package:call_on_duty/types/question_difficulty.dart';
import 'package:call_on_duty/views/game_mode_page.dart';
import 'package:call_on_duty/widgets/bg_music.dart';
import 'package:call_on_duty/widgets/unlock_level_popup.dart';
import 'package:call_on_duty/widgets/wrong_answer_popup.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:video_player/video_player.dart';

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
  late VideoPlayerController videoPlayerController;
  late VideoPlayerController vControllerCorrectAnswer;
  bool isReadyToAnswer = false;
  bool isDone = false;
  List<QuestionModel> listOfQuestion = [];
  int questionIndex = 0;
  List<int> indexList = [];
  int indexCount = 1;
  bool isBloodyDone = false;
  bool isTutorialOpen = false;
  bool isScenarioCompleted = false;
  bool isPlaying = false;

  @override
  void initState() {
    super.initState();
    context
        .read<QuestionBloc>()
        .add(GetRandomQuestions(questionDifficulty: widget.questionDifficulty));
    videoPlayerController = VideoPlayerController.asset('');
    vControllerCorrectAnswer = VideoPlayerController.asset('');
    textToSpeech(bloodySpeech(widget.questionDifficulty));
    timers = Timer.periodic(const Duration(milliseconds: 0), ((timer) {}));
  }

  @override
  void dispose() {
    super.dispose();
    videoPlayerController.dispose();
    vControllerCorrectAnswer.dispose();
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

  void playVideo(QuestionModel question) {
    setState(() {
      isPlaying = true;
      videoPlayerController = VideoPlayerController.asset(question.video);
      videoPlayerController.addListener(() {
        setState(() {
          if (videoPlayerController.value.duration != Duration.zero) {
            if (videoPlayerController.value.position ==
                videoPlayerController.value.duration) {
              isDone = true;
              isReadyToAnswer = false;
              speech(question);
              playMusic();
            } else {
              isDone = false;
              isReadyToAnswer = false;
              playMusicLowVolume();
            }
          } else {
            isDone = false;
            isReadyToAnswer = false;
            playMusicLowVolume();
          }
        });
      });
      videoPlayerController.initialize().then((_) => setState(() {}));
      if (isBloodyDone) {
        videoPlayerController.play();
      }
    });
  }

  videoPlayerSkip() {
    videoPlayerController.seekTo(videoPlayerController.value.duration);
  }

  void playVideoWithCorrect(AnswerModel answerModel, bool isCompleted) {
    setState(() {
      vControllerCorrectAnswer = VideoPlayerController.asset(answerModel.video);
      vControllerCorrectAnswer.addListener(() {
        setState(() {
          if (vControllerCorrectAnswer.value.duration != Duration.zero) {
            if (vControllerCorrectAnswer.value.position ==
                vControllerCorrectAnswer.value.duration) {
              isTutorialOpen = false;
              isScenarioCompleted = isCompleted;
              isReadyToAnswer = isCompleted ? false : true;
              isCompleted ? timers.cancel() : null;
              playMusic();
            } else if (vControllerCorrectAnswer.value.position.inSeconds == 1) {
              answerSpeech(answerModel.explanation);
            } else {
              isTutorialOpen = true;
              isReadyToAnswer = false;
              playMusicLowVolume();
            }
          } else {
            isTutorialOpen = true;
            isReadyToAnswer = false;
            playMusicLowVolume();
          }
        });
      });
      vControllerCorrectAnswer.initialize().then((_) => setState(() {}));
      vControllerCorrectAnswer.play();
    });
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

  @override
  Widget build(BuildContext context) {
    return BlocListener<QuestionBloc, QuestionState>(
        listener: (context, state) {
          if (state is LoadedRandomQuestions) {
            setState(() {
              listOfQuestion = state.randomQuestions;
              isPlaying = true;
            });
            playVideo(state.randomQuestions[0]);
          }
          if (state is CorrectAnswer) {
            setState(() {
              myScore = myScore + 5;
            });
            playVideoWithCorrect(state.answerModel, state.isCompleted);
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
              isDone = false;
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
            Center(
              child: AnimatedOpacity(
                duration: Duration(milliseconds: 100),
                curve: Curves.bounceInOut,
                opacity: isReadyToAnswer ? 1 : 0,
                child: Container(
                  color: transparentBlackColor,
                  child: PageView.builder(
                      controller: pageController,
                      onPageChanged: (index) {
                        setState(() {
                          questionIndex = index;
                          isReadyToAnswer = false;
                          indexList.clear();
                          indexCount++;
                        });
                        playVideo(listOfQuestion[index]);
                      },
                      itemCount: listOfQuestion.length,
                      itemBuilder: (context, questionIndex) {
                        return Stack(
                          children: [
                            Container(
                              color: Colors.amber,
                              child: Center(
                                child: GridView.builder(
                                    shrinkWrap: true,
                                    physics:
                                        const NeverScrollableScrollPhysics(),
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 20),
                                    gridDelegate:
                                        const SliverGridDelegateWithMaxCrossAxisExtent(
                                            maxCrossAxisExtent: 180,
                                            childAspectRatio: 1.25,
                                            crossAxisSpacing: 20,
                                            mainAxisSpacing: 20),
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
                                            duration:
                                                Duration(milliseconds: 500),
                                            child: CircleAvatar(
                                              backgroundColor: Colors.black45,
                                              child: Column(
                                                children: [
                                                  Image.asset(
                                                    listOfQuestion[
                                                            questionIndex]
                                                        .choices[answerIndex]
                                                        .image,
                                                    height: 100,
                                                  ),
                                                  Text(
                                                    listOfQuestion[
                                                            questionIndex]
                                                        .choices[answerIndex]
                                                        .value,
                                                    style: titleText(
                                                        16,
                                                        FontWeight.w500,
                                                        Colors.white),
                                                  ),
                                                ],
                                              ),
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
                                builder:
                                    (context, candidateData, rejectedData) {
                                  return Container(
                                    height: 100,
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
            ),
            isReadyToAnswer
                ? Container()
                : Stack(
                    children: [
                      VideoPlayer(videoPlayerController),
                      Positioned(
                        bottom: 10,
                        right: 10,
                        child: Row(
                          children: [
                            Material(
                                borderRadius: BorderRadius.circular(100),
                                color: Colors.red,
                                child: InkWell(
                                    borderRadius: BorderRadius.circular(100),
                                    onTap: () {
                                      setState(() {
                                        if (isPlaying) {
                                          isPlaying = false;
                                          videoPlayerController.pause();
                                        } else {
                                          isPlaying = true;
                                          videoPlayerController.play();
                                        }
                                      });
                                    },
                                    child: SizedBox(
                                      height: 50,
                                      width: 50,
                                      child: Icon(
                                        isPlaying
                                            ? Icons.pause
                                            : Icons.play_arrow,
                                        color: Colors.white,
                                      ),
                                    ))),
                            SizedBox(width: 10),
                            Material(
                                borderRadius: BorderRadius.circular(12),
                                color: Colors.red,
                                child: InkWell(
                                    borderRadius: BorderRadius.circular(12),
                                    onTap: () {
                                      videoPlayerSkip();
                                    },
                                    child: SizedBox(
                                        height: 40,
                                        width: 80,
                                        child: Center(
                                          child: Text("Skip",
                                              style: titleText(
                                                  20,
                                                  FontWeight.bold,
                                                  Colors.white)),
                                        )))),
                          ],
                        ),
                      )
                    ],
                  ),
            AnimatedContainer(
              duration: Duration(milliseconds: 500),
              height: isDone ? MediaQuery.of(context).size.height : 0,
              child: InkWell(
                onTap: () {
                  setState(() {
                    isDone = false;
                    isReadyToAnswer = true;
                    startTimer();
                    speechStop();
                  });
                },
                child: Container(
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
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                  listOfQuestion.isEmpty
                                      ? "No"
                                      : listOfQuestion[questionIndex]
                                          .title
                                          .toUpperCase(),
                                  style: bodyText(
                                      20, FontWeight.bold, Colors.redAccent)),
                              SizedBox(height: 10),
                              Text(
                                listOfQuestion.isEmpty
                                    ? "No"
                                    : listOfQuestion[questionIndex].text,
                                style:
                                    bodyText(16, FontWeight.w500, Colors.black),
                              ),
                              SizedBox(height: 10),
                              Text(
                                "Sagutan kung anong kailangan gawin o kailangan gamitin ng pasyente.",
                                style:
                                    bodyText(16, FontWeight.w500, Colors.black),
                              ),
                              SizedBox(height: 10),
                              SizedBox(
                                width: double.infinity,
                                child: Text(
                                  "Tap to continue",
                                  textAlign: TextAlign.center,
                                  style: bodyText(
                                      12, FontWeight.w400, Colors.black),
                                ),
                              )
                            ],
                          )),
                    ),
                    Positioned(
                        bottom: -100,
                        right: -90,
                        child: Image.asset(
                          'assets/character/rman.gif',
                          height: 400,
                        )),
                  ]),
                ),
              ),
            ),
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
                                      isReadyToAnswer = false;
                                      context
                                          .read<QuestionBloc>()
                                          .add(ClickNextPage());
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
            AnimatedContainer(
                height: isTutorialOpen ? MediaQuery.of(context).size.height : 0,
                duration: Duration(milliseconds: 500),
                child: VideoPlayer(vControllerCorrectAnswer)),
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
            isBloodyDone
                ? Container()
                : AnimatedOpacity(
                    duration: Duration(milliseconds: 500),
                    opacity: isBloodyDone ? 0 : 1,
                    child: InkWell(
                      onTap: () {
                        setState(() {
                          speechStop();
                          isBloodyDone = true;
                          videoPlayerController.play();
                        });
                      },
                      child: Container(
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
                    ),
                  ),
            Positioned(
              top: 100,
              left: 20,
              right: 20,
              child: AnimatedOpacity(
                duration: Duration(milliseconds: 500),
                opacity: isReadyToAnswer ? 1 : 0,
                child: Row(
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
                          style: bodyText(24, FontWeight.w500, Colors.white))
                    ]),
              ),
            ),
            Positioned(
              top: 40,
              right: 20,
              child: Material(
                  elevation: 10,
                  borderRadius: BorderRadius.circular(8),
                  child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 5),
                      decoration: BoxDecoration(
                          color: secondaryColor,
                          borderRadius: BorderRadius.circular(8)),
                      child: Row(
                        children: [
                          Text(
                            "Score :",
                            style: titleText(22, FontWeight.bold, Colors.white),
                          ),
                          SizedBox(width: 10),
                          Text(
                            myScore.toString(),
                            style: titleText(26, FontWeight.bold, Colors.white),
                          ),
                        ],
                      ))),
            ),
          ],
        )));
  }

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
