import 'package:dnn_dependencies/dnn_dependencies.dart' as input;
import 'package:dnn_dependencies/get_export.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../dnn_shared.dart';

class RGInput extends StatelessWidget {
  const RGInput({
    super.key,
    required this.controller,
    this.isEnabled = true,
  });
  final TextEditingController controller;
  final bool? isEnabled;

  @override
  Widget build(BuildContext context) {
    return StandartTextField(
      labelText: 'RG',
      controller: controller,
      validator: ValidatorsCustom.rgValidator,
      inputFormatters: [CustomFormatters.rgFormatter],
      keyboardType: TextInputType.number,
      isSecret: false,
      hintText: '12345678-1',
      maxLines: 1,
      isEnabled: isEnabled,
    );
  }
}

class CPFInput extends StatelessWidget {
  const CPFInput({
    super.key,
    required this.controller,
    this.isEnabled = true,
    this.showPrefix = true,
    this.showHint = false,
  });
  final TextEditingController controller;
  final bool? isEnabled;
  final bool showPrefix;
  final bool showHint;

  @override
  Widget build(BuildContext context) {
    return StandartTextField(
      controller: controller,
      validator: ValidatorsCustom.cpfValidator,
      keyboardType: TextInputType.number,
      isSecret: false,
      prefixText: showPrefix ? 'CPF' : null,
      labelText: showHint ? 'CPF' : null,
      hintText: 'Digite o seu CPF',
      inputFormatters: [CustomFormatters.cpfFormatter],
      maxLines: 1,
      isEnabled: isEnabled,
    );
  }
}

class CNPJInput extends StatelessWidget {
  const CNPJInput({
    super.key,
    required this.controller,
    this.isEnabled = true,
    this.showPrefix = true,
    this.showHint = false,
  });
  final TextEditingController controller;
  final bool? isEnabled;
  final bool showPrefix;
  final bool showHint;

  @override
  Widget build(BuildContext context) {
    return StandartTextField(
      prefixText: showPrefix ? 'CNPJ' : null,
      labelText: showHint ? 'CNPJ' : null,
      controller: controller,
      keyboardType: TextInputType.number,
      inputFormatters: [CustomFormatters.cnpjFormatter],
      validator: ValidatorsCustom.cnpjValidator,
      hintText: 'Digite o seu CNPJ',
      maxLines: 1,
      isEnabled: isEnabled,
    );
  }
}

class CPFCNPJInput extends StatelessWidget {
  const CPFCNPJInput({
    super.key,
    required this.controller,
    this.isEnabled = true,
    this.showPrefix = true,
    this.showHint = false,
  });
  final TextEditingController controller;
  final bool? isEnabled;
  final bool showPrefix;
  final bool showHint;

  @override
  Widget build(BuildContext context) {
    return StandartTextField(
      prefixText: showPrefix ? 'CNPJ/CPF' : null,
      labelText: showHint ? 'CNPJ/CPF' : null,
      controller: controller,
      keyboardType: TextInputType.number,
      inputFormatters: [CustomFormatters.cnpjCpfFormatter],
      validator: ValidatorsCustom.cpfCnpjValidator,
      hintText: 'Digite o CPF ou CNPJ',
      maxLines: 1,
      isEnabled: isEnabled,
    );
  }
}

class PasswordInput extends StatelessWidget {
  const PasswordInput(
      {super.key,
      required this.controller,
      this.label,
      this.validator,
      this.showIcon = false});

  final TextEditingController controller;
  final String? label;
  final String? Function(String?)? validator;
  final bool showIcon;

  @override
  Widget build(BuildContext context) {
    return StandartTextField(
      labelText: label ?? 'Senha',
      controller: controller,
      validator: validator ?? ValidatorsCustom.passwordValidator,
      hintText: 'Digite sua senha',
      prefixIcon: showIcon
          ? Padding(
              padding: const EdgeInsets.all(14),
              child: SvgPicture.asset(MediaRes.lock),
            )
          : null,
      isSecret: true,
      maxLines: 1,
    );
  }
}

class NameInput extends StatelessWidget {
  const NameInput({super.key, required this.controller, this.label, this.hint});
  final TextEditingController controller;
  final String? label;
  final String? hint;

  @override
  Widget build(BuildContext context) {
    return StandartTextField(
      labelText: label ?? 'Nome completo',
      controller: controller,
      validator: ValidatorsCustom.nameValidator,
      keyboardType: TextInputType.text,
      hintText: hint ?? 'Joao Augusto',
      maxLines: 1,
    );
  }
}

