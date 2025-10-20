import 'dart:convert';

import 'package:dnn_core/all_exports.dart';
import 'package:dnn_core/core/jsons/json_path.dart';
import 'package:dnn_core/core/jsons/jsons.dart';
import 'package:dnn_helpers/dnn_helpers.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class HelpersController extends GetxController {
  @protected
  final IHelpersRepository _repository;

  HelpersController(this._repository);

  List<HelperModel>? helpers;
  List<HelperModel> finalList = [];

  @override
  void onInit() {
    super.onInit();
    getHelpers();
    UpdateStorageService.updatePeriodicService(
      (timer) => getHelpers(forceUpdate: true),
    );
  }

  Future<void> getHelpersFromJson() async {
    final cacheResponse = await HelperResponse().getData();
    if (cacheResponse == null) {
      String jsonString = await rootBundle.loadString(JsonPath.learnmore);

      Map<String, dynamic> jsonResponse = jsonDecode(jsonString);

      final response = HelperResponse.fromJson(jsonResponse);
      helpers = response.helperModel;
    } else {
      helpers = cacheResponse.helperModel!;
      mapperList(helpers);
      update();
    }
  }

  Future<void> getHelpers({bool? forceUpdate}) async {
    try {
      if (forceUpdate != true) {
        final dataBox = await HelperResponse().getData();
        if (dataBox != null) {
          helpers = dataBox.helperModel!;
        } else {
          final jsonData = HelperResponse.fromJson(
              await JsonCustom.load(path: JsonPath.helpers));

          await dbContext.addData(
            key: DatabaseModels.helperResponse,
            data: jsonData,
            clearCurrentData: true,
          );
          helpers = jsonData.helperModel!;
        }
        mapperList(helpers);
        update();
        return;
      }

      final result = await _repository.getHelpers();

      if (result.data != null) {
        result.data!.updateAt = DateTime.now();
        await dbContext.addData(
          key: DatabaseModels.helperResponse,
          data: result.data!,
          clearCurrentData: true,
        );
        helpers = result.data!.helperModel;
        mapperList(helpers);
        update();
      }
    } catch (e) {
      await getHelpersFromJson();
    }
  }

  toHelperPage({required String tag, String? title}) {
    final result = finalList.firstWhereOrNull((element) => element.tags == tag);

    if (result == null) return;

    if (result.orders == 1) {
      Get.toNamed(
        Routes.helpersList,
        arguments: {
          'tag': result.tags!,
          'childs': result.childs,
          'title': result.title!,
        },
      );
    }

    if (result.orders == 3) {
      Get.toNamed(
        Routes.helpersDetails,
        arguments: {
          'tag': result.tags!,
          'helper': result,
          'title': title ?? result.title!,
        },
      );
    }
  }

  mapperList(List<HelperModel>? list) {
    List<HelperModel> lista = [];
    if (list != null) {
      for (var helper in list) {
        lista.add(helper);

        if (helper.childs != null) {
          mapperList(helper.childs!);
        }
      }
    }
    finalList.addAll(lista);
  }
}
