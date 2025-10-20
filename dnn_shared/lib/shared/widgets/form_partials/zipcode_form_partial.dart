import 'package:dnn_core/all_exports.dart';
import 'package:dnn_dependencies/get_export.dart';
import 'package:flutter/material.dart';

import 'package:dnn_shared/shared/export.dart';

class FormPartialZipcode extends StatelessWidget {
  const FormPartialZipcode(
      {super.key, required this.formKey, required this.zipcodeKey});

  final GlobalKey<FormState> formKey;
  final GlobalKey<FormState> zipcodeKey;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProvidersController>(
      builder: (_) {
        return Form(
          key: formKey,
          child: Column(
            children: [
              Form(
                key: zipcodeKey,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Expanded(
                      flex: 3,
                      child: CEPInput(controller: _.zipCode),
                    ),
                    const SizedBox(width: 10),
                    SearchButton(
                      onTap: () {
                        FocusScope.of(context).unfocus();
                        if (zipcodeKey.currentState!.validate()) {
                          _.getUserAddressByCep(_.zipCode.text);
                        }
                      },
                    ),
                  ],
                ),
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(flex: 3, child: StreetInput(controller: _.address)),
                  const SizedBox(width: 10),
                  Expanded(flex: 2, child: NumberInput(controller: _.number))
                ],
              ),
              ComplementInput(controller: _.complement),
              NeighborhoodInput(controller: _.neighborhood),
              CityInput(controller: _.city),
              StateInput(controller: _.state),
            ],
          ),
        );
      },
    );
  }
}
