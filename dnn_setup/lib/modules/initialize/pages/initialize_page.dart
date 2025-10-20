import 'dart:async';

import 'package:dnn_dependencies/get_export.dart';
import 'package:dnn_setup/dnn_setup.dart';
import 'package:dnn_shared/dnn_shared.dart';
import 'package:flutter/material.dart';

class InitializePartial extends StatefulWidget {
  const InitializePartial({super.key, required this.onStart});

  final Function() onStart;
  @override
  State<InitializePartial> createState() => _InitializePartialState();
}

class _InitializePartialState extends State<InitializePartial> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<InitializeController>(initState: (__) {
      Future.delayed(const Duration(milliseconds: 10), () async {
        await initializeController.start(widget.onStart);
      });
    }, builder: (_) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Spacer(),
          SvgPicture.asset(
            Get.isDarkMode
                ? MediaRes.horizontalBranco
                : MediaRes.horizontalOriginal,
            fit: BoxFit.contain,
            height: 100,
          ),
          20.heightGap,
          Text(
            initializeController.titles[initializeController.currentIndex],
            style: Fonts.displayMedium(context),
            textAlign: TextAlign.center,
          ),
          6.heightGap,
          Text(
            initializeController
                .descriptions[initializeController.currentIndex],
            style: Fonts.bodyLarge(context),
            textAlign: TextAlign.center,
          ),
          30.heightGap,
          Visibility(
            visible: !initializeController.hasError,
            child: const CircularProgressIndicator.adaptive(),
          ),
          const Spacer(),
          Visibility(
            visible: initializeController.hasError,
            child: PrimaryButtonWidget(
              isLoading: connectivityController.isLoading.value,
              titleButtom: 'Tentar novamente',
              onTap: () async {
                initializeController.start(widget.onStart);
              },
            ),
          ),
          Visibility(
            visible: initializeController.hasError,
            child: 20.heightGap,
          ),
        ],
      );
    });
  }
}
