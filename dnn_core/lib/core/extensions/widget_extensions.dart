import 'package:dnn_dependencies/dnn_dependencies.dart';
import 'package:flutter/material.dart';

extension WidgetExtension on dynamic {
  Widget get heightGap => SizedBox(height: double.parse(this.toString()));
  Widget get widthGap => SizedBox(width: double.parse(this.toString()));
  Widget get toCenter => Center(child: this);
}

extension IconDataExtension on dynamic {
  IconData getSegmentIcon() {
    switch (this) {
      case 'mobile':
        return FontAwesomeIcons.mobileScreen;
      case 'tooth':
        return FontAwesomeIcons.tooth;
      case 'contract':
        return FontAwesomeIcons.bookMedical;
      case 'company':
        return FontAwesomeIcons.building;
      default:
        return FontAwesomeIcons.mobileScreen;
    }
  }
}
