import 'package:dnn_dependencies/sc_util.dart';
import 'package:dnn_shared/dnn_shared.dart';
import 'package:flutter/material.dart';

class ProfileUserInformations extends StatelessWidget {
  const ProfileUserInformations({
    super.key,
    required this.title,
    required this.subTitle,
    required this.icon,
  });

  final String title;
  final String subTitle;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          10.heightGap,
          Row(
            children: [
              SizedBox(
                width: 50.h,
                child: Center(
                  child: FaIcon(icon, color: AppColors.blueColor, size: 20.h),
                ),
              ),
              SizedBox(width: 10.w),
              Expanded(
                child: TextForDescriptions(
                    text: subTitle, title: title, hasPadding: false),
              ),
            ],
          ),
          10.heightGap,
          const Divider(height: 0)
        ],
      ),
    );
  }
}
