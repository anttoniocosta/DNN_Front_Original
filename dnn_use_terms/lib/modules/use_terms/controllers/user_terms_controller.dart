import 'dart:convert';

import 'package:dnn_core/core/databases/database_models.dart';
import 'package:dnn_core/core/jsons/json_path.dart';
import 'package:dnn_core/core/jsons/jsons.dart';
import 'package:dnn_core/core/services/cache/update_storage_service.dart';
import 'package:dnn_core/dnn_core.dart';
import 'package:dnn_dependencies/get_export.dart';
import 'package:flutter/services.dart';

import '../export.dart';

class UseTermsController extends GetxController {
  final IUseTermsRepository _repository;
  UseTermsController(this._repository);

  UseTermsModel? useTermsModel;
  UseTermsModel? payTerms;
  List<UseTermsModel> terms = [];
  bool isDrawer = false;

  RxBool isLoading = false.obs;

  setLoading(bool val) {
    isLoading.value = val;
    update();
  }

  @override
  void onInit() {
    getUseTerms(forceUpdate: true);
    UpdateStorageService.updatePeriodicService(
      (timer) => getUseTerms(forceUpdate: true),
    );
    super.onInit();
  }

  Future<void> getUseTermsFromJson() async {
    final cacheResponse = await UseTermsResponse().getData();
    if (cacheResponse == null) {
      String jsonString = await rootBundle.loadString(JsonPath.useterms);

      Map<String, dynamic> jsonResponse = jsonDecode(jsonString);

      final response = UseTermsResponse.fromJson(jsonResponse);
      terms = response.data!;
      update();
      setTermContent();
    } else {
      terms = cacheResponse.data!;
      setTermContent();
      update();
    }
  }

  Future<void> getUseTerms({bool? forceUpdate}) async {
    setLoading(true);
    try {
      if (forceUpdate != true) {
        final dataBox = await UseTermsResponse().getData();
        if (dataBox != null) {
          terms = dataBox.data!;
        } else {
          final jsonData = UseTermsResponse.fromJson(
              await JsonCustom.load(path: JsonPath.useterms));

          await dbContext.addData(
            key: DatabaseModels.useTermsResponse,
            data: jsonData,
            clearCurrentData: true,
          );
          terms = jsonData.data!;
        }
        setTermContent();
        setPayTerms();
        setLoading(false);
        return;
      }

      final result = await _repository.getUseTerms();
      if (result.data != null) {
        result.data!.updateAt = DateTime.now();
        await dbContext.addData(
          key: DatabaseModels.useTermsResponse,
          data: result.data!,
          clearCurrentData: true,
        );
        terms = result.data!.data!;
        setTermContent();
        setPayTerms();
      } else {
        await getUseTermsFromJson();
      }
    } catch (e) {
      await getUseTermsFromJson();
    }
    setLoading(false);
  }

  setTermContent() {
    setUseTerms(UseTermsEnum.CLIENT);
    update();
  }

  setTermIsDrawer(bool value) {
    isDrawer = value;
    update();
  }

  setUseTerms(int termId) {
    useTermsModel = terms.firstWhere((x) => x.type!.id == termId);
  }

  setPayTerms() {
    payTerms = terms.firstWhere((x) => x.type!.id == UseTermsEnum.PAY);
  }
}
