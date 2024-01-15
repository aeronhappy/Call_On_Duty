import 'dart:async';

import 'package:call_on_duty/bloc/question/bloc/question_bloc.dart';
import 'package:call_on_duty/model/question_model.dart';
import 'package:call_on_duty/types/question_difficulty.dart';
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
    videoPlayerController = VideoPlayerController.asset('');
    vControllerCorrectAnswer = VideoPlayerController.asset('');
    textToSpeech(bloodySpeech(widget.questionDifficulty));
    timers = Timer.periodic(const Duration(milliseconds: 0), ((timer) {}));
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
