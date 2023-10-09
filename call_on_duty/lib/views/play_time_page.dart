import 'package:call_on_duty/bloc/question/bloc/question_bloc.dart';
import 'package:call_on_duty/designs/colors/app_colors.dart';
import 'package:call_on_duty/model/question_model.dart';
import 'package:call_on_duty/types/question_difficulty.dart';
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
  late VideoPlayerController videoPlayerController;
  int index = 0;

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
        setState(() {});
      });
      videoPlayerController.setLooping(false);
      videoPlayerController.initialize().then((_) => setState(() {}));
      videoPlayerController.play();
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<QuestionBloc, QuestionState>(
      listener: (context, state) {
        if (state is LoadedRandomQuestions) {
          // setState(() {
          //   playVideo(state.randomQuestions[index].video);
          // });
        }
      },
      child: Scaffold(
          appBar: AppBar(title: const Text('Play')),
          body: BlocBuilder<QuestionBloc, QuestionState>(
            builder: (context, state) {
              if (state is LoadedRandomQuestions) {
                List<QuestionModel> listOfQuestion = state.randomQuestions;
                return Container(
                  color: secondaryColor,
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width,
                  child: PageView.builder(
                      onPageChanged: (index) {
                        setState(() {
                          playVideo(state.randomQuestions[index].video);
                        });
                      },
                      itemCount: listOfQuestion.length,
                      itemBuilder: (context, index) {
                        return VideoPlayer(videoPlayerController);
                      }),
                );
              }
              return const CircularProgressIndicator(color: Colors.white);
            },
          )),
    );
    // return BlocListener<QuestionBloc, QuestionState>(
    //   listener: (context, state) {
    //     if (state is LoadedRandomQuestions) {
    //       setState(() {
    //         playVideo(state.randomQuestions[index].video);
    //       });
    //     }
    //   },
    //   child: VideoPlayer(videoPlayerController),
    // );
  }
}
