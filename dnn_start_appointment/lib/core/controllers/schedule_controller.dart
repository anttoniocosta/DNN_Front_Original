import 'dart:convert';

import 'package:dnn_shared/dnn_shared.dart';
import 'package:dnn_start_appointment/core/export.dart';
import 'package:dnn_start_appointment/dnn_start_appointment.dart';
import 'package:dnn_start_appointment/modules/schedule_appointment/export.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ScheduleController extends GetxController {
  final IScheduleRepository _repository;

  ScheduleController({required IScheduleRepository repository})
      : _repository = repository;

  List<ScheduleFilterHourResponse> filterHourList = [];
  List<ScheduleFilterDaysResponse> filterDaysList = [];
  List<ScheduleFilterSpecialtyResponse> specialtyList = [];
  List<ScheduleFilterSpecialtyResponse> specialtyListFiltered = [];
  List<TypeScheduleResponse> typeSchedules = [];
  List<String> cityList = [];
  List<String> cityListFiltered = [];
  String selectedCity = '';

  int? typeScheduleId;
  int? specialtyId;
  bool isReadyService = false;
  String date = '';

  bool get isOnline =>
      typeSchedules
          .firstWhere((x) => x.id == typeScheduleId)
          .name!
          .toLowerCase() ==
      'online';

  ScheduleFilterDaysResponse? scheduleSelected;

  ScheduleFilterHourResponse? scheduleHourSelected;

  setScheduleSelectedDay(ScheduleFilterDaysResponse val) {
    scheduleSelected = val;
    update();
  }

  setFilterDaysList(List<ScheduleFilterDaysResponse> val) {
    filterDaysList = val;
    update();
  }

  setScheduleSelectedHour(ScheduleFilterHourResponse val) {
    scheduleHourSelected = val;
    update();
  }

  setTypeScheduleId(int val) {
    typeScheduleId = val;
    update();
  }

  setCity(String val) {
    selectedCity = val;
    update();
  }

  setSpecialtyId(int val) {
    specialtyId = val;
    update();
  }

  setIsReadyService(bool val) {
    isReadyService = val;
    update();
  }

  setDate(String val) {
    date = val;
    update();
  }

  @override
  onInit() {
    getTypeSchedule();
    super.onInit();
  }

  clear() {
    typeScheduleId = null;
    specialtyId = null;
    isReadyService = false;
    date = '';
    update();
  }

  TextEditingController filterSpecialist = TextEditingController();
  TextEditingController filterCity = TextEditingController();

  void filterSpecialistList(String searchText) {
    specialtyListFiltered = specialtyList
        .where((item) =>
            item.name!.toLowerCase().contains(searchText.toLowerCase()))
        .toList();
    update();
  }

  void filterCityList(String searchText) {
    cityListFiltered = cityList
        .where((item) => item.toLowerCase().contains(searchText.toLowerCase()))
        .toList();
    update();
  }

  int getScheduleTypeId(String text) {
    return typeSchedules.firstWhere((x) => x.name == text).id!;
  }

  String getCardIcon(int id) {
    final name =
        typeSchedules.firstWhere((x) => x.id == id).name!.toLowerCase();
    if (name == 'presencial') {
      return MediaRes.appointmentInPerson;
    } else {
      return MediaRes.appointmentOnline;
    }
  }

  Future<void> getFilterSpecialties() async {
    try {
      final result = await _repository.getFilterSpecialties(
        typeScheduleId: typeScheduleId!,
        isReadyService: isReadyService,
      );

      if (result.data != null) {
        specialtyList = result.data!;
        specialtyListFiltered = specialtyList;
        cityList = specialtyList.map((e) => e.state!).toSet().toList();
        cityList.insert(0, 'Todos');
        cityListFiltered = cityList;
        selectedCity = cityList.first;
        update();
      } else {
        specialtyList.clear();
        specialtyListFiltered.clear();
        cityList.clear();
        cityListFiltered.clear();
        selectedCity = 'Todos';
      }

      if (result.error != null) {}
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  Future<void> getFilterDays() async {
    try {
      final result = await _repository.getFilterDays(
        typeScheduleId: typeScheduleId!,
        specialtyId: specialtyId!,
        isReadyService: isReadyService,
        state: selectedCity == 'Todos' ? 'All' : selectedCity,
      );

      if (result.data != null) {
        filterDaysList = result.data!;
        update();
      }

      if (result.error != null) {
        filterDaysList.clear();
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  Future<void> getFilterHours() async {
    try {
      final result = await _repository.getFilterHours(
        typeScheduleId: typeScheduleId!,
        specialtyId: specialtyId!,
        isReadyService: isReadyService,
        date: date,
        state: selectedCity == 'Todos' ? 'All' : selectedCity,
      );

      if (result.data != null) {
        filterHourList = result.data!;
      }

      if (result.error != null) {
        SnackbarCustom.snackbarError(result.error!.message!);
        filterHourList.clear();
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  Future<void> getTypeSchedule() async {
    try {
      final result = await _repository.getTypeSchedule();
      if (result.data != null) {
        typeSchedules = result.data!;
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  Future<void> schedule() async {
    LoadingDialog.show(Get.context!);
    try {
      final result =
          await _repository.schedule(schedule: await requestModelForSchedule());

      if (result.data != null) {
        final response = result.data!;
        final myAppCtrl = Get.find<MyAppointmentsController>();
        await myAppCtrl.getMyAppointments();
        LoadingDialog.hide(Get.context!);

        final prontoAtendimento = myAppCtrl.myAppointmets.firstWhereOrNull(
          (x) =>
              (x.id! == (response.scheduleConsultationId ?? '')) ||
              (x.id! == (response.screeningId ?? '')),
        );

        if (isReadyService) {
          if (response.openRapidoc == true && response.rapidocUrl != null) {
            Get.toNamed(Routes.serviceCall, arguments: response.rapidocUrl);
          } else if (response.openRapidoc == false &&
              prontoAtendimento != null) {
            myAppCtrl.setAppointment(prontoAtendimento);
            myAppCtrl.clearController();
            myAppCtrl.setController();

            if (response.hasScreening == true) {
              myAppCtrl.setStreammingType(StreammingTypeEnum.triagem);
              Get.offAllNamed(Routes.screenProntuaryClient);
            } else if (response.hasScreening == false &&
                response.scheduleServicesId != null) {
              myAppCtrl.setStreammingType(StreammingTypeEnum.standard);
              Get.offAllNamed(Routes.screenProntuaryClient);
            } else {
              navigationController.setIndex(NavigationTabs.home);
              Get.offAllNamed(Routes.basePage);
              CustomDialogs.simpleDialog(
                title: 'Atenção!',
                context: Get.context!,
                isDismissible: false,
                content: Column(
                  children: [
                    Text(
                      'Não foi possível iniciar a consulta, entre no menu de "Iniciar consulta" e inicie sua consulta a partir da sua última agenda.',
                      style: Fonts.bodyLarge(Get.context!),
                    ),
                    10.heightGap,
                    PrimaryButtonWidget(
                      onTap: () => Get.back(),
                      titleButtom: 'Entendi.',
                    )
                  ],
                ),
              );
            }
          } else {
            navigationController.setIndex(NavigationTabs.home);
            Get.offAllNamed(Routes.basePage);
            CustomDialogs.simpleDialog(
              title: 'Atenção!',
              context: Get.context!,
              isDismissible: false,
              content: Column(
                children: [
                  Text(
                    'Não foi possível iniciar a consulta, entre no menu de "Iniciar consulta" e a partir da sua última agenda com um plantonista, inicie seu atendimento.',
                    style: Fonts.bodyLarge(Get.context!),
                  ),
                  10.heightGap,
                  PrimaryButtonWidget(
                    onTap: () => Get.back(),
                    titleButtom: 'Entendi.',
                  )
                ],
              ),
            );
          }
        } else {
          Get.toNamed(Routes.scheduleConclusion);
        }

        update();
      }
      if (result.error != null) {
        LoadingDialog.hide(Get.context!);
        Get.offNamed(Routes.paymentError, arguments: result.error!.message);
        update();
      }
    } catch (e) {
      LoadingDialog.hide(Get.context!);
      Get.offNamed(Routes.paymentError, arguments: e.toString());
    }
  }

  Future<SchedulePaymentRequestModel> requestModelForSchedule() async {
    int? useTermsId = await storage.getUseTerms();
    bool? isAnotherPatient = await storage.getIsAnotherPatient();
    String? scheduleConsultationId = await storage.getScheduleConsultId();
    AccountRequestModel? model = await storage.getAccountForSchedule();
    PatientModel? patient;
    if (model != null && isAnotherPatient == true) {
      patient = PatientModel.fromProvider(model);
    }

    final modelFinal = SchedulePaymentRequestModel(
      useTermsId: useTermsId,
      scheduleConsultationId: scheduleConsultationId,
      isAnotherPatient: isAnotherPatient!,
      patient: isAnotherPatient ? patient : null,
    );

    debugPrint(jsonEncode(modelFinal.toJson()).toString());
    return modelFinal;
  }

  bool get hasSpecialties => specialtyList.isNotEmpty;

  Future<void> navigateToSpecialty(int specialtyId) async {
    setSpecialtyId(specialtyId);
    LoadingDialog.show(Get.context!);
    await getFilterDays();
    LoadingDialog.hide(Get.context!);
    // PRONTO ATENDIMENTO
    if (isReadyService) {
      LoadingDialog.show(Get.context!);
      await getFilterHours();
      LoadingDialog.hide(Get.context!);
      if (filterHourList.isNotEmpty) {
        Get.toNamed(Routes.scheduleSpecialtyAble);
      }
    } else {
      if (filterDaysList.isNotEmpty) {
        Get.toNamed(Routes.scheduleSpecialtyFilter);
      } else {
        SnackbarCustom.snackbarError(
          'Não há agenda para esta especialidade no momento',
        );
      }
    }
  }
}
