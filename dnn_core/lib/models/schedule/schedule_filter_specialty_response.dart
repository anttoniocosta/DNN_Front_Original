class ScheduleFilterSpecialtyResponse {
  int? id;
  String? name;
  bool? isReadyService;
  String? state;

  ScheduleFilterSpecialtyResponse(
      {this.id, this.name, this.isReadyService, this.state});

  ScheduleFilterSpecialtyResponse.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    isReadyService = json['isReadyService'];
    state = json['state'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['isReadyService'] = this.isReadyService;
    data['state'] = this.state;
    return data;
  }
}
