import 'package:clipboard/clipboard.dart';
import 'package:dnn_dependencies/get_export.dart';
import 'package:flutter/material.dart';

import 'package:dnn_shared/dnn_shared.dart';

class CopyToClipboardWidget extends StatelessWidget {
  const CopyToClipboardWidget(
      {super.key, required this.textToClip, this.isBarcode = false});

  final String textToClip;
  final bool isBarcode;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      decoration: BoxDecoration(
        color: Get.isDarkMode ? AppColors.midBlackColor : AppColors.whiteColor,
        boxShadow: highElevation,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        children: [
          Expanded(
            child: Text(
              textToClip,
              style: Fonts.bodyLarge(context),
              overflow: TextOverflow.ellipsis,
            ),
          ),
          IconButton(
            onPressed: () async => isBarcode
                ? await FlutterClipboard.copy(
                    textToClip.replaceAll(".", "").replaceAll(" ", ""))
                : FlutterClipboard.copy(textToClip),
            icon: const Icon(Icons.copy, color: AppColors.blueColor, size: 24),
          )
        ],
      ),
    );
  }
}
