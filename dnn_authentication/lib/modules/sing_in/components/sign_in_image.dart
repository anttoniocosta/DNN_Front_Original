import 'package:dnn_dependencies/get_export.dart';
import 'package:dnn_shared/dnn_shared.dart';
import 'package:flutter/widgets.dart';

class SignInImage extends StatelessWidget {
  const SignInImage({super.key});

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
      Get.isDarkMode ? MediaRes.horizontalBranco : MediaRes.horizontalAzul,
      fit: BoxFit.fitWidth,
      height: 80,
    );
  }
}
