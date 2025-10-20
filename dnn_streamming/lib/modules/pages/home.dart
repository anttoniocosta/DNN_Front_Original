import 'package:dnn_dependencies/get_export.dart';
import 'package:dnn_shared/dnn_shared.dart';
import 'package:dnn_streamming/dnn_streamming.dart';
import 'package:dnn_streamming/modules/controller/streamming_controller.dart';
import 'package:dnn_streamming/modules/models/call_model.dart';
import 'package:dnn_streamming/modules/pages/streamming_page.dart';
import 'package:flutter/material.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<StreammingController>(builder: (_) {
      return MobileLayout(
        needCenter: true,
        needScrollView: false,
        bodyChild: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            ElevatedButton(
              onPressed: () {
                streammingController.generateToken('teste');
                appContext.setType(AppTypeEnum.CLIENT);
                streammingController.setClient(
                  channelName: 'test',
                  clientType: ClientTypeEnum.patient,
                  tokenId: '',
                );
                streammingController.setAgoraClient();
                Get.to(
                  () => StreammingPage(
                    onProntuaryTap: () {},
                    finishCall: () {},
                    titleText: '',
                    waitingText: '',
                    needProntuary: false,
                  ),
                );
              },
              child: const Text('Cliente'),
            ),
            ElevatedButton(
              onPressed: () {
                streammingController.generateToken('teste');
                appContext.setType(AppTypeEnum.SPECIALIST);
                streammingController.setClient(
                  channelName: 'test',
                  clientType: ClientTypeEnum.doctor,
                  tokenId: '',
                );
                streammingController.setAgoraClient();
                Get.to(
                  () => StreammingPage(
                    onProntuaryTap: () {},
                    finishCall: () {},
                    titleText: '',
                    waitingText: '',
                    needProntuary: true,
                  ),
                );
              },
              child: const Text('Doutor'),
            )
          ],
        ).toCenter,
      );
    });
  }
}
