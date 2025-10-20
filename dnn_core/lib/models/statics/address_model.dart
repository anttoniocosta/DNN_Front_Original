class AddressModel {
  String? zipcode;
  String? street;
  String? number;
  String? complement;
  String? neighborhood;
  String? city;
  String? state;
  String? ibge;

  AddressModel({
    this.zipcode,
    this.street,
    this.number,
    this.complement,
    this.neighborhood,
    this.city,
    this.state,
    this.ibge,
  });

  AddressModel.fromJson(Map<String, dynamic> json) {
    zipcode = json['zipcode'];
    street = json['street'];
    number = json['number'];
    complement = json['complement'];
    neighborhood = json['neighborhood'];
    city = json['city'];
    state = json['state'];
    ibge = json['ibge'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['zipcode'] = this.zipcode;
    data['street'] = this.street;
    data['city'] = this.city;
    data['number'] = this.number;
    data['complement'] = this.complement;
    data['neighborhood'] = this.neighborhood;
    data['state'] = this.state;
    data['ibge'] = this.ibge;
    return data;
  }
}
