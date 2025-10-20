import 'package:agora_rtc_engine/agora_rtc_engine.dart';
import 'package:dnn_dependencies/get_export.dart';
import 'package:dnn_shared/dnn_shared.dart';
import 'package:dnn_streamming/dnn_streamming.dart';

import 'package:flutter/material.dart';

class RemoteUserVideo extends StatelessWidget {
  const RemoteUserVideo(
      {super.key, required this.titleText, required this.waitingText});

  final String titleText;
  final String waitingText;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<StreammingController>(builder: (_) {
      if (streammingController.remoteUids.isNotEmpty) {
        return Stack(
          alignment: Alignment.topCenter,
          children: [
            AgoraVideoView(
              controller: VideoViewController.remote(
                rtcEngine: streammingController.engine!,
                canvas: VideoCanvas(uid: streammingController.remoteUids[0]),
                connection: RtcConnection(
                    channelId: streammingController.client!.channelName),
              ),
            ),
            // Text(
            //   titleText.capitalize!,
            //   style: Fonts.titleLarge(Get.context!)
            //       .copyWith(color: AppColors.whiteColor),
            //   textAlign: TextAlign.center,
            // ).paddingOnly(top: (kToolbarHeight / 1.5)),
          ],
        );
      } else {
        return Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              waitingText.capitalize!,
              style: Fonts.titleLarge(Get.context!),
              textAlign: TextAlign.center,
            ).toCenter,
          ],
        ).toCenter;
      }
    });
  }
}
