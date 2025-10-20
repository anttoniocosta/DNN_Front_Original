import 'dart:convert';

import 'package:flutter/services.dart';

class JsonCustom {
  static Future<Map<String, dynamic>> load({required String path}) async {
    String jsonString = await rootBundle.loadString(path);
    Map<String, dynamic> jsonResponse = jsonDecode(jsonString);
    return jsonResponse;
  }

  static Future<List<Map<String, dynamic>>> loadList({
    required String path,
  }) async {
    String jsonString = await rootBundle.loadString(path);
    var jsonResponse = jsonDecode(jsonString);
    if (jsonResponse is List) {
      return jsonResponse.map<Map<String, dynamic>>((item) {
        return item as Map<String, dynamic>;
      }).toList();
    } else {
      throw FormatException('O JSON não é uma lista');
    }
  }
}
