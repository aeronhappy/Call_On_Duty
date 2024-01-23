import 'package:call_on_duty/bloc/question/bloc/question_bloc.dart';
import 'package:call_on_duty/designs/fonts/text_style.dart';
import 'package:call_on_duty/model/question_model.dart';
import 'package:call_on_duty/views/description_page.dart';
import 'package:call_on_duty/widgets/bg_music.dart';
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
  bool isDescriptionOpen = false;

  @override
  void initState() {
    super.initState();
    context.read<QuestionBloc>().add(TimerPause());
    playVideo(widget.questionModel.video);
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
              playMusic();
            }
          } else {
            playMusicLowVolume();
          }
        });
      });
      videoPlayerController.initialize().then((_) => setState(() {}));
      videoPlayerController.play();
    });
  }

  videoStop() {
    setState(() {
      isDescriptionOpen = true;
    });
  }

  @override
  void dispose() {
    speechStop();
    videoPlayerController.dispose();
    super.dispose();
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
        ),
        isDescriptionOpen
            ? DescriptionPage(questionModel: widget.questionModel)
            : Container()
      ],
    );
  }
}
