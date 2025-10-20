import 'package:dnn_dependencies/get_export.dart';
import 'package:flutter/material.dart';
import 'package:dnn_shared/dnn_shared.dart';

class ClinicFilterPartial extends StatelessWidget {
  const ClinicFilterPartial({
    super.key,
  });

  _text(String text) {
    return Text(
      text,
      style: Fonts.bodyLarge(Get.context!).copyWith(
        fontSize: 16,
        fontWeight: Fonts.light,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CustomSearchBar(
          hintText: 'Filtre pelo nome da clínica desejada',
          controller: TextEditingController(),
        ),
        20.heightGap,
        SearchResultTile(
          onTap: () => Get.toNamed(Routes.scheduleClinicFilter),
          child: _text('Lavoisier'),
        ),
        SearchResultTile(onTap: () {}, child: _text('Alpha')),
        SearchResultTile(onTap: () {}, child: _text('Bem-estar')),
        SearchResultTile(onTap: () {}, child: _text('Delta')),
        SearchResultTile(onTap: () {}, child: _text('Médica Prime')),
        SearchResultTile(onTap: () {}, child: _text('Omega')),
        SearchResultTile(onTap: () {}, child: _text('São Lucas')),
        SearchResultTile(onTap: () {}, child: _text('São Bento')),
      ],
    );
  }
}
