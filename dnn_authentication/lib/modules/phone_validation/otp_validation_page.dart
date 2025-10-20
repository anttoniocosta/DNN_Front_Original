import 'package:dnn_authentication/dnn_authentication.dart';
import 'package:dnn_shared/dnn_shared.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OtpValidationPage extends StatefulWidget {
  const OtpValidationPage({super.key});
  @override
  State<OtpValidationPage> createState() => _OtpValidationPageState();
}

class _OtpValidationPageState extends State<OtpValidationPage> {
  @override
  void initState() {
    phoneController.getPincode();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MobileLayout(
      needCenter: true,
      needScrollView: true,
      maxWidth: Responsive.maxWidth(),
      title: pagesController.currentPage(PagesEnum.otpValidation)?.name,
      needAppBar: true,
      bodyChild: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const PageHeader(pgEnum: PagesEnum.otpValidation),
            30.heightGap,
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Icon(Icons.sms, size: 30, color: AppColors.blueColor),
                8.widthGap,
                Text(
                  phoneController.userPhoneNumber!.formatPhone(),
                  style: Fonts.headlineMedium(context),
                )
              ],
            ),
            30.heightGap,
            GetBuilder<PhoneController>(builder: (_) {
              return OTPWidget(
                isOnLoading: phoneController.isLoading.value,
                onComplete: (val) {
                  phoneController.phoneValidation(
                    val!,
                    phoneController.userToken!,
                    phoneController.userPhoneNumber!,
                  );
                },
              );
            }),
            12.heightGap,
            TimerButtonWidget(onResend: () => phoneController.getPincode()),
          ],
        ),
      ),
    );
  }
}
