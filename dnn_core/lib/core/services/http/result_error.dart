class ResultError {
  late String error;
  late int code;

  ResultError({required this.error, required this.code});

  ResultError.fromJson(Map<String, dynamic> json) {
    error = json['error'];
    code = json['code'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['error'] = this.error;
    data['code'] = this.code;
    return data;
  }
}
