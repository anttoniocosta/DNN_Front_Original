import 'package:dnn_setup/dnn_setup.dart';
import 'package:flutter/material.dart';

import 'package:dnn_shared/dnn_shared.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const SplashPartial(
      image: MediaRes.verticalBrancoAzulEscuro,
      bgColor: AppColors.blueColor,
    );
  }
}
