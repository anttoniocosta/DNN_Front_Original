class ShoppingCartItemsResponse {
  String? cartId;
  List<ShoppingCartItemsModel>? items;

  ShoppingCartItemsResponse({this.cartId, this.items});

  ShoppingCartItemsResponse.fromJson(Map<String, dynamic> json) {
    cartId = json['cartId'];
    if (json['items'] != null) {
      items = <ShoppingCartItemsModel>[];
      json['items'].forEach((v) {
        items!.add(new ShoppingCartItemsModel.fromJson(v));
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

class ShoppingCartItemsModel {
  int? value;
  String? label;
  double? total;
  List<CartItemModel>? items;

  ShoppingCartItemsModel({this.value, this.label, this.total, this.items});

  ShoppingCartItemsModel.fromJson(Map<String, dynamic> json) {
    value = json['value'];
    label = json['label'];
    total = json['total'];
    if (json['items'] != null) {
      items = <CartItemModel>[];
      json['items'].forEach((v) {
        items!.add(new CartItemModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['value'] = this.value;
    data['label'] = this.label;
    data['total'] = this.total;
    if (this.items != null) {
      data['items'] = this.items!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class CartItemModel {
  double? total;
  CartItemPersonModel? person;
  List<CartItemProductModel>? products;

  CartItemModel({this.total, this.person, this.products});

  CartItemModel.fromJson(Map<String, dynamic> json) {
    total = json['total'];
    person = json['person'] != null
        ? new CartItemPersonModel.fromJson(json['person'])
        : null;
    if (json['products'] != null) {
      products = <CartItemProductModel>[];
      json['products'].forEach((v) {
        products!.add(new CartItemProductModel.fromJson(v));
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

class CartItemPersonModel {
  String? personId;
  String? fullName;
  bool? isHolder;

  CartItemPersonModel({this.personId, this.fullName, this.isHolder});

  CartItemPersonModel.fromJson(Map<String, dynamic> json) {
    personId = json['personId'];
    fullName = json['fullName'];
    isHolder = json['isHolder'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['personId'] = this.personId;
    data['fullName'] = this.fullName;
    data['isHolder'] = this.isHolder;
    return data;
  }
}

class CartItemProductModel {
  String? id;
  String? productId;
  String? productName;
  int? number;
  String? title;
  double? price;

  CartItemProductModel(
      {this.id,
      this.productId,
      this.productName,
      this.number,
      this.title,
      this.price});

  CartItemProductModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    productId = json['productId'];
    productName = json['productName'];
    number = json['number'];
    title = json['title'];
    price = json['price'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['productId'] = this.productId;
    data['productName'] = this.productName;
    data['number'] = this.number;
    data['title'] = this.title;
    data['price'] = this.price;
    return data;
  }
}
