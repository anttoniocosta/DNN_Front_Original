import 'package:agora_rtc_engine/agora_rtc_engine.dart';
import 'package:dnn_dependencies/get_export.dart';
import 'package:dnn_shared/dnn_shared.dart';
import 'package:dnn_streamming/dnn_streamming.dart';

import 'package:flutter/material.dart';

class LocalUserVideo extends StatelessWidget {
  const LocalUserVideo({super.key});

  Size get sizes => Size(
        Get.mediaQuery.size.width * 0.3,
        Get.mediaQuery.size.height * 0.2,
      );

  @override
  Widget build(BuildContext context) {
    return GetBuilder<StreammingController>(builder: (_) {
      if (streammingController.localUserJoined) {
        return Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(6), boxShadow: highElevation),
          width: sizes.width,
          height: sizes.height,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(6),
            child: AgoraVideoView(
              controller: VideoViewController(
                rtcEngine: streammingController.engine!,
                canvas: const VideoCanvas(uid: 0),
              ),
            ),
          ),
        ).paddingOnly(right: 12, top: kToolbarHeight * 1.5);
      } else {
        return SizedBox(
          width: sizes.width,
          height: sizes.height,
          child: const Center(
            child: SizedBox(
              width: 50,
              height: 50,
              child: CircularProgressIndicator(),
            ),
          ),
        );
      }
    });
  }
}
