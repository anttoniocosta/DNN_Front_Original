import 'package:dnn_core/all_exports.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProvidersController extends GetxController {
  final IProvidersRepository _repository;

  ProvidersController(this._repository);

  clear() {
    document.clear();
    name.clear();
    gender.clear();
    birthDay.clear();
    phone.clear();
    email.clear();
    zipCode.clear();
    address.clear();
    city.clear();
    state.clear();
    number.clear();
    neighborhood.clear();
    complement.clear();
    registration.clear();
    maritalStatus.clear();
    pixKey.clear();
  }

  clearAddress() {
    zipCode.clear();
    address.clear();
    city.clear();
    state.clear();
    number.clear();
    neighborhood.clear();
    complement.clear();
  }

  UserAccountInfoModel? get user => accountController.userAccount;

  UpdateUserInfosRequest setUpdateUserInfoForProvider(String id) {
    final marital = accountController.maritalStatusList
        .where((x) => x.text?.toUpperCase() == maritalStatus.text.toUpperCase())
        .first;

    return UpdateUserInfosRequest(
      id: id,
      document: document.text.removeDocumentMask(),
      birthday: birthDay.text.formatDateIso(),
      gender: gender.text.genderFormart(),
      email: email.text,
      phoneNumber: phone.text,
      fullName: name.text,
      pixKey: pixKey.text,
      zipcode: zipCode.text.replaceFirst('-', ''),
      address: address.text,
      city: city.text,
      state: state.text,
      number: number.text,
      complement: complement.text,
      neighborhood: neighborhood.text,
      ibge: '',
      registrationID: registration.text,
      maritalStatus: marital.id,
    );
  }

  void setDataToUpdate() {
    name.text = user!.fullName!.capitalize!;
    email.text = user!.email!;
    if (user!.phoneNumber!.isNotEmpty)
      phone.text =
          !(user!.phoneNumber!.length == 10 || user!.phoneNumber!.length == 11)
              ? user!.phoneNumber!.substring(2, 12).formatPhone()
              : user!.phoneNumber!.formatPhone();
    birthDay.text = user!.birthday?.formatDateFromIso() ?? "";
    gender.text = user!.gender?.genderRecover() ?? "";
    document.text = user!.document?.formatDocument() ?? "";
    zipCode.text = user!.zipcode?.formatCep() ?? "";
    address.text = user!.address ?? "";
    number.text = user!.number ?? "";
    neighborhood.text = user!.neighborhood ?? "";
    complement.text = user!.complement ?? "";
    city.text = user!.city ?? "";
    state.text = user!.state ?? "";
    pixKey.text = user!.pixKey ?? "";
    registration.text = user!.registrationID ?? "";
    //stateSubscription.text = user!.registrationID ?? "";
  }

  final document = TextEditingController();
  final pixKey = TextEditingController();
  final name = TextEditingController();
  final stateSubscription = TextEditingController();
  final gender = TextEditingController();
  final birthDay = TextEditingController();
  final phone = TextEditingController();
  final email = TextEditingController();
  final zipCode = TextEditingController();
  final address = TextEditingController();
  final city = TextEditingController();
  final state = TextEditingController();
  final number = TextEditingController();
  final neighborhood = TextEditingController();
  final complement = TextEditingController();
  final registration = TextEditingController();
  final maritalStatus = TextEditingController();

  setAddress(AddressByZipcodeResponse model) {
    address.text = model.logradouro!.trim();
    city.text = model.localidade!.trim();
    state.text = model.uf!.trim();
    complement.text = model.complemento!.trim();
    neighborhood.text = model.bairro!.trim();
  }

  AccountRequestModel setAccount({String? firebaseToken, bool? isCompany}) {
    final acount = AccountRequestModel();
    final addressModel = AddressModel();
    acount.contractId = null;
    acount.document = document.text.removeDocumentMask();
    acount.name = name.text;
    acount.birthday = birthDay.text.formatDateIso();
    acount.email = email.text;
    acount.phoneNumber = phone.text;
    acount.firebaseToken = firebaseToken ?? '';
    acount.gender = gender.text.genderFormart();
    if (isCompany == null || isCompany == false) {
      acount.registrationID = registration.text.removeRgMask();
      acount.maritalStatus =
          MaritalStatusModel.getMaritalId(maritalStatus.text);
    }
    addressModel.zipcode = zipCode.text.replaceFirst('-', '');
    addressModel.street = address.text;
    addressModel.city = city.text;
    addressModel.state = state.text;
    addressModel.number = number.text;
    addressModel.complement = complement.text;
    addressModel.neighborhood = neighborhood.text;
    addressModel.ibge = '';
    acount.address = addressModel;
    return acount;
  }

  double installmentTotal(String currency, int installment) {
    return (double.parse(currency.replaceAll(',', '.')) * installment);
  }

  RxBool isLoading = false.obs;
  RxBool isLoadingRapidoc = false.obs;

  AccountByDocumentResponse? account;
  AddressByZipcodeResponse? adress;
  List<InstallmentsResponse>? installments;
  InstallmentsResponse? choicedInstallment;

  String urlCallRapidoc = '';

  Future<void> getUserAddressByCep(String cep) async {
    isLoading.value = true;
    update();
    try {
      final result = await _repository.getUserAddressByCep(cep: cep);

      if (result.data != null) {
        adress = result.data!;
        setAddress(result.data!);
        update();
      } else {
        // TODO: CRIAR ENUM PARA TRATATIVA DE ERROS
        SnackbarCustom.snackbarError(
            "Não foi possível encontrar seu endereço. Por favor, tente outro CEP.");
      }
    } catch (e) {
      // TODO: CRIAR ENUM PARA TRATATIVA DE ERROS
      SnackbarCustom.snackbarException(
          "CEP inválido. Por favor, insira um CEP válido.");
    }
    isLoading.value = false;
    update();
  }

  bool isCpfNotEqualToLoggedUser(String cpf) {
    if (user == null) return true;
    return user!.document != cpf.removeDocumentMask();
  }

  Future<void> getPersonInfosByDocument(String document) async {
    isLoading.value = true;
    update();
    try {
      final result = await _repository.getPersonInfosByDocument(
          document: document.removeDocumentMask());

      if (result.data != null) {
        setPersonInfos(result.data!);
        update();
      } else {
        // TODO: CRIAR ENUM PARA TRATATIVA DE ERROS
        SnackbarCustom.snackbarError(
          "O CPF não foi encontrado. Por favor, realize o cadastro das informações do novo CPF.",
        );
      }
    } catch (e) {
      // TODO: CRIAR ENUM PARA TRATATIVA DE ERROS
      SnackbarCustom.snackbarException("Ocorreu um erro na busca pelo CPF.");
    }
    isLoading.value = false;
    update();
  }

  // Future<void> getUrlCall(String contractId) async {
  //   isLoadingRapidoc.value = true;
  //   update();
  //   try {
  //     final result = await _repository.getCallUrl(
  //       contractId: contractId,
  //       personId: accountController.personId,
  //     );

  //     if (result.data != null) {
  //       urlCallRapidoc = result.data!.data!.url!;
  //       if (Get.currentRoute == Routes.paymentFinish)
  //         Get.offAllNamed(Routes.serviceCall);
  //     } else {
  //       SnackbarCustom.snackbarError(result.error!.message!);
  //     }
  //   } catch (e) {
  //     SnackbarCustom.snackbarException(e);
  //   }
  //   isLoadingRapidoc.value = false;
  //   update();
  // }

  Future<void> getGnInstallments(String brand, double total) async {
    try {
      final result = await _repository.getGnInstallments(
        brand: brand,
        total: total,
      );

      if (result.data != null) {
        installments = result.data;
        if (installments!.isNotEmpty)
          Get.toNamed(Routes.creditInstallmentsPage);
      } else {
        SnackbarCustom.snackbarError(result.error!.message!);
      }
    } catch (e) {
      SnackbarCustom.snackbarException(e);
    }
  }

  choicedInstallments(InstallmentsResponse installment) {
    this.choicedInstallment = installment;
    update();
  }

  setPersonInfos(AccountByDocumentResponse model) {
    if (model.providerModel == null || model.providerModel!.name == null) {
      SnackbarCustom.snackbarError('Dados não encontrados');
      return;
    }

    final person = model.providerModel!;
    name.text = setIfIsNotEmpty(name, person.name!.capitalize!);
    gender.text = person.gender != null ? person.gender!.genderRecover() : '';
    birthDay.text =
        setIfIsNotEmpty(birthDay, person.birthDate!.formatDateFromIso());
    if (person.maritalStatus != null) {
      maritalStatus.text = setIfIsNotEmpty(
        maritalStatus,
        MaritalStatusModel.getMaritalText(person.maritalStatus!),
      );
    }
    if (person.registrationID != null) {
      registration.text = setIfIsNotEmpty(
          registration, person.registrationID!.replaceAll('-', ''));
      ;
    }
    if (person.hasAddresses!) {
      final location = person.addresses!.first;
      address.text = setIfIsNotEmpty(
        address,
        location.addresses!.capitalizeFirst!,
      );
      zipCode.text = setIfIsNotEmpty(
          zipCode, location.zipCode!.replaceAll('-', '').formatCep());
      number.text = setIfIsNotEmpty(number, location.number!.capitalizeFirst!);
      complement.text = setIfIsNotEmpty(
          complement, location.complement?.capitalizeFirst ?? '');
      neighborhood.text =
          setIfIsNotEmpty(neighborhood, location.neighborhood!.capitalize!);
      city.text = setIfIsNotEmpty(city, location.city!.capitalize!);
      state.text = setIfIsNotEmpty(state, location.state!);
    }
    if (person.hasEmail!) {
      email.text = setIfIsNotEmpty(email, person.emails!.first);
    }
    if (person.hasPhone!) {
      phone.text = setIfIsNotEmpty(
        phone,
        person.phoneNumbers!.first.formatPhone(),
      );
    }
  }

  String setIfIsNotEmpty(TextEditingController controller, String second) {
    return controller.text.isNotEmpty ? controller.text : second;
  }
}
