import 'package:dnn_shared/dnn_shared.dart';
import 'package:flutter/material.dart';
import 'package:dnn_dependencies/get_export.dart';

class SpecialistInfoFormPartial extends StatelessWidget {
  const SpecialistInfoFormPartial({
    super.key,
    required this.formKey,
    required this.cpfKey,
    required this.crmController,
  });

  final GlobalKey<FormState> formKey;
  final GlobalKey<FormState> cpfKey;
  final TextEditingController crmController;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProvidersController>(
      builder: (_) {
        return Form(
          key: formKey,
          child: Column(
            children: [
              Form(
                key: cpfKey,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Expanded(child: CPFInput(controller: _.document)),
                    10.widthGap,
                    LayoutBuilder(
                      builder: (__, constraints) {
                        return SearchButton(
                          onTap: () {
                            FocusScope.of(context).unfocus();
                            if (cpfKey.currentState!.validate()) {
                              _.getPersonInfosByDocument(_.document.text);
                            }
                          },
                        ).paddingOnly(bottom: 10);
                      },
                    ),
                  ],
                ),
              ),
              RGInput(controller: _.registration),
              CRMInput(controller: crmController),
              NameInput(
                controller: _.name,
                label: 'Nome do profissional',
                hint: 'Nome completo do especialista',
              ),
              GenderDropdownMenu(controller: _.gender),
              10.heightGap,
              MaritalStatusDropdownMenu(controller: _.maritalStatus),
              10.heightGap,
              DateInput(label: 'Data de nascimento', controller: _.birthDay),
              PhoneInput(controller: _.phone),
              EmailInput(controller: _.email),
            ],
          ),
        );
      },
    );
  }
}
