import 'package:dnn_dependencies/get_export.dart';
import 'package:flutter/material.dart';

import 'package:dnn_shared/dnn_shared.dart';

class ContactButton extends StatelessWidget {
  const ContactButton({
    super.key,
    required this.onTap,
    required this.title,
    required this.icon,
  });

  final VoidCallback onTap;
  final IconData icon;
  final String title;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Row(
        children: [
          FaIcon(icon, color: AppColors.blueColor, size: 25),
          20.widthGap,
          Expanded(
            child: Text(
              title,
              style: Fonts.titleMedium(context),
              textAlign: TextAlign.left,
            ),
          )
        ],
      ).paddingSymmetric(vertical: 10),
    );
  }
}
