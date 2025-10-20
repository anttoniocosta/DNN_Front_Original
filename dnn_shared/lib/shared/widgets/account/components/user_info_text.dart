import 'package:flutter/material.dart';

import 'package:dnn_shared/dnn_shared.dart';

class UserInfoText extends StatelessWidget {
  const UserInfoText({
    super.key,
    required this.text,
    required this.title,
  });

  final String title;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(title, style: Fonts.titleSmall(context)),
        Text(text, style: Fonts.bodyMedium(context)),
      ],
    );
  }
}
