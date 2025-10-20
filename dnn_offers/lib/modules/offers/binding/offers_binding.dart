import 'package:dnn_offers/dnn_offers.dart';
import 'package:get/get.dart';

class OffersBinding implements Bindings {
  @override
  void dependencies() {
    Get.put<IOffersRepository>(OffersRepository(Get.find()), permanent: true);
    Get.lazyPut<OffersController>(() => OffersController(Get.find()),
        fenix: true);
  }
}
