import 'package:dnn_dependencies/get_export.dart';
import 'package:dnn_payment/modules/card/export.dart';

class CardBinding implements Bindings {
  @override
  void dependencies() {
    Get.put<ICardRepository>(CardRepository(Get.find()), permanent: true);
    Get.put<CardController>(CardController(Get.find()), permanent: true);
  }
}
