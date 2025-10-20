import 'package:flutter/material.dart';

import 'package:dnn_shared/dnn_shared.dart';

class HelpersTile extends StatelessWidget {
  const HelpersTile({
    super.key,
    required this.e,
    this.hasLeading = true,
    this.icon,
    required this.onTap,
    this.hasSubtitle = true,
  });

  final HelperModel e;
  final bool? hasLeading;
  final bool? hasSubtitle;
  final IconData? icon;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(vertical: 2),
      leading: hasLeading!
          ? FaIcon(icon, size: 28, color: AppColors.blueColor)
          : null,
      title: Text(
        e.title!,
        style: hasSubtitle!
            ? Fonts.titleMedium(context)
            : Fonts.bodyLarge(context),
      ),
      horizontalTitleGap: 10,
      subtitle: hasSubtitle!
          ? Text(
              e.descriptions!,
              style: Fonts.bodyMedium(context),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            )
          : null,
      trailing: const Icon(Icons.arrow_forward_ios, size: 20),
      onTap: onTap,
    );
  }
}
