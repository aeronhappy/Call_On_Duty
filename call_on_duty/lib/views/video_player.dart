import 'package:call_on_duty/bloc/question/bloc/question_bloc.dart';
import 'package:call_on_duty/designs/fonts/text_style.dart';
import 'package:call_on_duty/model/question_model.dart';
import 'package:call_on_duty/repository/injection_container.dart';
import 'package:call_on_duty/views/description_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:video_player/video_player.dart';

class VideoPlayerPage extends StatefulWidget {
  final QuestionModel questionModel;
  const VideoPlayerPage({super.key, required this.questionModel});

  @override
  State<VideoPlayerPage> createState() => _VideoPlayerPageState();
}

class _VideoPlayerPageState extends State<VideoPlayerPage> {
  late VideoPlayerController videoPlayerController;
  bool isPlaying = true;

  @override
  void initState() {
    super.initState();
    playVideo(widget.questionModel.video);
  }

  void playVideo(String video) {
    setState(() {
      isPlaying = true;
      videoPlayerController = VideoPlayerController.asset(video);
      videoPlayerController.addListener(() {
        setState(() {
          if (videoPlayerController.value.duration != Duration.zero) {
            if (videoPlayerController.value.position ==
                videoPlayerController.value.duration) {
              videoStop();
            } else {}
          }
        });
      });
      videoPlayerController.initialize().then((_) => setState(() {}));
      videoPlayerController.play();
    });
  }

  videoStop() {
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
            child: DescriptionPage(questionModel: widget.questionModel),
          );
        },
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    videoPlayerController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
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
                          isPlaying ? Icons.pause : Icons.play_arrow,
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
                        videoStop();
                      },
                      child: SizedBox(
                          height: 40,
                          width: 80,
                          child: Center(
                            child: Text("Skip",
                                style: titleText(
                                    20, FontWeight.bold, Colors.white)),
                          )))),
            ],
          ),
        )
      ],
    );
  }
}
