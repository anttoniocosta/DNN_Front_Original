import 'package:dnn_dependencies/get_export.dart';
import 'package:flutter/material.dart';

import '../../dnn_shared.dart';

class FontsPage extends StatelessWidget {
  const FontsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('1 - Display Large - 38px',
                style: Fonts.displayLarge(context)),
            10.heightGap,
            Text('2 -Display Medium - 26px',
                style: Fonts.displayMedium(context)),
            10.heightGap,
            Text('3 - Display Small - 23px',
                style: Fonts.displaySmall(context)),
            10.heightGap,
            Text('4 - Header - 20px', style: Fonts.headlineMedium(context)),
            10.heightGap,
            Text('5 - Subheader - 15px', style: Fonts.headlineSmall(context)),
            10.heightGap,
            Text('6 - Title Large - 18px', style: Fonts.titleLarge(context)),
            10.heightGap,
            Text('7 - Title Medium - 17px', style: Fonts.titleMedium(context)),
            10.heightGap,
            Text('8 - Title Small - 15px', style: Fonts.titleSmall(context)),
            10.heightGap,
            Text('9 - Body Large - 15px', style: Fonts.bodyLarge(context)),
            10.heightGap,
            Text('10 - Body Medium - 13px', style: Fonts.bodyMedium(context)),
            10.heightGap,
            Text('11 - Body Small - 11px', style: Fonts.bodySmall(context)),
          ],
        )
          ..paddingOnly(left: 12)
          ..toCenter,
      ),
    );
  }
}
