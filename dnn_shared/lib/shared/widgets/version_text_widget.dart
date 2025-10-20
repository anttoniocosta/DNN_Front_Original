import 'package:dnn_dependencies/dnn_dependencies.dart';
import 'package:dnn_shared/res/typography/app_typography.dart';
import 'package:flutter/material.dart';

class VersionTextWidget extends StatefulWidget {
  const VersionTextWidget({super.key});

  @override
  State<VersionTextWidget> createState() => _VersionTextWidgetState();
}

class _VersionTextWidgetState extends State<VersionTextWidget> {
  late String? version = '';
  late String? packageName = '';

  @override
  void initState() {
    super.initState();
    _initPackageInfo();
  }

  Future<void> _initPackageInfo() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    String version = packageInfo.version;
    String buildNumber = packageInfo.buildNumber;

    this.version = "$version.$buildNumber";
    packageName = packageInfo.packageName;
  }

  @override
  Widget build(BuildContext context) {
    return Text('Versão: $version', style: Fonts.bodySmall(context));
  }
}
