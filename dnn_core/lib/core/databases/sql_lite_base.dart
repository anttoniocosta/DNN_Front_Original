import 'dart:convert';

import 'package:dnn_core/dnn_core.dart';

abstract class SqfLiteBase<T> {
  late String keyModel;
  SqfLiteBase(this.keyModel);

  Future<void> save() async {
    await dbContext.addData(key: keyModel, data: this);
  }

  Future<void> saveByKey({required String key, bool? clearCurrentData}) async {
    await dbContext.addData(
        key: key, data: this, clearCurrentData: clearCurrentData);
  }

  Future<T?> get(T Function(Map<String, dynamic>) fromJson) async {
    var list = await getAll<T>(fromJson);
    return list.first;
  }

  // ignore: avoid_shadowing_type_parameters
  Future<List<T>> getAll<T>(T Function(Map<String, dynamic>) fromJson,
      {String? key}) async {
    var resultList = await dbContext.readAllByKey(
      key: key ?? keyModel,
    );
    return resultList
        .map((e) {
          final decodedData = jsonDecode(e['VALUE']);
          if (decodedData is List) {
            return decodedData
                .map((item) => fromJson(item[0] as Map<String, dynamic>))
                .toList() as T;
          }
          return fromJson(decodedData as Map<String, dynamic>);
        })
        .where((e) => e != null)
        .cast<T>()
        .toList();
  }

  Future<List<T>> getAllByKey<T>(
      String key, T Function(Map<String, dynamic>) fromJson) async {
    var resultList = await dbContext.readAllByKey(key: key);
    return resultList
        .map((e) {
          final decodedData = jsonDecode(e['VALUE']);
          if (decodedData is List) {
            return decodedData
                .map((item) => fromJson(item[0] as Map<String, dynamic>))
                .toList() as T;
          }
          return fromJson(decodedData as Map<String, dynamic>);
        })
        .where((e) => e != null)
        .cast<T>()
        .toList();
  }
  // Mais métodos podem ser adicionados aqui, como delete, getByWhere, etc.
}
