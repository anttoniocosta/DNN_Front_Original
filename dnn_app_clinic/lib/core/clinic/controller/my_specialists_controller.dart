import 'package:dnn_app_clinic/core/clinic/repository/clinic_repository.dart';
import 'package:dnn_shared/dnn_shared.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class MySpecialistsController extends GetxController {
  late final IClinicRepository _repository;

  MySpecialistsController({required IClinicRepository repository})
      : _repository = repository;

  setIsLoading(RxBool loading, bool state) {
    loading.value = state;
    update();
  }

  @override
  void onInit() {
    getMySpecialists();
    getSpecialties();
    super.onInit();
  }

  RxBool isLoadingCreate = false.obs;
  RxBool isLoadingSpecialists = false.obs;
  RxBool isLoadingSpecialty = false.obs;

  List<SpecialistResponseModel> specialistList = [];
  List<SpecialistResponseModel> specialistFilteredList = [];
  List<SpecialistResponseModel> plantonistFilteredList = [];
  List<SpecialtyResponseModel> specialtyList = [];
  List<SpecialtyResponseModel> specialtyFilteredList = [];

  SpecialtyResponseModel? selectedSpecialty;

  setSpecialtySelected(SpecialtyResponseModel? value) {
    selectedSpecialty = value;
    update();
  }

  void filterSpecialtyList(String searchText) {
    specialtyFilteredList = specialtyList
        .where((item) =>
            item.name!.toLowerCase().contains(searchText.toLowerCase()))
        .toList();
    update();
  }

  void filterSpecialistList(String searchText) {
    specialistFilteredList = specialistList
        .where((item) => item.doctor!.fullName!.toLowerCase().contains(
              searchText.toLowerCase(),
            ))
        .toList();
    update();
  }

  TextEditingController filterSpecialist = TextEditingController();
  TextEditingController filterSpecialty = TextEditingController();
  TextEditingController priceController = TextEditingController();
  TextEditingController crmController = TextEditingController();

  bool iPriceChecked = false;

  void checkPrice(String val) {
    assert(val.isNotEmpty);
    iPriceChecked = returnNumber(val) < 1.00;
    update();
  }

  double returnNumber(String val) {
    return double.parse(
      val.replaceFirst('R\$', '').replaceAll('.', '').replaceAll(',', '.'),
    );
  }

  CreateSpecialistParams? specialistCreateModel;

  setSpecialistCreateModel({
    required AccountRequestModel model,
    required double price,
    required int specialtyId,
    required String crmNumber,
  }) {
    specialistCreateModel = CreateSpecialistParams.adapterForRegister(
      model: model,
      price: price,
      specialtyId: specialtyId,
      crmNumber: crmNumber,
    );
    update();
  }

  void clearRegistration() {
    providersController.clear();
    crmController.clear();
    priceController.clear();
    selectedSpecialty = null;
  }

  Future<void> createSpecialist(CreateSpecialistParams params) async {
    setIsLoading(isLoadingCreate, true);
    try {
      final result =
          await _repository.createSpecialist(params: specialistCreateModel!);

      if (result.data != null) {
        Get.toNamed(Routes.addSpecialistConclusion);
      }
      if (result.error != null) {
        SnackbarCustom.snackbarError(result.error!.message!);
      }
    } catch (e) {
      SnackbarCustom.snackbarException(e);
    }
    setIsLoading(isLoadingCreate, false);
  }

  Future<void> getMySpecialists() async {
    if (!(await storage.hasToken())) {
      return;
    }

    setIsLoading(isLoadingSpecialists, true);
    try {
      final result = await _repository.getMySpecialists();

      if (result.data != null) {
        specialistList = result.data!;
        specialistFilteredList = specialistList
            .where((item) =>
                !item.doctor!.fullName!.toLowerCase().contains('plantonista'))
            .toList();
        plantonistFilteredList = specialistList
            .where((item) =>
                item.doctor!.fullName!.toLowerCase().contains('plantonista'))
            .toList();
        update();
      }
      if (result.error != null) {
        SnackbarCustom.snackbarError(result.error!.message!);
      }
    } catch (e) {
      SnackbarCustom.snackbarException(e);
    }
    setIsLoading(isLoadingSpecialists, false);
  }

  Future<void> getSpecialties() async {
    setIsLoading(isLoadingSpecialty, true);
    try {
      final result = await _repository.getSpecialties();

      if (result.data != null) {
        specialtyList = result.data!;
        specialtyFilteredList = specialtyList;

        update();
      }
      if (result.error != null) {
        SnackbarCustom.snackbarError(result.error!.message!);
      }
    } catch (e) {
      SnackbarCustom.snackbarException(e);
    }
    setIsLoading(isLoadingSpecialty, false);
  }
}
