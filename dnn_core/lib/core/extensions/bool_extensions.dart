extension BoolExtensionsString on String {
  bool isHolderNameValid() {
    var values = this.split(' ');
    return values.length >= 2;
  }

  bool isNotBrandValid() {
    return this == "otherBrand" || this == "discover";
  }

  bool isDate() {
    try {
      DateTime.parse(this);
      return true;
    } catch (e) {
      return false;
    }
  }
}

extension BoolExtensionsInt on int {
  bool isStatusOk() {
    return (this >= 200 && this < 205);
  }

  bool isStatus404() {
    return (this == 404);
  }

  bool isStatus401() {
    return (this == 401);
  }

  bool isStatus500() {
    return (this == 500);
  }
}
