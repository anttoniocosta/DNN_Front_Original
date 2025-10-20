import 'dart:typed_data';

import 'package:cross_file/cross_file.dart';
import 'package:dnn_core/all_exports.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class UpdateAccountController extends GetxController {
  final IAccountRepository _repository;

  UpdateAccountController(this._repository);

  // @override
  // onInit() async {
  //   setDataToUpdate();
  //   super.onInit();
  // }

  @override
  onClose() async {
    super.onClose();
    clear();
  }

  clear() {
    name.clear();
    email.clear();
    phone.clear();
    birthDay.clear();
    gender.clear();
    document.clear();
    zipcode.clear();
    address.clear();
    number.clear();
    neighborhood.clear();
    complement.clear();
    city.clear();
    state.clear();
    pixKey.clear();
    stateSubscription.clear();
  }

  final name = TextEditingController();
  final email = TextEditingController();
  final phone = TextEditingController();
  final birthDay = TextEditingController();
  final gender = TextEditingController();
  final document = TextEditingController();
  final registrationID = TextEditingController();
  final maritalStatus = TextEditingController();
  final zipcode = TextEditingController();
  final address = TextEditingController();
  final number = TextEditingController();
  final neighborhood = TextEditingController();
  final complement = TextEditingController();
  final city = TextEditingController();
  final state = TextEditingController();
  final pixKey = TextEditingController();
  final stateSubscription = TextEditingController();

  UpdateUserInfosRequest setUpdateUserInfo(String id) {
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
      zipcode: zipcode.text.replaceFirst('-', ''),
      address: address.text,
      city: city.text,
      state: state.text,
      number: number.text,
      complement: complement.text,
      neighborhood: neighborhood.text,
      ibge: '',
      registrationID: registrationID.text,
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
    zipcode.text = user!.zipcode?.formatCep() ?? "";
    address.text = user!.address ?? "";
    number.text = user!.number ?? "";
    neighborhood.text = user!.neighborhood ?? "";
    complement.text = user!.complement ?? "";
    city.text = user!.city ?? "";
    state.text = user!.state ?? "";
    pixKey.text = user!.pixKey ?? "";
    registrationID.text = user!.registrationID ?? "";
    maritalStatus.text =
        MaritalStatusModel.getMaritalText(user!.maritalStatus!);
  }

  UserAccountInfoModel? get user => accountController.userAccount;
  String? get userToken => accountController.userToken;

  RxBool isLoading = false.obs;

  setIsLoading(bool val) {
    isLoading.value = val;
    update();
  }

  /*
  * Chama a API de PUT nos dados do usuário.
  */
  Future<void> updateAccount({bool? updatingFromProvider = false}) async {
    setIsLoading(true);
    try {
      final result = await _repository.updateUserData(
        account: updatingFromProvider!
            ? providersController.setUpdateUserInfoForProvider(user!.id!)
            : setUpdateUserInfo(user!.id!),
      );

      if (result.data != null) {
        await accountController.getAccount();
        navigationController.setIndex(NavigationTabs.home);
        wsServices.start();
        Get.offAllNamed(Routes.basePage);
        SnackbarCustom.snackbarSucess('Dados alterados com sucesso!');
      } else {
        SnackbarCustom.snackbarError(result.error!.message!);
      }
    } catch (e) {
      SnackbarCustom.snackbarException(e);
    }
    setIsLoading(false);
  }

  /*
  * Chama a API para a troca da foto do usuário.
  */

  Future<void> uploadPhoto(XFile? pickedImage) async {
    try {
      await makePostRequestPhoto(pickedImage);
    } catch (e) {
      SnackbarCustom.snackbarException(e);
    }
  }

  Future makePostRequestPhoto(XFile? pickedImage) async {
    String url = '${dnnController.apiUrl}/api/Account/photo';
    var headers = {
      'Authorization': 'Bearer $userToken',
      'Content-type': 'application/json',
      'api-key': 'RG5uQXBpOiNEbm5BcGlAMjAyMw==',
      'Accept-Encoding': 'gzip, deflate, br',
    };
    var request = http.MultipartRequest('POST', Uri.parse(url));
    request.headers.addAll(headers);
    Uint8List data = await pickedImage!.readAsBytes();
    List<int> list = data.cast();
    request.files.add(http.MultipartFile.fromBytes('photo', list,
        filename: pickedImage.name));

    var response = await request.send();

    response.stream.bytesToString().asStream().listen((event) {
      if (response.statusCode.isStatusOk()) {
        SnackbarCustom.snackbarSucess('Foto alterada com sucesso.');
        accountController.getAccount();
      }
    });
  }
}
