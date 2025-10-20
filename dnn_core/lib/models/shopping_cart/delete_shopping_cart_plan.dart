class DeleteShoppingCartPlan {
  String? cartId;
  String? personId;
  String? planId;

  DeleteShoppingCartPlan({this.cartId, this.personId, this.planId});

  DeleteShoppingCartPlan.fromJson(Map<String, dynamic> json) {
    cartId = json['cartId'];
    personId = json['personId'];
    planId = json['planId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['cartId'] = this.cartId;
    data['personId'] = this.personId;
    data['planId'] = this.planId;
    return data;
  }
}
