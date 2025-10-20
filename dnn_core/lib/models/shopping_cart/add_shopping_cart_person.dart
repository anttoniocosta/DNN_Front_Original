class AddShoppingCartModel {
  String? identifier;
  String? planId;
  List<String>? complements;
  String? dependentId;

  AddShoppingCartModel(
      {this.identifier, this.planId, this.complements, this.dependentId});

  AddShoppingCartModel.fromJson(Map<String, dynamic> json) {
    identifier = json['identifier'];
    planId = json['planId'];
    complements = json['complements'].cast<String>();
    dependentId = json['dependentId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['identifier'] = this.identifier;
    data['planId'] = this.planId;
    data['complements'] = this.complements;
    data['dependentId'] = this.dependentId;
    return data;
  }
}
