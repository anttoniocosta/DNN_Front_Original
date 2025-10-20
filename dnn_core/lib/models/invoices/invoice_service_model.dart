class InvoiceServiceModel {
  String? orderId;
  String? personId;
  String? fullname;
  String? userClaimId;
  String? name;
  String? createDate;
  String? finishedDate;
  int? totalOrders;

  InvoiceServiceModel(
      {this.orderId,
      this.personId,
      this.fullname,
      this.userClaimId,
      this.name,
      this.createDate,
      this.finishedDate,
      this.totalOrders});

  InvoiceServiceModel.fromJson(Map<String, dynamic> json) {
    orderId = json['orderId'];
    personId = json['personId'];
    fullname = json['fullname'];
    userClaimId = json['userClaimId'];
    name = json['name'];
    createDate = json['createDate'];
    finishedDate = json['finishedDate'];
    totalOrders = json['totalOrders'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['orderId'] = this.orderId;
    data['personId'] = this.personId;
    data['fullname'] = this.fullname;
    data['userClaimId'] = this.userClaimId;
    data['name'] = this.name;
    data['createDate'] = this.createDate;
    data['finishedDate'] = this.finishedDate;
    data['totalOrders'] = this.totalOrders;
    return data;
  }
}
