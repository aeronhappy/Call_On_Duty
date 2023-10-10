import 'package:flutter/material.dart';

correctAnswerDialog(BuildContext context) {
  showDialog(
      context: context,
      barrierDismissible: true,
      builder: (_) => const Center(
              child: Icon(
            Icons.check_circle_outline,
            color: Colors.green,
            size: 30,
          )));
}
