class SellerLinkModel {
  String? name;
  String? url;
  SellerLinkModel({
    this.name,
    this.url,
  });

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'name': name,
      'url': url,
    };
  }

  SellerLinkModel.fromJson(Map<String, dynamic> map) {
    name = map['name'] != null ? map['name'] as String : null;
    url = map['url'] != null ? map['url'] as String : null;
  }
}
