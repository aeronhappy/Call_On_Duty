import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class VideoPlayerPage extends StatefulWidget {
  const VideoPlayerPage({super.key});

  @override
  State<VideoPlayerPage> createState() => _VideoPlayerPageState();
}

class _VideoPlayerPageState extends State<VideoPlayerPage> {
  late VideoPlayerController videoPlayerController;
  late VideoPlayerController vControllerCorrectAnswer;

  @override
  void initState() {
    super.initState();

    videoPlayerController = VideoPlayerController.asset('');
    vControllerCorrectAnswer = VideoPlayerController.asset('');
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
