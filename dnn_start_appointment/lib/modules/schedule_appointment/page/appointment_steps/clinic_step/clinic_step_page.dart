import 'package:dnn_dependencies/get_export.dart';
import 'package:flutter/material.dart';
import 'package:dnn_shared/dnn_shared.dart';

List<FilterChipsModel> clinicChipsSteps = [
  FilterChipsModel(index: 0, title: 'Especialista'),
  FilterChipsModel(index: 1, title: 'Especialidade'),
];

class ClinicPageStep extends StatefulWidget {
  const ClinicPageStep({super.key});

  @override
  State<ClinicPageStep> createState() => _ClinicPageStepState();
}

class _ClinicPageStepState extends State<ClinicPageStep> {
  int currentIndex = 0;

  final scrollController = ScrollController();
  final PageController pageController = PageController();
  @override
  Widget build(BuildContext context) {
    return MobileLayout(
      needCenter: false,
      needScrollView: true,
      title: 'Agendar consulta',
      maxWidth: Responsive.maxWidth(),
      bodyChild: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          ClinicCard(clinicModel: ClinicViewModel.test(), isSelected: true),
          24.heightGap,
          Text(
            'Pesquisar por:',
            style: Fonts.headlineMedium(context).copyWith(
              fontWeight: FontWeight.w700,
            ),
          ),
          24.heightGap,
          SingleChildScrollView(
            controller: scrollController,
            scrollDirection: Axis.horizontal,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: clinicChipsSteps
                  .map(
                    (e) => FilterChipsCustom(
                      index: currentIndex,
                      chip: e,
                      onTap: () {
                        setState(() {
                          currentIndex = e.index;
                        });
                      },
                    ).paddingOnly(right: 10),
                  )
                  .toList(),
            ),
          ),
          24.heightGap,
          if (currentIndex == 0) const SpecialtyClinicStepPartial(),
          if (currentIndex == 1) const SpecialistClinicStepPartial(),
        ],
      ),
    );
  }
}

class SpecialtyClinicStepPartial extends StatelessWidget {
  const SpecialtyClinicStepPartial({super.key});

  _specialistContent(String name, String crm) {
    return Row(
      children: [
        CardIconWidget(
          cardColor:
              Get.isDarkMode ? AppColors.whiteColor : AppColors.blueColor,
          radius: 10,
          icon: FontAwesomeIcons.laptopMedical,
          iconColor:
              Get.isDarkMode ? AppColors.blueColor : AppColors.whiteColor,
        ),
        20.widthGap,
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              name,
              style: Fonts.titleSmall(Get.context!).copyWith(
                fontWeight: FontWeight.w700,
              ),
            ),
            Text(
              'CRM $crm',
              style: Fonts.titleSmall(Get.context!).copyWith(
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CustomSearchBar(
          hintText: 'Filtre pelo nome ou CRM do especialista',
          controller: TextEditingController(),
        ),
        20.heightGap,
        SearchResultTile(
          radius: 20,
          horizontalPadding: 16,
          onTap: () => Get.toNamed(Routes.scheduleSpecialistFilter),
          child: _specialistContent('Dra. Ana SIlva Bertani Araujo', '54.302'),
        ),
        SearchResultTile(
          radius: 20,
          horizontalPadding: 16,
          onTap: () => Get.toNamed(Routes.scheduleSpecialistFilter),
          child: _specialistContent('Dr Arnaldo Roberto Santos', '129.345'),
        ),
      ],
    );
  }
}

class SpecialistClinicStepPartial extends StatelessWidget {
  const SpecialistClinicStepPartial({
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
          hintText: 'Filtre pelo nome da especialidade',
          controller: TextEditingController(),
        ),
        20.heightGap,
        SearchResultTile(onTap: () {}, child: _text('Alergista')),
        SearchResultTile(onTap: () {}, child: _text('Anestesiologista')),
        SearchResultTile(onTap: () {}, child: _text('Angiologista')),
        SearchResultTile(onTap: () {}, child: _text('Acupunturista')),
        SearchResultTile(onTap: () {}, child: _text('Cardiologista')),
        SearchResultTile(onTap: () {}, child: _text('Clínico Geral')),
        SearchResultTile(onTap: () {}, child: _text('Citopalogista')),
        SearchResultTile(onTap: () {}, child: _text('Cirurgião Geral')),
        SearchResultTile(onTap: () {}, child: _text('Cirurgião Plástico')),
      ],
    );
  }
}
