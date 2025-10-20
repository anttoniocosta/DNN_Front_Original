import 'package:dnn_core/all_exports.dart';
import 'package:dnn_shared/res/exports.dart';
import 'package:flutter/material.dart';

class SpecialistHeaderInfos extends StatefulWidget {
  const SpecialistHeaderInfos({
    super.key,
    required this.isSelected,
    required this.crm,
    required this.specialty,
    required this.name,
    this.color,
  });

  final String crm;
  final String specialty;
  final String name;
  final bool? isSelected;
  final Color? color;

  @override
  State<SpecialistHeaderInfos> createState() => _SpecialistHeaderInfosState();
}

class _SpecialistHeaderInfosState extends State<SpecialistHeaderInfos> {
  bool isTapped = false;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.41,
      child: GestureDetector(
        onTap: () {
          setState(() {
            isTapped = !isTapped;
          });
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Dr(a). ${widget.name}',
              style: Fonts.titleSmall(context).copyWith(
                color: widget.color ??
                    (widget.isSelected == true ? AppColors.whiteColor : null),
                fontWeight: FontWeight.normal,
                overflow: isTapped == false ? TextOverflow.ellipsis : null,
              ),
            ),
            Text(
                appContext.type != AppTypeEnum.CLINIC
                    ? '${widget.specialty} - CRM ${widget.crm}'
                    : 'CRM ${widget.crm}',
                style: Fonts.titleSmall(context).copyWith(
                  color: widget.color ??
                      (widget.isSelected == true ? AppColors.whiteColor : null),
                  fontWeight: FontWeight.normal,
                )),
          ],
        ),
      ),
    );
  }
}
