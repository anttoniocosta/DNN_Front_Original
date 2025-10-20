import 'dart:async';
import 'package:flutter/material.dart';
import 'package:dnn_shared/dnn_shared.dart';

class TimerButtonWidget extends StatefulWidget {
  const TimerButtonWidget({
    super.key,
    required this.onResend,
  });
  final VoidCallback onResend;
  @override
  State<TimerButtonWidget> createState() => _TimerButtonWidgetState();
}

class _TimerButtonWidgetState extends State<TimerButtonWidget> {
  int counter = 10;
  @override
  void initState() {
    initTimer();
    super.initState();
  }

  initTimer() {
    setState(() {
      counter = 10;
    });
    Timer.periodic(
      const Duration(seconds: 1),
      (timer) {
        if (mounted) {
          setState(() {
            counter--;
          });
        }
        if (timer.tick == 10) {
          timer.cancel();
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: counter == 0
          ? () {
              widget.onResend();
              initTimer();
            }
          : null,
      child: counter == 0
          ? Text(
              'Reenviar',
              style: Fonts.titleMedium(context),
            )
          : Text(
              'Reenviar em 00:${counter < 10 ? "0" : ""}$counter',
              style: Fonts.titleMedium(context),
            ),
    );
  }
}
