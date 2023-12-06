import 'package:call_on_duty/designs/colors/app_colors.dart';
import 'package:call_on_duty/designs/fonts/text_style.dart';
import 'package:flutter/material.dart';

class InforamtionPage extends StatefulWidget {
  const InforamtionPage({super.key});

  @override
  State<InforamtionPage> createState() => _InforamtionPageState();
}

class _InforamtionPageState extends State<InforamtionPage> {
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
            const SizedBox(height: 50, width: double.infinity),
            Text(
              'Highscore',
              textAlign: TextAlign.center,
              style: titleText(24, FontWeight.bold, Colors.white),
            ),
            SizedBox(height: 20),
            Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Rank",
                      style: titleText(18, FontWeight.w500, Colors.white)),
                  Text("Time",
                      style: titleText(18, FontWeight.w500, Colors.white)),
                  Text("Score",
                      style: titleText(18, FontWeight.w500, Colors.white)),
                ]),
            SizedBox(height: 20),
            Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    width: 100,
                    child: Text("EASY",
                        style: titleText(18, FontWeight.w500, Colors.white)),
                  ),
                  Text("2:48 Sec",
                      style: titleText(18, FontWeight.w500, Colors.white)),
                  Text("55 pts",
                      style: titleText(18, FontWeight.w500, Colors.white)),
                ]),
            SizedBox(height: 20),
            Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    width: 100,
                    child: Text("MEDIUM",
                        style: titleText(18, FontWeight.w500, Colors.white)),
                  ),
                  Text("2:48 Sec",
                      style: titleText(18, FontWeight.w500, Colors.white)),
                  Text("55 pts",
                      style: titleText(18, FontWeight.w500, Colors.white)),
                ]),
            SizedBox(height: 20),
            Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    width: 100,
                    child: Text("HARD",
                        style: titleText(18, FontWeight.w500, Colors.white)),
                  ),
                  Text("2:48 Sec",
                      style: titleText(18, FontWeight.w500, Colors.white)),
                  Text("55 pts",
                      style: titleText(18, FontWeight.w500, Colors.white)),
                ]),
          ],
        ),
      ),
    );
  }
}
