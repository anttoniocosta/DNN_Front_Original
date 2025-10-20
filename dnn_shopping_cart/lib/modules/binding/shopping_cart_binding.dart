import 'package:dnn_dependencies/get_export.dart';
import 'package:dnn_shopping_cart/modules/export.dart';

class ShoppingCartBinding implements Bindings {
  @override
  void dependencies() {
    Get.put<IShoppingCartRepository>(ShoppingCartRepository(Get.find()));
    Get.put<ShoppingCartController>(ShoppingCartController(Get.find()),
        permanent: true);
  }
}
