import 'dart:developer';

import 'package:call_on_duty/bloc/question/bloc/question_bloc.dart';
import 'package:call_on_duty/designs/colors/app_colors.dart';
import 'package:call_on_duty/designs/fonts/text_style.dart';
import 'package:call_on_duty/model/question_model.dart';
import 'package:call_on_duty/types/question_difficulty.dart';
import 'package:call_on_duty/widgets/correct_answer_popup%20copy.dart';
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
            } else {
              isDone = false;
            }
          } else {
            isDone = false;
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
            correctAnswerDialog(context);
          }
          if (state is WrongAnswer) {
            wrongAnswerDialog(context);
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
                          });
                        },
                        itemCount: listOfQuestion.length,
                        itemBuilder: (context, index) {
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
                                      itemCount:
                                          listOfQuestion[index].choices.length,
                                      itemBuilder: (context, answerIndex) {
                                        return indexList.contains(answerIndex)
                                            ? Container()
                                            : AnimatedContainer(
                                                duration: const Duration(
                                                    milliseconds: 5000),
                                                child: InkWell(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          100),
                                                  onTap: () {
                                                    if (listOfQuestion[index]
                                                        .answersId
                                                        .contains(
                                                            listOfQuestion[
                                                                    index]
                                                                .choices[
                                                                    answerIndex]
                                                                .id)) {
                                                      setState(() {
                                                        indexList
                                                            .add(answerIndex);
                                                      });
                                                      context
                                                          .read<QuestionBloc>()
                                                          .add(SubmitAnswer(
                                                              isCorrect: true));
                                                    } else {
                                                      context
                                                          .read<QuestionBloc>()
                                                          .add(SubmitAnswer(
                                                              isCorrect:
                                                                  false));
                                                    }
                                                  },
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            10),
                                                    child: CircleAvatar(
                                                      child: Image.asset(
                                                          listOfQuestion[index]
                                                              .choices[
                                                                  answerIndex]
                                                              .image),
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
}
