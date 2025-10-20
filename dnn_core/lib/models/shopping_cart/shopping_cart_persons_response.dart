class ShoppingCartPersonsResponse {
  String? cartId;
  List<ShoppingCartProducts>? items;

  ShoppingCartPersonsResponse({this.cartId, this.items});

  ShoppingCartPersonsResponse.fromJson(Map<String, dynamic> json) {
    cartId = json['cartId'];
    if (json['items'] != null) {
      items = <ShoppingCartProducts>[];
      json['items'].forEach((v) {
        items!.add(new ShoppingCartProducts.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['cartId'] = this.cartId;
    if (this.items != null) {
      data['items'] = this.items!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ShoppingCartProducts {
  double? total;
  CartProductPerson? person;
  List<CartProductsModel>? products;

  ShoppingCartProducts({this.total, this.person, this.products});

  ShoppingCartProducts.fromJson(Map<String, dynamic> json) {
    total = json['total'];
    person = json['person'] != null
        ? new CartProductPerson.fromJson(json['person'])
        : null;
    if (json['products'] != null) {
      products = <CartProductsModel>[];
      json['products'].forEach((v) {
        products!.add(new CartProductsModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['total'] = this.total;
    if (this.person != null) {
      data['person'] = this.person!.toJson();
    }
    if (this.products != null) {
      data['products'] = this.products!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class CartProductPerson {
  String? personId;
  String? fullName;

  CartProductPerson({this.personId, this.fullName});

  CartProductPerson.fromJson(Map<String, dynamic> json) {
    personId = json['personId'];
    fullName = json['fullName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['personId'] = this.personId;
    data['fullName'] = this.fullName;
    return data;
  }
}

class CartProductsModel {
  String? productId;
  String? productName;
  double? productPrice;
  bool? isSubscription;
  bool? hasFidelity;
  int? fidelityMonth;

  CartProductsModel(
      {this.productId,
      this.productName,
      this.productPrice,
      this.fidelityMonth,
      this.hasFidelity,
      this.isSubscription});

  CartProductsModel.fromJson(Map<String, dynamic> json) {
    productId = json['productId'];
    productName = json['productName'];
    productPrice = json['productPrice'];
    fidelityMonth = json['fidelityMonth'];
    isSubscription = json['isSubscription'];
    hasFidelity = json['hasFidelity'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['productId'] = this.productId;
    data['productName'] = this.productName;
    data['productPrice'] = this.productPrice;
    data['isSubscription'] = this.isSubscription;
    data['fidelityMonth'] = this.fidelityMonth;
    data['hasFidelity'] = this.hasFidelity;
    return data;
  }
}