class DateInput extends StatelessWidget {
  const DateInput({
    super.key,
    required this.controller,
    required this.label,
  });
  final TextEditingController controller;
  final String label;

  @override
  Widget build(BuildContext context) {
    return StandartTextField(
      labelText: label,
      controller: controller,
      validator: ValidatorsCustom.dateValidator,
      keyboardType: TextInputType.datetime,
      inputFormatters: [CustomFormatters.dateFormatter],
      hintText: '01/01/2000',
      maxLines: 1,
    );
  }
}

class PhoneInput extends StatelessWidget {
  const PhoneInput({super.key, required this.controller});
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return StandartTextField(
      labelText: 'Telefone',
      controller: controller,
      inputFormatters: [CustomFormatters.phoneFormatter],
      validator: ValidatorsCustom.phoneValidator,
      keyboardType: TextInputType.phone,
      hintText: '(11) 99999-9999',
    );
  }
}

class EmailInput extends StatelessWidget {
  const EmailInput({super.key, required this.controller});
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return StandartTextField(
      labelText: 'E-mail',
      controller: controller,
      validator: ValidatorsCustom.emailValidator,
      keyboardType: TextInputType.emailAddress,
      hintText: 'seunome@email.com',
      maxLines: 1,
    );
  }
}

class CEPInput extends StatelessWidget {
  const CEPInput({super.key, required this.controller});
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return StandartTextField(
      prefixText: 'CEP',
      controller: controller,
      keyboardType: TextInputType.number,
      validator: ValidatorsCustom.zipcodeValidator,
      inputFormatters: [CustomFormatters.zipcodeFormatter],
      hintText: '01234-567',
      maxLines: 1,
    );
  }
}

class StreetInput extends StatelessWidget {
  const StreetInput({super.key, required this.controller});
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return StandartTextField(
      prefixText: 'Rua',
      controller: controller,
      validator: ValidatorsCustom.streetValidator,
      hintText: 'Rua Andromeda',
      maxLines: 1,
    );
  }
}

class NumberInput extends StatelessWidget {
  const NumberInput({super.key, required this.controller});
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return StandartTextField(
      prefixText: 'Nº',
      controller: controller,
      validator: ValidatorsCustom.numberValidator,
      keyboardType: TextInputType.number,
      hintText: '0123',
      maxLines: 1,
    );
  }
}

class StateSubscriptionInput extends StatelessWidget {
  const StateSubscriptionInput({
    super.key,
    required this.controller,
    this.isEnabled = true,
  });
  final TextEditingController controller;
  final bool? isEnabled;

  @override
  Widget build(BuildContext context) {
    return StandartTextField(
      prefixText: 'Inscrição estadual',
      controller: controller,
      validator: ValidatorsCustom.numberValidator,
      keyboardType: TextInputType.number,
      hintText: '112345678',
      maxLines: 1,
      inputFormatters: [CustomFormatters.stateSubscriptionFormatter],
      isEnabled: isEnabled,
    );
  }
}

class ComplementInput extends StatelessWidget {
  const ComplementInput({super.key, required this.controller});
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return StandartTextField(
      prefixText: 'Complemento (opcional)',
      controller: controller,
      hintText: 'Condomínio principal, 4º andar',
      maxLines: 1,
    );
  }
}

class NeighborhoodInput extends StatelessWidget {
  const NeighborhoodInput({super.key, required this.controller});
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return StandartTextField(
      prefixText: 'Bairro',
      controller: controller,
      validator: ValidatorsCustom.cityValidator,
      maxLines: 1,
      hintText: 'Bairro onde mora',
    );
  }
}

class CityInput extends StatelessWidget {
  const CityInput({super.key, required this.controller});
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return StandartTextField(
      prefixText: 'Cidade',
      controller: controller,
      validator: ValidatorsCustom.cityValidator,
      keyboardType: TextInputType.text,
      maxLines: 1,
      hintText: 'Cidade onde mora',
    );
  }
}

class StateInput extends StatelessWidget {
  const StateInput({super.key, required this.controller});
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return StandartTextField(
      prefixText: 'UF',
      controller: controller,
      validator: ValidatorsCustom.stateValidator,
      keyboardType: TextInputType.text,
      maxLines: 1,
      hintText: 'SP',
    );
  }
}

class TeamNameInput extends StatelessWidget {
  const TeamNameInput({super.key, required this.controller});
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return StandartTextField(
      labelText: 'Nome do time',
      controller: controller,
      validator: ValidatorsCustom.teamValidator,
      hintText: 'Nome do meu time',
      maxLines: 1,
    );
  }
}

