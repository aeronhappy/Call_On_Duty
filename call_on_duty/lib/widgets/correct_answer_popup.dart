import 'package:call_on_duty/bloc/question/bloc/question_bloc.dart';
import 'package:call_on_duty/designs/fonts/text_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

correctAnswerDialog(BuildContext context, bool isCompleted) {
  showDialog(
      context: context,
      barrierDismissible: true,
      builder: (_) => Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: () {
                if (!isCompleted) {
                  Navigator.pop(context);
                }
              },
              child: Container(
                color: Colors.transparent,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Icon(
                      Icons.check_circle_outline,
                      color: Colors.greenAccent,
                      size: 80,
                    ),
                    SizedBox(height: 50),
                    isCompleted
                        ? InkWell(
                            onTap: () {
                              Navigator.pop(context);
                              context.read<QuestionBloc>().add(ClickNextPage());
                            },
                            child: Container(
                              margin: EdgeInsets.symmetric(horizontal: 40),
                              height: 50,
                              decoration: BoxDecoration(
                                  color: Colors.red,
                                  borderRadius: BorderRadius.circular(14)),
                              child: Center(
                                child: Text(
                                  'Next',
                                  style: titleText(
                                      18, FontWeight.bold, Colors.white),
                                ),
                              ),
                            ),
                          )
                        : Text(
                            'Tap to try again',
                            style:
                                bodyText(12, FontWeight.w300, Colors.white38),
                          )
                  ],
                ),
              ),
            ),
          ));
}
