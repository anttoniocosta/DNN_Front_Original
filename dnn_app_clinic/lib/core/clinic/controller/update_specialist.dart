import 'package:dnn_app_clinic/core/clinic/repository/clinic_repository.dart';
import 'package:dnn_shared/dnn_shared.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UpdateSpecialistController extends GetxController {
  final IClinicRepository _repository;

  UpdateSpecialistController({required IClinicRepository repository})
      : _repository = repository;

  TextEditingController state = TextEditingController();
  TextEditingController city = TextEditingController();
  TextEditingController zipcode = TextEditingController();
  TextEditingController neighborhood = TextEditingController();
  TextEditingController complement = TextEditingController();
  TextEditingController number = TextEditingController();
  TextEditingController address = TextEditingController();

  TextEditingController email = TextEditingController();
  TextEditingController phone = TextEditingController();
  TextEditingController birthDay = TextEditingController();
  TextEditingController gender = TextEditingController();
  TextEditingController name = TextEditingController();
  TextEditingController crmController = TextEditingController();
  TextEditingController registration = TextEditingController();
  TextEditingController document = TextEditingController();
  TextEditingController price = TextEditingController();

  void clearPrice() {
    price.clear();
    update();
  }

  bool iPriceChecked = false;

  void checkPrice(String val) {
    assert(val.isNotEmpty);
    iPriceChecked = val.returnNumber() < 1.00;
    update();
  }

  SpecialistResponseModel? specialist;

  setSpecialist(SpecialistResponseModel val) {
    specialist = val;
    update();
  }

  void setDataToUpdate() {
    name.text = specialist!.doctor!.fullName!.capitalize!;
    email.text = specialist!.doctor!.email!;
    if (specialist!.doctor!.phoneNumber!.isNotEmpty) {
      phone.text = !(specialist!.doctor!.phoneNumber!.length == 10 ||
              specialist!.doctor!.phoneNumber!.length == 11)
          ? specialist!.doctor!.phoneNumber!.substring(2, 12).formatPhone()
          : specialist!.doctor!.phoneNumber!.formatPhone();
    }
    birthDay.text = specialist!.doctor!.birthday?.formatDateFromIso() ?? "";
    gender.text = specialist!.doctor!.gender?.genderRecover() ?? "";
    document.text = specialist!.doctor!.document?.formatDocument() ?? "";
    zipcode.text = specialist!.doctor!.zipcode?.formatCep() ?? "";
    address.text = specialist!.doctor!.address ?? "";
    number.text = specialist!.doctor!.number ?? "";
    neighborhood.text = specialist!.doctor!.neighborhood ?? "";
    complement.text = specialist!.doctor!.complement ?? "";
    city.text = specialist!.doctor!.city ?? "";
    state.text = specialist!.doctor!.state ?? "";
    registration.text = specialist!.doctor!.registrationID ?? "";
    crmController.text = specialist!.doctor!.crmNumber ?? "";
    price.text = specialist!.price?.formatReal() ?? "";
  }

  Future<void> updateSpecialist() async {
    if (price.text.isEmpty) {
      SnackbarCustom.snackbarError('Preço é requerido');
      return;
    }
    try {
      final result = await _repository.updateSpecialist(
          params: CreateSpecialistParams(
        id: null,
        fullName: name.text,
        document: document.text.removeDocumentMask(),
        email: email.text,
        birthday: birthDay.text.formatDateIso(),
        phoneNumber: phone.text,
        zipcode: zipcode.text.replaceFirst('-', ''),
        address: address.text,
        number: number.text,
        complement: complement.text,
        neighborhood: neighborhood.text,
        city: city.text,
        state: state.text,
        ibge: '',
        gender: gender.text.genderFormart(),
        registrationID: registration.text,
        maritalStatus: specialist!.doctor!.maritalStatus,
        crmNumber: crmController.text,
        specialtyId: specialist!.specialtyId!,
        price: price.text.returnNumber(),
      ));

      if (result.data != null) {
        SnackbarCustom.snackbarSucess(result.data!);
      }
      if (result.error != null) {
        SnackbarCustom.snackbarError(result.error!.message!);
      }
    } catch (e) {
      SnackbarCustom.snackbarException(e);
    }
  }

  clear() {
    state.clear();
    city.clear();
    zipcode.clear();
    neighborhood.clear();
    complement.clear();
    number.clear();
    address.clear();
    email.clear();
    phone.clear();
    birthDay.clear();
    gender.clear();
    name.clear();
    crmController.clear();
    registration.clear();
    document.clear();
    price.clear();
  }
}
