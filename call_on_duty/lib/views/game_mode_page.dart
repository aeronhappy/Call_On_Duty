import 'package:call_on_duty/designs/colors/app_colors.dart';
import 'package:call_on_duty/designs/fonts/text_style.dart';
import 'package:flutter/material.dart';

class GameModePage extends StatefulWidget {
  const GameModePage({super.key});

  @override
  State<GameModePage> createState() => _GameModePageState();
}

class _GameModePageState extends State<GameModePage> {
  List<String> listOfGame = ['Mild', 'Moderate', 'Severe'];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: secondaryColor,
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 100, width: double.infinity),
            Text(
              'GAME MODE',
              textAlign: TextAlign.center,
              style: titleText(24, FontWeight.bold, Colors.white),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: listOfGame.length,
                itemBuilder: (BuildContext context, int index) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 5),
                    child: Container(
                      height: 50,
                      decoration: const ShapeDecoration(
                          color: Colors.white,
                          shape: StadiumBorder(side: BorderSide())),
                      child: Center(
                        child: Text(
                          listOfGame[index],
                          style: bodyText(18, FontWeight.w500, secondaryColor),
                        ),
                      ),
                    ),
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
