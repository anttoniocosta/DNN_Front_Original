class MyAppointmentsClinicResponseModel {
  String? date;
  List<MyAppointmentsResponseModel>? schedules;

  MyAppointmentsClinicResponseModel({this.schedules, this.date});

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'date': date,
      'schedules': schedules!.map((x) => x.toJson()).toList(),
    };
  }

  factory MyAppointmentsClinicResponseModel.fromJson(Map<String, dynamic> map) {
    return MyAppointmentsClinicResponseModel(
      date: map['date'] != null ? map['date'] as String : null,
      schedules: map['schedules'] != null
          ? List<MyAppointmentsResponseModel>.from(
              (map['schedules'] as List<dynamic>)
                  .map<MyAppointmentsResponseModel?>(
                (x) => MyAppointmentsResponseModel.fromJson(
                    x as Map<String, dynamic>),
              ),
            )
          : null,
    );
  }
}

class AppointmentStatusModel {
  int? id;
  String? name;
  int? quantity;

  AppointmentStatusModel({this.id, this.name, this.quantity});

  AppointmentStatusModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    quantity = json['quantity'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['quantity'] = this.quantity;
    return data;
  }
}

class MyAppointmentsResponseModel {
  String? id;
  String? specialistId;
  String? clinicId;
  bool? isReadyService;
  bool? isAcceptsDnnPlan;
  double? price;
  int? typeScheduleId;
  String? typeScheduleName;
  String? scheduleAt;
  String? dateSchedule;
  int? specialtyId;
  String? specialtyName;
  String? dateRescheduleConfirm;
  String? dateFinished;
  String? dateReschedule;
  String? dateCancel;
  String? dateCancelConfirm;
  String? dateSell;
  String? reasonCancel;
  bool? isSamePerson;
  MyAppoitmentPersonModel? clinic;
  MyAppoitmentPersonModel? owner;
  MyAppoitmentPersonModel? patient;
  MyAppoitmentDoctorModel? doctor;
  String? mainComplaint;
  String? currentMedication;
  String? medicalHistory;
  String? channelName;
  bool? isScreening;
  bool? isRapidoc;
  bool? isPayment;
  String? paymentStateName;
  int? paymentStateId;
  String? rapidocUrl;

  MyAppointmentsResponseModel({
    this.id,
    this.specialistId,
    this.clinicId,
    this.isReadyService,
    this.isAcceptsDnnPlan,
    this.price,
    this.typeScheduleId,
    this.typeScheduleName,
    this.scheduleAt,
    this.dateSchedule,
    this.specialtyId,
    this.specialtyName,
    this.dateRescheduleConfirm,
    this.dateFinished,
    this.dateReschedule,
    this.dateCancel,
    this.dateCancelConfirm,
    this.dateSell,
    this.reasonCancel,
    this.isSamePerson,
    this.clinic,
    this.owner,
    this.doctor,
    this.patient,
    this.mainComplaint,
    this.currentMedication,
    this.medicalHistory,
    this.channelName,
    this.isScreening,
    this.rapidocUrl,
    this.isRapidoc,
    this.paymentStateId,
    this.paymentStateName,
    this.isPayment,
  });

  MyAppointmentsResponseModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    specialistId = json['specialistId'];
    clinicId = json['clinicId'];
    isReadyService = json['isReadyService'];
    isAcceptsDnnPlan = json['isAcceptsDnnPlan'];
    price = json['price'];
    typeScheduleId = json['typeScheduleId'];
    typeScheduleName = json['typeScheduleName'];
    scheduleAt = json['scheduleAt'];
    dateSchedule = json['dateSchedule'];
    specialtyId = json['specialtyId'];
    specialtyName = json['specialtyName'];
    dateRescheduleConfirm = json['dateRescheduleConfirm'];
    dateFinished = json['dateFinished'];
    dateReschedule = json['dateReschedule'];
    dateCancel = json['dateCancel'];
    dateCancelConfirm = json['dateCancelConfirm'];
    dateSell = json['dateSell'];
    reasonCancel = json['reasonCancel'];
    isSamePerson = json['isSamePerson'];
    mainComplaint = json['mainComplaint'];
    currentMedication = json['currentMedication'];
    medicalHistory = json['medicalHistory'];
    channelName = json['channelName'];
    isScreening = json['isScreening'];
    rapidocUrl = json['rapidocUrl'];
    isRapidoc = json['isRapidoc'];
    paymentStateId = json['paymentStateId'];
    paymentStateName = json['paymentStateName'];
    isPayment = json['isPayment'];
    clinic = json['clinic'] != null
        ? new MyAppoitmentPersonModel.fromJson(json['clinic'])
        : null;
    doctor = json['doctor'] != null
        ? new MyAppoitmentDoctorModel.fromJson(json['doctor'])
        : null;
    owner = json['owner'] != null
        ? new MyAppoitmentPersonModel.fromJson(json['owner'])
        : null;
    patient = json['patient'] != null
        ? new MyAppoitmentPersonModel.fromJson(json['patient'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['specialistId'] = this.specialistId;
    data['clinicId'] = this.clinicId;
    data['isReadyService'] = this.isReadyService;
    data['isAcceptsDnnPlan'] = this.isAcceptsDnnPlan;
    data['price'] = this.price;
    data['typeScheduleId'] = this.typeScheduleId;
    data['typeScheduleName'] = this.typeScheduleName;
    data['scheduleAt'] = this.scheduleAt;
    data['dateSchedule'] = this.dateSchedule;
    data['specialtyId'] = this.specialtyId;
    data['specialtyName'] = this.specialtyName;
    data['dateRescheduleConfirm'] = this.dateRescheduleConfirm;
    data['dateFinished'] = this.dateFinished;
    data['dateReschedule'] = this.dateReschedule;
    data['dateCancel'] = this.dateCancel;
    data['dateCancelConfirm'] = this.dateCancelConfirm;
    data['dateSell'] = this.dateSell;
    data['reasonCancel'] = this.reasonCancel;
    data['isSamePerson'] = this.isSamePerson;
    data['mainComplaint'] = this.mainComplaint;
    data['currentMedication'] = this.currentMedication;
    data['medicalHistory'] = this.medicalHistory;
    data['channelName'] = this.channelName;
    data['isScreening'] = this.isScreening;
    data['rapidocUrl'] = this.rapidocUrl;
    data['isRapidoc'] = this.isRapidoc;
    data['paymentStateId'] = this.paymentStateId;
    data['paymentStateName'] = this.paymentStateName;
    data['isPayment'] = this.isPayment;
    if (this.clinic != null) {
      data['clinic'] = this.clinic!.toJson();
    }
    if (this.doctor != null) {
      data['doctor'] = this.doctor!.toJson();
    }
    if (this.owner != null) {
      data['owner'] = this.owner!.toJson();
    }
    if (this.patient != null) {
      data['patient'] = this.patient!.toJson();
    }
    return data;
  }
}

class MyAppoitmentDoctorModel {
  String? id;
  String? name;
  String? crm;

  MyAppoitmentDoctorModel({this.id, this.name, this.crm});

  MyAppoitmentDoctorModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    crm = json['crm'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['crm'] = this.crm;
    return data;
  }
}

class MyAppoitmentPersonModel {
  String? id;
  String? name;
  String? email;
  String? birthday;
  String? phoneNumber;
  String? photo;
  String? zipcode;
  String? address;
  String? city;
  String? state;
  String? number;
  String? complement;
  String? neighborhood;
  String? document;
  String? gender;
  int? age;

  MyAppoitmentPersonModel(
      {this.id,
      this.name,
      this.email,
      this.birthday,
      this.phoneNumber,
      this.photo,
      this.zipcode,
      this.address,
      this.city,
      this.state,
      this.number,
      this.complement,
      this.document,
      this.gender,
      this.age,
      this.neighborhood});

  MyAppoitmentPersonModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    birthday = json['birthday'];
    phoneNumber = json['phoneNumber'];
    photo = json['photo'];
    zipcode = json['zipcode'];
    address = json['address'];
    city = json['city'];
    state = json['state'];
    number = json['number'];
    complement = json['complement'];
    neighborhood = json['neighborhood'];
    gender = json['gender'];
    age = json['age'];
    document = json['document'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['email'] = this.email;
    data['birthday'] = this.birthday;
    data['phoneNumber'] = this.phoneNumber;
    data['photo'] = this.photo;
    data['zipcode'] = this.zipcode;
    data['address'] = this.address;
    data['city'] = this.city;
    data['state'] = this.state;
    data['number'] = this.number;
    data['complement'] = this.complement;
    data['neighborhood'] = this.neighborhood;
    data['gender'] = this.gender;
    data['age'] = this.age;
    data['document'] = this.document;
    return data;
  }
}
