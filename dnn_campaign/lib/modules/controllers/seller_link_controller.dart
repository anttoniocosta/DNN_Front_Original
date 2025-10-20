import 'package:dnn_campaign/dnn_campaign.dart';
import 'package:dnn_core/all_exports.dart';
import 'package:dnn_dependencies/get_export.dart';

class SellerLinkController extends GetxController {
  final ICampaignRepository _repository;

  SellerLinkController(this._repository);

  RxBool isLoading = false.obs;

  @override
  onInit() {
    getSellerLinks();
    Get.toNamed(Routes.sellerLinks);
    super.onInit();
  }

  setLoading(RxBool loading, bool status) {
    loading.value = status;
    update();
  }

  List<SellerLinkModel> sellerLinks = [];

  Future<void> getSellerLinks() async {
    setLoading(isLoading, true);
    try {
      final result = await _repository.getSellerLinks();

      if (result.data != null) {
        sellerLinks = result.data!;
      }
      update();
    } catch (e) {}
    update();
    setLoading(isLoading, false);
  }
}
