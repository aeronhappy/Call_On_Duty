import 'package:call_on_duty/designs/fonts/text_style.dart';
import 'package:flutter/material.dart';

wrongAnswerDialog(BuildContext context) {
  showDialog(
      context: context,
      barrierDismissible: true,
      builder: (_) => Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: () {
                Navigator.pop(context);
              },
              child: Container(
                color: Colors.transparent,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Icon(
                      Icons.cancel_outlined,
                      color: Colors.redAccent,
                      size: 80,
                    ),
                    SizedBox(height: 50),
                    Text(
                      'Tap to try again',
                      style: bodyText(12, FontWeight.w300, Colors.white38),
                    )
                  ],
                ),
              ),
            ),
          ));
}
