import 'package:dnn_core/all_exports.dart';
import 'package:dnn_dependencies/get_export.dart';
import 'package:dnn_shared/utils/constants/constants.dart';

abstract class ValidatorsCustom {
  static String? emailValidator(String? email) {
    if (email == null || email.isEmpty) {
      return 'Digite seu e-mail.';
    }
    if (!email.isEmail) {
      return 'Digite um e-mail válido.';
    }
    return null;
  }

  static String? numberValidator(String? number) {
    if (number == null || number.isEmpty) {
      return 'Digite um número.';
    }
    if (!number.isNumericOnly) {
      return 'Digite apenas números.';
    }
    return null;
  }

  static String? stringValidator(String? text) {
    if (text == null || text.isEmpty) {
      return 'Campo requerido.';
    }

    return null;
  }

  static String? crmValidator(String? number) {
    if (number == null || number.isEmpty) {
      return 'Digite um CRM válido.';
    }
    if (number.replaceAll('.', '').length < 6) {
      return 'Digite apenas números.';
    }
    return null;
  }

  static String? hourValidator(String? number) {
    if (number == null || number.isEmpty) {
      return 'Digite um horário.';
    }
    if (number.replaceAll(':', '').length < 4) {
      return 'Digite um horário completo.';
    }

    if (int.parse(number.split(":").first) > 24 ||
        int.parse(number.split(":")[1]) > 59) {
      return 'Digite um horário válido.';
    }

    return null;
  }

  static String? stateSubscriptionValidator(String? number) {
    if (number == null || number.isEmpty) {
      return 'Digite um número.';
    }
    if (number.split('').length != 9) {
      return 'Digite uma inscrição estudal válida.';
    }
    return null;
  }

  static String? pixKeyValidator(String? text) {
    if (text == null || text.isEmpty) {
      return 'Digite sua chave PIX.';
    }

    return null;
  }

  static String? passwordValidator(String? senha) {
    if (senha == null || senha.isEmpty) {
      return 'Digite a sua senha.';
    }
    return null;
  }

  static String? teamValidator(String? team) {
    if (team == null || team.isEmpty) {
      return 'Digite o nome do seu time de vendas.';
    }
    return null;
  }

  static String? refundValidator(String? reason) {
    if (reason!.trim().isEmpty) {
      return 'Nos diga seu motivo.';
    }
    return null;
  }

  static String? nameValidator(String? name) {
    if (name == null || name.isEmpty) {
      return 'Digite um nome completo.';
    }
    if (name.split(' ').length == 1) {
      return 'Digite também seu sobrenome.';
    }
    return null;
  }

  static String? phoneValidator(String? phone) {
    if (phone == null || phone.isEmpty) {
      return 'Digite um celular.';
    }
    if (!phone.isPhoneNumber || phone.length < 15) {
      return 'Digite um número válido.';
    }
    return null;
  }

  static String? rgValidator(String? cpf) {
    if (cpf == null || cpf.isEmpty) {
      return 'Digite um RG.';
    }

    return null;
  }

  static String? cpfValidator(String? cpf) {
    if (cpf == null || cpf.isEmpty) {
      return 'Digite um CPF.';
    }
    if (!cpf.isCpf) {
      return 'Digite um CPF válido.';
    }
    return null;
  }

  static String? cnpjValidator(String? cpf) {
    if (cpf == null || cpf.isEmpty) {
      return 'Digite um CNPJ.';
    }
    if (!cpf.isCnpj) {
      return 'Digite um CNPJ válido.';
    }
    return null;
  }

  static String? cpfCnpjValidator(String? doc) {
    if (doc == null ||
        doc.isEmpty ||
        doc.length < 11 ||
        doc.length == 12 ||
        doc.length == 13) {
      return 'Digite um documento válido.';
    }
    if (!doc.isCpf && doc.length == 11) {
      return 'Digite um CPF válido.';
    }
    if (!doc.isCnpj && doc.length == 14) {
      return 'Digite um CNPJ válido.';
    }
    return null;
  }

  static String? streetValidator(String? street) {
    if (street == null || street.isEmpty) {
      return 'Digite uma rua.';
    }
    return null;
  }

  static String? cityValidator(String? city) {
    if (city == null || city.isEmpty) {
      return 'Digite uma cidade.';
    }
    return null;
  }

  static String? genderValidator(String? gender) {
    if (gender == null || gender.isEmpty) {
      return 'Escolha um genêro.';
    }
    if (gender.toLowerCase() != "masculino" &&
        gender.toLowerCase() != "feminino") {
      return "Escolha um genêro.";
    }
    return null;
  }

  static String? maritalValidator(String? gender) {
    if (gender == null || gender.isEmpty) {
      return 'Escolha um estado civil.';
    }

    return null;
  }

  static String? typeScheduleValidator(String? val) {
    if (val == null || val.isEmpty) {
      return 'Escolha um tipo de consulta.';
    }

    return null;
  }

  static String? zipcodeValidator(String? zipcode) {
    if (zipcode == null || zipcode.isEmpty) {
      return 'Digite um CEP.';
    }
    if (zipcode.length != 9) {
      return 'Digite um CEP válido.';
    }

    return null;
  }

  static String? stateValidator(String? state) {
    if (state == null || state.isEmpty) {
      return 'Digite uma UF.';
    }
    if (state.length != 2) {
      return 'Digite apenas o código UF da cidade.';
    }
    if (!AppConstants.stateList.contains(state)) {
      return 'Digite um código UF válido';
    }

    return null;
  }

  static String? dateValidator(String? date) {
    if (date == null || date.isEmpty) {
      return 'Digite uma data.';
    }
    if (date.isDate()) {
      return 'Digite uma data válida.';
    }
    return null;
  }
}
