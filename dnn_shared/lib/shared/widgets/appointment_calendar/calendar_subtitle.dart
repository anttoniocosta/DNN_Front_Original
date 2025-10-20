import 'package:flutter/material.dart';

import 'package:dnn_shared/dnn_shared.dart';

class CalendarSubtitle extends StatelessWidget {
  const CalendarSubtitle({super.key, required this.color, required this.title});

  final Color color;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(width: 18, height: 18, color: color),
        6.widthGap,
        Text(
          title,
          style: Fonts.bodyLarge(context).copyWith(
            overflow: TextOverflow.ellipsis,
          ),
        )
      ],
    );
  }
}
