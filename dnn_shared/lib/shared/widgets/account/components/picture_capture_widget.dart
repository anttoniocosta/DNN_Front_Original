import 'package:dnn_core/all_exports.dart';
import 'package:dnn_dependencies/dnn_dependencies.dart';
import 'package:dnn_shared/res/exports.dart';
import 'package:flutter/material.dart';

class PictureCaptureWidget extends StatelessWidget {
  const PictureCaptureWidget({
    super.key,
    required this.onTap,
    required this.iconData,
    required this.title,
  });

  final VoidCallback onTap;
  final IconData iconData;
  final String title;
  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        child: Ink(
          padding: const EdgeInsets.all(12),
          child: Row(
            children: [
              FaIcon(iconData, size: 20, color: Fonts.bodyLarge(context).color),
              20.widthGap,
              Text(title, style: Fonts.headlineMedium(context))
            ],
          ),
        ),
      ),
    );
  }
}
