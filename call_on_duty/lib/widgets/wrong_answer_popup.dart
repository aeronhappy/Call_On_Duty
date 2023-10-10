import 'package:flutter/material.dart';

wrongAnswerDialog(BuildContext context) {
  showDialog(
      context: context,
      barrierDismissible: true,
      builder: (_) => const Center(
              child: Icon(
            Icons.cancel_outlined,
            color: Colors.redAccent,
            size: 30,
          )));
}
