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
      body: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(height: 100, width: double.infinity),
          Text(
            'HOW TO PLAY ?',
            textAlign: TextAlign.center,
            style: titleText(24, FontWeight.bold, Colors.white),
          ),
        ],
      ),
    );
  }
}
