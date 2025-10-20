import 'dart:convert';

import 'package:dnn_core/all_exports.dart';
import 'package:dnn_core/core/jsons/json_path.dart';
import 'package:dnn_core/core/jsons/jsons.dart';
import 'package:dnn_pages/modules/pages/export.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class PagesController extends GetxController {
  final IPagesRepository _repository;
  PagesController(this._repository);

  List<PagesModel>? pages;

  PagesModel? currentPage(String pageEnum) {
    try {
      final result =
          pages!.firstWhereOrNull((element) => element.tag == pageEnum);
      if (result == null) {
        return PagesModel(
            content: '<p>Subtitle<p>', name: pageEnum, tag: 'empty', id: 0);
      }
      return result;
    } catch (e) {
      return PagesModel(
          content: '<p>Subtitle<p>', name: 'Title', tag: 'empty', id: 0);
    }
  }

  @override
  void onInit() {
    super.onInit();
    getPages();
    UpdateStorageService.updatePeriodicService(
      (timer) => getPages(forceUpdate: true),
    );
  }

  Future<void> getPages({bool? forceUpdate}) async {
    try {
      pages = [];
      if (forceUpdate != true) {
        final dataBox = await PagesResponse().getData();
        if (dataBox != null) {
          pages = dataBox.data;
        } else {
          final jsonData = PagesResponse.fromJson(
              await JsonCustom.load(path: JsonPath.pages));

          await dbContext.addData(
            key: DatabaseModels.pagesResponse,
            data: jsonData,
            clearCurrentData: true,
          );
          pages = jsonData.data;
        }
        return;
      }

      final cacheResponse = await PagesResponse().getData();
      if (cacheResponse != null) {
        if (cacheResponse.updateAt != null) {
          final durationDifference =
              DateTime.now().difference(cacheResponse.updateAt!);

          if (durationDifference <= const Duration(hours: 1)) {
            pages = cacheResponse.data!;
            return;
          }
        }
      }
      final result = await _repository.getPages();
      if (result.data != null) {
        pages = result.data!.data!;
        result.data!.updateAt = DateTime.now();
        await dbContext.addData(
          key: DatabaseModels.pagesResponse,
          data: result.data!,
          clearCurrentData: true,
        );
        update();
      }
    } catch (e) {
      await getPagesFromJson();
    }
  }

  Future<void> getPagesFromJson() async {
    final cacheResponse = await PagesResponse().getData();
    if (cacheResponse == null) {
      String jsonString = await rootBundle.loadString(JsonPath.pages);

      Map<String, dynamic> jsonResponse = jsonDecode(jsonString);

      final response = PagesResponse.fromJson(jsonResponse);
      await dbContext.addData(
        key: DatabaseModels.pagesResponse,
        data: response,
        clearCurrentData: true,
      );
      pages = response.data!;
    } else {
      pages = cacheResponse.data!;
    }
  }
}
