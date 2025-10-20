class OffersResponseModel {
  OffersPersonModel? person;
  List<OffersModel>? offers;

  OffersResponseModel({this.person, this.offers});

  OffersResponseModel.fromJson(Map<String, dynamic> json) {
    person = json['person'] != null
        ? OffersPersonModel.fromJson(json['person'])
        : null;
    if (json['offers'] != null) {
      offers = <OffersModel>[];
      json['offers'].forEach((v) {
        offers!.add(OffersModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (person != null) {
      data['person'] = person!.toJson();
    }
    if (offers != null) {
      data['offers'] = offers!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class OffersPersonModel {
  String? id;
  String? name;
  bool? isActive;
  String? validate;
  String? document;

  OffersPersonModel({this.id, this.name, this.isActive, this.validate});

  OffersPersonModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    isActive = json['isActive'];
    validate = json['validate'];
    document = json['document'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['isActive'] = isActive;
    data['validate'] = validate;
    data['document'] = document;
    return data;
  }
}

class OffersModel {
  int? id;
  String? name;
  String? phoneNumber;
  double? discount;
  String? zipcode;
  String? color;
  String? colorDark;
  String? title;
  bool? isHome;
  String? address;
  String? number;
  String? neighborhood;
  String? city;
  int? cityId;
  String? state;
  String? logo;
  String? descriptions;
  bool? enabled;

  OffersModel(
      {this.id,
      this.name,
      this.phoneNumber,
      this.discount,
      this.zipcode,
      this.address,
      this.number,
      this.neighborhood,
      this.city,
      this.cityId,
      this.state,
      this.logo,
      this.descriptions,
      this.color,
      this.colorDark,
      this.isHome,
      this.title,
      this.enabled});

  OffersModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    phoneNumber = json['phoneNumber'];
    discount = json['discount'];
    zipcode = json['zipcode'];
    address = json['address'];
    number = json['number'];
    neighborhood = json['neighborhood'];
    city = json['city'];
    cityId = json['cityId'];
    state = json['state'];
    logo = json['logo'];
    descriptions = json['descriptions'];
    enabled = json['enabled'];
    color = json['color'];
    colorDark = json['colorDark'];
    title = json['title'];
    isHome = json['isHome'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['phoneNumber'] = phoneNumber;
    data['discount'] = discount;
    data['zipcode'] = zipcode;
    data['address'] = address;
    data['number'] = number;
    data['neighborhood'] = neighborhood;
    data['city'] = city;
    data['cityId'] = cityId;
    data['state'] = state;
    data['logo'] = logo;
    data['descriptions'] = descriptions;
    data['enabled'] = enabled;
    data['title'] = title;
    data['colorDark'] = colorDark;
    data['color'] = color;
    data['isHome'] = isHome;
    return data;
  }
}
