import 'package:call_on_duty/bloc/question/bloc/question_bloc.dart';
import 'package:call_on_duty/designs/colors/app_colors.dart';
import 'package:call_on_duty/designs/fonts/text_style.dart';
import 'package:call_on_duty/model/question_model.dart';
import 'package:call_on_duty/widgets/bg_music.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DescriptionPage extends StatefulWidget {
  final QuestionModel questionModel;
  const DescriptionPage({super.key, required this.questionModel});

  @override
  State<DescriptionPage> createState() => _DescriptionPageState();
}

class _DescriptionPageState extends State<DescriptionPage> {
  @override
  void initState() {
    speech(widget.questionModel);
    super.initState();
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

  @override
  void dispose() {
    speechStop();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          height: MediaQuery.of(context).size.height,
          child: Image.asset(
            "assets/icon/splash_screen.png",
            fit: BoxFit.fitHeight,
          ),
        ),
        Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: () {
              context.read<QuestionBloc>().add(TimerStart());
              Navigator.pop(context, true);
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
                          Text(widget.questionModel.title.toUpperCase(),
                              style: bodyText(
                                  20, FontWeight.bold, Colors.redAccent)),
                          SizedBox(height: 10),
                          Text(
                            widget.questionModel.text,
                            style: bodyText(16, FontWeight.w500, Colors.black),
                          ),
                          SizedBox(height: 10),
                          Text(
                            "Sagutan kung anong kailangan gawin o kailangan gamitin ng pasyente.",
                            style: bodyText(16, FontWeight.w500, Colors.black),
                          ),
                          SizedBox(height: 10),
                          SizedBox(
                            width: double.infinity,
                            child: Text(
                              "Tap to continue",
                              textAlign: TextAlign.center,
                              style:
                                  bodyText(12, FontWeight.w400, Colors.black),
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
      ],
    );
  }
}
