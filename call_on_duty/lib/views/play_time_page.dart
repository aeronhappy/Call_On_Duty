import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class PlayTimePage extends StatefulWidget {
  const PlayTimePage({super.key});

  @override
  State<PlayTimePage> createState() => _PlayTimePageState();
}

class _PlayTimePageState extends State<PlayTimePage> {
  late VideoPlayerController videoPlayerController;

  @override
  void initState() {
    super.initState();
    videoPlayerController =
        VideoPlayerController.asset('assets/video/video_1.mp4');

    videoPlayerController.addListener(() {
      setState(() {});
    });
    videoPlayerController.setLooping(false);
    videoPlayerController.initialize().then((_) => setState(() {}));
    videoPlayerController.play();
  }

  @override
  void dispose() {
    super.dispose();
    videoPlayerController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SizedBox(
            height: MediaQuery.of(context).size.width,
            child: VideoPlayer(videoPlayerController)));
  }
}
