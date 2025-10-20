import 'package:dnn_shared/dnn_shared.dart';
import 'package:flutter/material.dart';

class ClickableBaseTile extends StatelessWidget {
  const ClickableBaseTile({
    super.key,
    required this.onTap,
    required this.child,
  });

  final VoidCallback onTap;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      highlightColor: AppColors.blackLightColor.withOpacity(0.1),
      radius: radiusMedium,
      borderRadius: BorderRadius.circular(radiusMedium),
      onTap: onTap,
      child: Ink(
        decoration: BoxDecoration(
          boxShadow: highElevation,
          color: Theme.of(context).colorScheme.tertiary,
          borderRadius: BorderRadius.circular(radiusMedium),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: child,
        ),
      ),
    );
  }
}
