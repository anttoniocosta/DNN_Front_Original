class DeleteShoppingCartPerson {
  String? cartId;
  String? personId;

  DeleteShoppingCartPerson({this.cartId, this.personId});

  DeleteShoppingCartPerson.fromJson(Map<String, dynamic> json) {
    cartId = json['cartId'];
    personId = json['personId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['cartId'] = this.cartId;
    data['personId'] = this.personId;
    return data;
  }
}
