import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:upgrader/upgrader.dart';

class CustomUpgradeWidget extends StatelessWidget {
  const CustomUpgradeWidget({super.key, required this.upgradeChild});

  final Widget upgradeChild;

  @override
  Widget build(BuildContext context) {
    return UpgradeAlert(
      upgrader: Upgrader(
        onIgnore: kReleaseMode ? () => exit(0) : null,
        onLater: kReleaseMode ? () => exit(0) : null,
        showLater: kReleaseMode ? false : true,
        canDismissDialog: false,
        debugDisplayAlways: false,
        showReleaseNotes: false,
        showIgnore: false,
        durationUntilAlertAgain: const Duration(seconds: 1),
        dialogStyle: UpgradeDialogStyle.material,
      ),
      child: upgradeChild,
    );
  }
}
