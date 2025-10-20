import 'package:flutter/material.dart';

import 'package:dnn_shared/dnn_shared.dart';

class TextLink extends StatelessWidget {
  const TextLink({super.key, required this.title, required this.url});
  final String title;
  final String url;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => AppFunctions.urlLauncherSimples(url),
      child: Text(
        title,
        style: Fonts.bodyMedium(context).copyWith(
          color: AppColors.blueColor,
          decoration: TextDecoration.underline,
          decorationColor: AppColors.blueColor,
        ),
      ),
    );
  }
}
