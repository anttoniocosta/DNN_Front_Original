import 'dart:io';

import 'package:cross_file/cross_file.dart';
import 'package:dnn_dependencies/dnn_dependencies.dart';
import 'package:http_parser/http_parser.dart';

class UtilsFunctions {
  static Future<MultipartFile> getFile(XFile? pickedImage) async {
    var file = File(pickedImage!.path);
    final fileName = file.path.split('/').last;
    final type = fileName.split('.').last;

    final fileBytes = await file.readAsBytes();
    return MultipartFile.fromBytes(
      fileBytes,
      filename: fileName,
      contentType: MediaType('image', type),
    );
  }
}
