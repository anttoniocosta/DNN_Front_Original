import 'package:dnn_dependencies/get_export.dart';
import 'package:dnn_shared/dnn_shared.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class FormPartialPersonalInfo extends StatelessWidget {
  const FormPartialPersonalInfo(
      {super.key, required this.formKey, required this.cpfKey});

  final GlobalKey<FormState> formKey;
  final GlobalKey<FormState> cpfKey;

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
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('CPF:',
                        style: Fonts.bodyLarge(context).copyWith(
                          fontFamily: Fonts.poppins,
                        )),
                    10.heightGap,
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Expanded(
                          child: CPFInput(
                            controller: _.document,
                            showPrefix: false,
                          ),
                        ),
                        10.widthGap,
                        LayoutBuilder(
                          builder: (__, constraints) {
                            return SearchButton(
                              onTap: () {
                                FocusScope.of(context).unfocus();
                                if (cpfKey.currentState!.validate()) {
                                  String inputCpf = _.document.text;
                                  if (_.isCpfNotEqualToLoggedUser(inputCpf)) {
                                    _.getPersonInfosByDocument(inputCpf);
                                  } else {
                                    SnackbarCustom.snackbarError(
                                      "O CPF inserido não pode ser igual ao CPF da pessoa logada.",
                                    );
                                  }
                                }
                              },
                            ).paddingOnly(bottom: 10);
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              RGInput(controller: _.registration),
              NameInput(controller: _.name),
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

class SearchButton extends StatelessWidget {
  const SearchButton({
    super.key,
    required this.onTap,
    this.height = (kIsWeb ? 50 : 50),
  });

  final VoidCallback onTap;
  final double? height;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProvidersController>(
      builder: (_) {
        return SizedBox(
          height: height,
          child: ElevatedButton(
            onPressed: _.isLoading.value ? null : onTap,
            child: _.isLoading.value
                ? const LoadingButtonChildWidget()
                : const Icon(Icons.search, size: 26),
          ),
        );
      },
    );
  }
}
