import 'package:dnn_shared/dnn_shared.dart';
import 'package:flutter/material.dart';

class LoaderShimmerWidget extends StatelessWidget {
  const LoaderShimmerWidget({
    super.key,
    this.width = double.infinity,
    this.height = 229,
    this.radius = 10,
  });

  final double? width;
  final double? height;
  final double? radius;

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: AppColors.shimmerBaseColor(),
      highlightColor: AppColors.shimmerHighlithColor(),
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          color: AppColors.lighterGreyColor,
          borderRadius: BorderRadius.circular(radius!),
        ),
      ),
    );
  }
}
