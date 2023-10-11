import 'package:call_on_duty/bloc/question/bloc/question_bloc.dart';
import 'package:call_on_duty/designs/colors/app_colors.dart';
import 'package:call_on_duty/designs/fonts/text_style.dart';
import 'package:call_on_duty/model/question_model.dart';
import 'package:call_on_duty/types/question_difficulty.dart';
import 'package:call_on_duty/widgets/bg_music.dart';
import 'package:call_on_duty/widgets/correct_answer_popup.dart';
import 'package:call_on_duty/widgets/wrong_answer_popup.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:video_player/video_player.dart';

class PlayTimePage extends StatefulWidget {
  final QuestionDifficulty questionDifficulty;
  const PlayTimePage({super.key, required this.questionDifficulty});

  @override
  State<PlayTimePage> createState() => _PlayTimePageState();
}

class _PlayTimePageState extends State<PlayTimePage> {
  PageController pageController = PageController();
  late VideoPlayerController videoPlayerController;
  bool isDone = false;
  List<QuestionModel> listOfQuestion = [];
  List<int> indexList = [];

  @override
  void initState() {
    super.initState();
    context
        .read<QuestionBloc>()
        .add(GetRandomQuestions(questionDifficulty: widget.questionDifficulty));
    videoPlayerController = VideoPlayerController.asset('');
  }

  @override
  void dispose() {
    super.dispose();
    videoPlayerController.dispose();
  }

