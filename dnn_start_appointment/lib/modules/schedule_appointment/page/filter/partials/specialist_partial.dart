import 'package:flutter/material.dart';
import 'package:dnn_shared/dnn_shared.dart';

class SpecialistFilterPartial extends StatelessWidget {
  const SpecialistFilterPartial({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CustomSearchBar(
          hintText: 'Filtre pelo nome ou CRM do especialista',
          controller: TextEditingController(),
        ),
        20.heightGap,
        // SpecialistCard(
        //   isSelected: false,
        //   specialist: SpecialistResponseModel(),
        //   onTap: () => Get.toNamed(Routes.scheduleSpecialistFilter),
        // )
      ],
    );
  }
}
