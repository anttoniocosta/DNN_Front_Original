class InstallmentsResponse {
  int? installment;
  bool? hasInterest;
  int? value;
  String? currency;
  int? interestPercentage;

  InstallmentsResponse(
      {this.installment,
      this.hasInterest,
      this.value,
      this.currency,
      this.interestPercentage});

  InstallmentsResponse.fromJson(Map<String, dynamic> json) {
    installment = json['installment'];
    hasInterest = json['has_interest'];
    value = json['value'];
    currency = json['currency'];
    interestPercentage = json['interest_percentage'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['installment'] = this.installment;
    data['has_interest'] = this.hasInterest;
    data['value'] = this.value;
    data['currency'] = this.currency;
    data['interest_percentage'] = this.interestPercentage;
    return data;
  }
}