  void playVideo(String videoInQuestion) {
    setState(() {
      videoPlayerController = VideoPlayerController.asset(videoInQuestion);
      videoPlayerController.addListener(() {
        setState(() {
          if (videoPlayerController.value.duration != Duration.zero) {
            if (videoPlayerController.value.position ==
                videoPlayerController.value.duration) {
              isDone = true;
              playMusic();
            } else {
              isDone = false;
              playMusicLowVolume();
            }
          } else {
            isDone = false;
            playMusicLowVolume();
          }
        });
      });
      videoPlayerController.initialize().then((_) => setState(() {}));
      videoPlayerController.play();
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<QuestionBloc, QuestionState>(
        listener: (context, state) {
          if (state is LoadedRandomQuestions) {
            setState(() {
              listOfQuestion = state.randomQuestions;
              playVideo(state.randomQuestions[0].video);
            });
          }
          if (state is CorrectAnswer) {
            correctAnswerDialog(context, state.isCompleted);
          }
          if (state is WrongAnswer) {
            wrongAnswerDialog(context);
          }
          if (state is NextPage) {
            pageController.nextPage(
                duration: Duration(milliseconds: 300), curve: Curves.bounceIn);
          }
        },
        child: Scaffold(
            body: Stack(
          children: [
            VideoPlayer(videoPlayerController),
            isDone
                ? Container(
                    color: transparentBlackColor,
                    height: MediaQuery.of(context).size.height,
                    width: MediaQuery.of(context).size.width,
                    child: PageView.builder(
                        controller: pageController,
                        physics: const NeverScrollableScrollPhysics(),
                        onPageChanged: (index) {
                          setState(() {
                            playVideo(listOfQuestion[index].video);
                            indexList.clear();
                          });
                        },
                        itemCount: listOfQuestion.length,
                        itemBuilder: (context, questionIndex) {
                          return Padding(
                              padding: const EdgeInsets.all(20),
                              child: Center(
                                  child: GridView.builder(
                                      shrinkWrap: true,
                                      physics:
                                          const NeverScrollableScrollPhysics(),
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 20),
                                      gridDelegate:
                                          const SliverGridDelegateWithMaxCrossAxisExtent(
                                              maxCrossAxisExtent: 220,
                                              childAspectRatio: 1.3,
                                              crossAxisSpacing: 20,
                                              mainAxisSpacing: 20),
                                      itemCount: listOfQuestion[questionIndex]
                                          .choices
                                          .length,
                                      itemBuilder: (context, answerIndex) {
                                        return indexList.contains(answerIndex)
                                            ? Container()
                                            : AnimatedContainer(
                                                duration: const Duration(
                                                    milliseconds: 5000),
                                                curve: Curves.bounceIn,
                                                child: InkWell(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          100),
                                                  onTap: () {
                                                    if (QuestionDifficulty
                                                            .mild ==
                                                        widget
                                                            .questionDifficulty) {
                                                      mildSubmitAnswer(
                                                          questionIndex,
                                                          answerIndex);
                                                    }
                                                    if (QuestionDifficulty
                                                            .moderate ==
                                                        widget
                                                            .questionDifficulty) {
                                                      moderateSubmitAnswer(
                                                          questionIndex,
                                                          answerIndex);
                                                    }
                                                    if (QuestionDifficulty
                                                            .severe ==
                                                        widget
                                                            .questionDifficulty) {
                                                      severeSubmitAnswer(
                                                          questionIndex,
                                                          answerIndex);
                                                    }
                                                  },
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            10),
                                                    child: CircleAvatar(
                                                      child: Text(
                                                        listOfQuestion[
                                                                questionIndex]
                                                            .choices[
                                                                answerIndex]
                                                            .value,
                                                        style: titleText(
                                                            16,
                                                            FontWeight.w500,
                                                            Colors.white),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              );
                                      })));
                        }),
                  )
                : Container(),
            Positioned(
              top: 40,
              left: 20,
              child: Material(
                  borderRadius: BorderRadius.circular(8),
                  child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 5),
                      decoration: BoxDecoration(
                          color: secondaryColor,
                          borderRadius: BorderRadius.circular(8)),
                      child: Text(
                        widget.questionDifficulty.name.toUpperCase(),
                        style: titleText(20, FontWeight.bold, Colors.white),
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
          isCorrect: true, isCompleted: indexList.length == 2 ? true : false));
    } else {
      context
          .read<QuestionBloc>()
          .add(SubmitAnswer(isCorrect: false, isCompleted: false));
    }
  }

  void moderateSubmitAnswer(int questionIndex, int answerIndex) {
    if (indexList.isEmpty &&
        listOfQuestion[questionIndex].answersId[0] ==
            listOfQuestion[questionIndex].choices[answerIndex].id) {
      setState(() {
        indexList.add(answerIndex);
      });
      context
          .read<QuestionBloc>()
          .add(SubmitAnswer(isCorrect: true, isCompleted: false));
    } else if (indexList.length == 1 &&
        listOfQuestion[questionIndex].answersId[1] ==
            listOfQuestion[questionIndex].choices[answerIndex].id) {
      setState(() {
        indexList.add(answerIndex);
      });
      context
          .read<QuestionBloc>()
          .add(SubmitAnswer(isCorrect: true, isCompleted: false));
    } else if (indexList.length == 2 &&
        listOfQuestion[questionIndex].answersId[2] ==
            listOfQuestion[questionIndex].choices[answerIndex].id) {
      setState(() {
        indexList.add(answerIndex);
      });
      context
          .read<QuestionBloc>()
          .add(SubmitAnswer(isCorrect: true, isCompleted: false));
    } else if (indexList.length == 3 &&
        listOfQuestion[questionIndex].answersId[3] ==
            listOfQuestion[questionIndex].choices[answerIndex].id) {
      setState(() {
        indexList.add(answerIndex);
      });
      context
          .read<QuestionBloc>()
          .add(SubmitAnswer(isCorrect: true, isCompleted: true));
    } else {
      context
          .read<QuestionBloc>()
          .add(SubmitAnswer(isCorrect: false, isCompleted: false));
    }
  }

  void severeSubmitAnswer(int questionIndex, int answerIndex) {
    if (indexList.isEmpty &&
        listOfQuestion[questionIndex].answersId[0] ==
            listOfQuestion[questionIndex].choices[answerIndex].id) {
      setState(() {
        indexList.add(answerIndex);
      });
      context
          .read<QuestionBloc>()
          .add(SubmitAnswer(isCorrect: true, isCompleted: false));
    } else if (indexList.length == 1 &&
        listOfQuestion[questionIndex].answersId[1] ==
            listOfQuestion[questionIndex].choices[answerIndex].id) {
      setState(() {
        indexList.add(answerIndex);
      });
      context
          .read<QuestionBloc>()
          .add(SubmitAnswer(isCorrect: true, isCompleted: false));
    } else if (indexList.length == 2 &&
        listOfQuestion[questionIndex].answersId[2] ==
            listOfQuestion[questionIndex].choices[answerIndex].id) {
      setState(() {
        indexList.add(answerIndex);
      });
      context
          .read<QuestionBloc>()
          .add(SubmitAnswer(isCorrect: true, isCompleted: false));
    } else if (indexList.length == 3 &&
        listOfQuestion[questionIndex].answersId[3] ==
            listOfQuestion[questionIndex].choices[answerIndex].id) {
      setState(() {
        indexList.add(answerIndex);
      });
      context
          .read<QuestionBloc>()
          .add(SubmitAnswer(isCorrect: true, isCompleted: true));
    } else {
      context
          .read<QuestionBloc>()
          .add(SubmitAnswer(isCorrect: false, isCompleted: false));
    }
  }
}