class RefundInput extends StatelessWidget {
  const RefundInput({super.key, required this.controller});
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return StandartTextField(
      validator: ValidatorsCustom.refundValidator,
      labelText: 'Motivo',
      hintText: 'Digite aqui o motivo para entendermos sua decisão.',
      isSecret: false,
      controller: controller,
      maxLines: 10,
      maxLength: 400,
    );
  }
}

class CCVInput extends StatelessWidget {
  const CCVInput({super.key, required this.controller});
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return StandartTextField(
      controller: controller,
      keyboardType: TextInputType.number,
      inputFormatters: [
        LengthLimitingTextInputFormatter(4),
        FilteringTextInputFormatter.digitsOnly
      ],
      labelText: 'CCV',
      hintText: 'Ex: 0123',
      validator: (value) {
        if (value!.isEmpty) {
          return 'Campo obrigatório';
        }
        if (value.length < 3) {
          return 'Digite um CCV válido';
        }
        return null;
      },
    );
  }
}

class CRMInput extends StatelessWidget {
  const CRMInput({super.key, required this.controller, this.isEnabled = true});
  final TextEditingController controller;

  final bool? isEnabled;

  @override
  Widget build(BuildContext context) {
    return StandartTextField(
      labelText: 'CRM/CRO',
      controller: controller,
      validator: ValidatorsCustom.crmValidator,
      keyboardType: TextInputType.number,
      inputFormatters: [
        LengthLimitingTextInputFormatter(9),
      ],
      hintText: 'Seu CRM ou CRO aqui',
      maxLines: 1,
      isEnabled: isEnabled,
    );
  }
}

class HourInput extends StatelessWidget {
  const HourInput({super.key, required this.controller});
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return StandartTextField(
      labelText: 'Hora',
      controller: controller,
      validator: ValidatorsCustom.hourValidator,
      keyboardType: TextInputType.number,
      inputFormatters: [CustomFormatters.hourFormatter],
      hintText: 'Ex.: 11:00',
      maxLines: 1,
    );
  }
}

class PriceInput extends StatelessWidget {
  const PriceInput(
      {super.key,
      required this.controller,
      this.label,
      this.hint,
      this.onChanged,
      this.needValidate = true});
  final TextEditingController controller;
  final String? label;
  final String? hint;
  final Function(String)? onChanged;
  final bool? needValidate;

  @override
  Widget build(BuildContext context) {
    return StandartTextField(
      labelText: label ?? 'Valor da consulta',
      controller: controller,
      inputFormatters: [
        FilteringTextInputFormatter.digitsOnly,
        CurrencyInputFormatter(),
      ],
      keyboardType: TextInputType.number,
      hintText: hint ?? 'R\$ 0,00',
      maxLines: 1,
      onChanged: onChanged,
      validator: needValidate! ? ValidatorsCustom.numberValidator : null,
    );
  }
}

class CurrencyInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    if (newValue.selection.baseOffset == 0) {
      return const TextEditingValue();
    }
    double value = double.parse(newValue.text);
    final formatter = input.NumberFormat.simpleCurrency(locale: "pt_Br");
    String newText = formatter.format(value / 100);
    return newValue.copyWith(
      text: newText,
      selection: TextSelection.collapsed(offset: newText.length),
    );
  }
}

/// [DROPDOWNS] ********************************************************************

class GenderDropdownMenu extends StatelessWidget {
  const GenderDropdownMenu({
    super.key,
    this.isEnabled = true,
    required this.controller,
  });

  final bool? isEnabled;
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProvidersController>(builder: (_) {
      return DropdownStandard(
        controller: controller,
        listOptions: const <String>['Feminino', 'Masculino'],
        hintText: 'Selecione um gênero',
        labelText: 'Sexo',
        onChanged: (val) {
          final gender = val!.genderFormart();
          controller.text = gender;
        },
        validator: ValidatorsCustom.genderValidator,
      );
    });
  }
}

class MaritalStatusDropdownMenu extends StatelessWidget {
  const MaritalStatusDropdownMenu({
    super.key,
    this.isEnabled = true,
    required this.controller,
  });

  final bool? isEnabled;
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    final maritalStatusOptions = accountController.maritalStatusList
        .map((e) {
          if (e.text != null) {
            return e.text!.capitalizeFirst;
          }
        })
        .nonNulls
        .toList();
    return GetBuilder<ProvidersController>(builder: (_) {
      return DropdownStandard(
        controller: controller,
        listOptions: maritalStatusOptions,
        hintText: 'Selecione um estado civil',
        labelText: 'Estado Civil',
        onChanged: (val) {
          controller.text = val!;
        },
        validator: ValidatorsCustom.maritalValidator,
      );
    });
  }
}
