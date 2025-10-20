import 'dart:developer';

import 'package:flutter/foundation.dart';

abstract class AppTypeEnum {
  static const int CLIENT = 1;
  static const int COMPANY = 2;
  static const int CLINIC = 3;
  static const int SPECIALIST = 4;
  static const int SELLER = 5;
  static const int UNKNOWN = 6;
}

abstract class AppContextEnum {
  ///irá carregar apenas as instancias da DNN
  static const String HI = 'hi';

  /// irá carregar apenas instancias de empresas
  static const String HIC = 'hic';

  ///irá carregar apenas instancias de afiliados
  static const String HIA = 'hia';

  ///irá carregar apenas instancias de revendedor
  static const String HIR = 'hir';

  ///irá carregar apenas instancias de vendedor
  static const String HIS = 'his';
}

final appContext = AppContext();

class AppContext {
  AppContext();

  int? _type;
  String? _ctx;

  int get type => _type!;
  String? get ctx => _ctx;

  void setType(int type) {
    if (!kReleaseMode) log(type.currentType);
    this._type = type;
  }

  void setCtx(String? ctx) {
    if (ctx != null) {
      if (!kReleaseMode) log(ctx.currentContext);
      this._ctx = ctx;
    }
  }
}

extension AppContextInt on int {
  String get currentType {
    switch (this) {
      case AppTypeEnum.CLIENT:
        return 'CLIENT';
      case AppTypeEnum.COMPANY:
        return 'COMPANY';
      case AppTypeEnum.CLINIC:
        return 'CLINIC';
      case AppTypeEnum.SPECIALIST:
        return 'SPECIALIST';
      case AppTypeEnum.SELLER:
        return 'SELLER';
      case AppTypeEnum.UNKNOWN:
        return 'UNKNOWN';
      default:
        return 'UNDEFINED';
    }
  }
}

extension AppContextString on String {
  String get currentContext {
    switch (this) {
      case AppContextEnum.HI:
        return 'Instancias DNN';
      case AppContextEnum.HIC:
        return 'Instancias Empresas';
      case AppContextEnum.HIA:
        return 'Instancias Afiliados';
      case AppContextEnum.HIR:
        return 'Instancias Revendedor';
      case AppContextEnum.HIS:
        return 'Instancias Vendedor';
      default:
        return 'Instancias UNDEFINED';
    }
  }
}
