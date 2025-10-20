import 'package:agora_uikit/agora_uikit.dart';
import 'package:dnn_dependencies/get_export.dart';
import 'package:dnn_shared/dnn_shared.dart';
import 'package:dnn_streamming/dnn_streamming.dart';
import 'package:flutter/material.dart';

class StreammingPage extends StatefulWidget {
  const StreammingPage({
    super.key,
    required this.onProntuaryTap,
    required this.finishCall,
    this.needProntuary = true,
    required this.titleText,
    required this.waitingText,
  });

  final VoidCallback onProntuaryTap;
  final VoidCallback finishCall;
  final bool? needProntuary;
  final String titleText;
  final String waitingText;

  @override
  State<StreammingPage> createState() => _StreammingPageState();
}

class _StreammingPageState extends State<StreammingPage> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<StreammingController>(builder: (_) {
      return PopScope(
        onPopInvoked: (vall) async {
          widget.finishCall();
        },
        canPop: false,
        child: GetBuilder<StreammingController>(initState: (state) {
          Future.delayed(const Duration(milliseconds: 10), () async {
            await streammingController.initEngine();
          });
        }, builder: (_) {
          return MobileLayout(
            needPadding: false,
            needCenter: true,
            needScrollView: false,
            needAppBar: false,
            bodyChild: Stack(
              children: [
                Stack(
                  alignment: Alignment.topLeft,
                  children: [
                    RemoteUserVideo(
                      titleText: widget.titleText,
                      waitingText: widget.waitingText,
                    ),
                    Container(
                      width: MediaQuery.sizeOf(context).width,
                      height: MediaQuery.sizeOf(context).height,
                      color: Colors.black.withOpacity(.1),
                    ),
                    const Align(
                      alignment: Alignment.topRight,
                      child: LocalUserVideo(),
                    ),
                  ],
                ),
                AgoraVideoButtons(
                  client: streammingController.agoraClient!,
                  enabledButtons: appContext.type == AppTypeEnum.SPECIALIST
                      ? [
                          BuiltInButtons.callEnd,
                          BuiltInButtons.toggleMic,
                          BuiltInButtons.switchCamera
                        ]
                      : [
                          BuiltInButtons.callEnd,
                          BuiltInButtons.toggleMic,
                          BuiltInButtons.switchCamera,
                        ],
                  onDisconnect: () async {
                    widget.finishCall();
                  },
                  extraButtons: [
                    Visibility(
                      visible: widget.needProntuary!,
                      child: SizedBox(
                        child: IconButton.filled(
                          padding: const EdgeInsets.all(20),
                          style: IconButton.styleFrom(
                            backgroundColor: AppColors.blueColor,
                            shape: const CircleBorder(),
                          ),
                          color: Colors.white,
                          onPressed: widget.onProntuaryTap,
                          icon: const FaIcon(FontAwesomeIcons.fileContract),
                        ).paddingOnly(left: 20),
                      ),
                    )
                  ],
                ),
              ],
            ),
          );
        }),
      );
    });
  }
}
