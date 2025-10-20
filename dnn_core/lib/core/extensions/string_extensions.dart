import 'package:dnn_dependencies/get_export.dart';
import 'package:dnn_shared/dnn_shared.dart';
import 'package:flutter/material.dart';

extension StringExtensions on String {
  double returnNumber() {
    return double.parse(
      this.replaceFirst('R\$', '').replaceAll('.', '').replaceAll(',', '.'),
    );
  }

  String formatDocument() {
    String cpf = '';
    try {
      if (this.length == 14) {
        cpf = UtilBrasilFields.obterCnpj(this);
      } else {
        cpf = UtilBrasilFields.obterCpf(this);
      }
    } catch (e) {
      cpf = this;
    }
    if (this == "") return "";
    return cpf;
  }

  String formartRg() {
    // Verifique se o número tem 9 dígitos
    if (int.parse(this) < 100000000 || int.parse(this) > 999999999) {
      return this;
    }

    // Formate o RG com um traço no final
    String formattedRG = this.substring(0, 2) +
        '.' +
        this.substring(2, 5) +
        '.' +
        this.substring(5, 8) +
        '-' +
        this.substring(8);

    return formattedRG;
  }

  String formatZipCode() {
    return UtilBrasilFields.obterCep(this, ponto: false);
  }

  String genderRecover() {
    return this == ''
        ? 'Masculino'
        : this == "M"
            ? 'Masculino'
            : 'Feminino';
  }

  String getLasFourDigits() {
    final number = this.replaceAll(' ', '');
    if (number.length == 16) {
      return number.substring(12, 16);
    }

    if (number.length == 15) {
      return number.substring(11, 15);
    }

    if (number.length == 14) {
      return number.substring(10, 14);
    }

    if (number.length == 13) {
      return number.substring(9, 13);
    }

    return number.substring(12, 16);
  }

  String creditCardIssuer() {
    switch (this.toLowerCase()) {
      case 'mastercard':
        return MediaRes.masterCardImage;
      case 'visa':
        return MediaRes.visaImage;
      case 'amex':
      case 'american express':
        return MediaRes.amexImage;
      case 'discover':
        return MediaRes.discoverImage;
      case 'itaú':
      case 'hipercard':
        return MediaRes.hipercardImage;
      case 'diners':
        return MediaRes.dinersImage;
      case 'elo':
        return MediaRes.eloImage;
      default:
        return MediaRes.masterCardImage;
    }
  }

  String formatPhone() {
    if (this == "") return "";
    return UtilBrasilFields.obterTelefone(this);
  }

  String formatCep() {
    return UtilBrasilFields.obterCep(this).replaceAll('.', '');
  }

  String formatDate() {
    return DateFormat('dd/MM/yyyy').format(DateTime.parse(this));
  }

  String formatReal() {
    return NumberFormat.currency(locale: 'pt_BR', symbol: "R\$")
        .format(DateTime.parse(this));
  }

  String onlyNumberStr() {
    return this.replaceAll(RegExp('[^0-9]'), '');
  }

  String formartHourFromDateIso() {
    final firstStep = this.split('T').last;
    final secondStep = firstStep.split(':');
    return '${secondStep[0]}:${secondStep[1]}';
  }

  String gnBrandName() {
    switch (this.toLowerCase()) {
      case "master":
        return "mastercard";
      case "visa":
        return "visa";
      case "amex":
        return "amex";
      case "diners":
        return "diners";
      case "hipercard":
        return "hipercard";
      case "elo":
        return "elo";
      default:
        return "";
    }
  }

  String gnMonth() {
    return this.split("/")[0];
  }

  String gnYear() {
    return "20${this.split("/")[1]}";
  }

  String removeDocumentMask() {
    if (this.isCpf) {
      String cpfDotOff = this.replaceAll('.', '');
      String cpfReturn = cpfDotOff.replaceFirst('-', '');
      return cpfReturn;
    } else if (this.isCnpj) {
      String cpfDotOff = this.replaceAll('.', '');
      String cpfLineOff = cpfDotOff.replaceFirst('-', '');
      String cpfBarOff = cpfLineOff.replaceFirst('/', '');
      return cpfBarOff;
    } else
      return '';
  }

  String removeRgMask() {
    if (this.length == 9) {
      return this;
    }
    String rgDotOff = this.replaceFirst('-', '');
    return rgDotOff;
  }

  String formatDateIso() {
    final dateFormart = DateFormat('dd/MM/yyyy');
    var outputFormat = DateFormat('yyyy-MM-dd');

    final dateParsed = dateFormart.parse(this);
    var outputDate = outputFormat.format(dateParsed);

    return '${outputDate}T00:00:00.000Z';
  }

  String formatDateFromIso() {
    final dateWithoutIso = this.split('T');
    final outputFormat = DateFormat('dd/MM/yyyy');
    var dateFormart = DateFormat('yyyy-MM-dd');
    final dateParsed = dateFormart.parse(dateWithoutIso[0]);
    var outputDate = outputFormat.format(dateParsed);
    return outputDate;
  }

  String formatDateFromIsoShort() {
    final dateWithoutIso = this.split('T');
    final outputFormat = DateFormat('dd/MM');
    var dateFormart = DateFormat('yyyy-MM-dd');
    final dateParsed = dateFormart.parse(dateWithoutIso[0]);
    var outputDate = outputFormat.format(dateParsed);
    return outputDate;
  }

  String formatMMYYYY() {
    final dateWithoutIso = this.split('T');
    final outputFormat = DateFormat('MM/yyyy');
    var dateFormart = DateFormat('yyyy-MM-dd');
    final dateParsed = dateFormart.parse(dateWithoutIso[0]);
    var outputDate = outputFormat.format(dateParsed);
    return outputDate;
  }

  String formatMMYY() {
    final dateWithoutIso = this.split('T');
    final outputFormat = DateFormat('MM/yy');
    var dateFormart = DateFormat('yyyy-MM-dd');
    final dateParsed = dateFormart.parse(dateWithoutIso[0]);
    var outputDate = outputFormat.format(dateParsed);
    return outputDate;
  }

  String genderFormart() {
    if (this.toLowerCase() == 'masculino')
      return "M";
    else if (this.toLowerCase() == 'feminino')
      return "F";
    else
      return this;
  }

  int compareDate() {
    final expireTokenDate = DateTime.parse(this);
    final dateNow = DateTime.now();
    final isPass = dateNow.compareTo(expireTokenDate);
    return isPass;
  }
}

extension ColorExtension on String {
  toColor() {
    var hexColor = this.replaceAll("#", "");
    if (hexColor.length == 6) {
      hexColor = "FF" + hexColor;
    }
    if (hexColor.length == 8) {
      return Color(int.parse("0x$hexColor"));
    }
  }
}
