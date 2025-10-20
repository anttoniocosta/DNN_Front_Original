import 'package:dnn_core/all_exports.dart';
import 'package:dnn_dependencies/get_export.dart';
import 'package:flutter/material.dart';
import 'package:dnn_shared/shared/export.dart';

class FormPartialCompanyInfo extends StatelessWidget {
  const FormPartialCompanyInfo(
      {super.key, required this.formKey, required this.cnpjKey});

  final GlobalKey<FormState> formKey;
  final GlobalKey<FormState> cnpjKey;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProvidersController>(
      builder: (_) {
        return Form(
          key: formKey,
          child: Column(
            children: [
              Form(
                key: cnpjKey,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(flex: 3, child: CNPJInput(controller: _.document)),
                    10.widthGap,
                    SearchButton(
                      onTap: () {
                        FocusScope.of(context).unfocus();
                        if (cnpjKey.currentState!.validate()) {
                          _.getPersonInfosByDocument(_.document.text);
                        }
                      },
                    ),
                  ],
                ),
              ),
              NameInput(
                label: 'Nome da Empresa',
                controller: _.name,
                hint: 'Nome da sua empresa',
              ),
              DateInput(label: 'Data de Criação', controller: _.birthDay),
              PhoneInput(controller: _.phone),
              EmailInput(controller: _.email),
            ],
          ),
        );
      },
    );
  }
}
