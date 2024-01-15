import 'dart:async';

import 'package:call_on_duty/bloc/question/bloc/question_bloc.dart';
import 'package:call_on_duty/model/question_model.dart';
import 'package:call_on_duty/types/question_difficulty.dart';
import 'package:call_on_duty/widgets/unlock_level_popup.dart';
import 'package:call_on_duty/widgets/wrong_answer_popup.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AsnwerPage extends StatefulWidget {
  final QuestionDifficulty questionDifficulty;
  const AsnwerPage({super.key, required this.questionDifficulty});

  @override
  State<AsnwerPage> createState() => _AsnwerPageState();
}

class _AsnwerPageState extends State<AsnwerPage> {
  PageController pageController = PageController();
  List<QuestionModel> listOfQuestion = [];
  int questionIndex = 0;
  List<int> indexList = [];
  int indexCount = 1;

  late Timer timers;
  int newTimer = 0;
  String displaytime = '00.00';

  int myScore = 0;

  bool isReadyToAnswer = false;
  bool isDone = false;
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
    // textToSpeech(bloodySpeech(widget.questionDifficulty));
    timers = Timer.periodic(const Duration(milliseconds: 0), ((timer) {}));
  }

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
          });
          // playVideoWithCorrect(state.answerModel, state.isCompleted);
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
            // saveScore(myScore, newTimer, widget.questionDifficulty);
          }
        }
      },
      child: Scaffold(
          body: Stack(
        children: [],
      )),
    );
  }
}
