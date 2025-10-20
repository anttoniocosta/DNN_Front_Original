import 'package:flutter/material.dart';

class LoadingButtonChildWidget extends StatelessWidget {
  const LoadingButtonChildWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const SizedBox(
      height: 15,
      width: 15,
      child: Center(child: CircularProgressIndicator.adaptive()),
    );
  }
}
