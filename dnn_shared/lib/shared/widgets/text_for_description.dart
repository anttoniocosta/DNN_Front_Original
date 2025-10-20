import 'package:flutter/material.dart';

import '../../dnn_shared.dart';

class TextForDescriptions extends StatelessWidget {
  const TextForDescriptions({
    super.key,
    required this.text,
    required this.title,
    this.hasPadding = true,
    this.hasOverflow = false,
    this.align,
  });

  final String title;
  final String text;
  final bool? hasPadding;
  final bool? hasOverflow;
  final CrossAxisAlignment? align;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: align ?? CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          title,
          style: Fonts.bodyMedium(context).copyWith(height: 0.9),
        ),
        1.heightGap,
        Text(
          text,
          style: Fonts.titleSmall(context),
          overflow: !hasOverflow! ? null : TextOverflow.ellipsis,
          textAlign: TextAlign.start,
        ),
        SizedBox(height: hasPadding! ? 10 : 0),
      ],
    );
  }
}

class TextInlineForDescriptions extends StatelessWidget {
  const TextInlineForDescriptions({
    super.key,
    required this.text,
    required this.title,
    this.hasPadding = true,
    this.needBold = false,
  });

  final String title;
  final String text;
  final bool? hasPadding;
  final bool? needBold;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: hasPadding! ? 10 : 0),
      child: Row(
        children: [
          Expanded(
            child: Text(title, style: Fonts.bodyLarge(context)),
          ),
          Align(
            alignment: Alignment.centerRight,
            child: Text(
              text,
              style: needBold!
                  ? Fonts.titleSmall(context)
                  : Fonts.bodyMedium(context),
              textAlign: TextAlign.end,
            ),
          ),
        ],
      ),
    );
  }
}
