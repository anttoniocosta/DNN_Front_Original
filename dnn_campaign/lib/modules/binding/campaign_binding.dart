import 'package:dnn_campaign/dnn_campaign.dart';
import 'package:dnn_dependencies/get_export.dart';

class CampaignBinding implements Bindings {
  @override
  void dependencies() {
    Get.put<ICampaignRepository>(CampaignRepository(Get.find()),
        permanent: true);
    Get.put<CampaignController>(CampaignController(repository: Get.find()),
        permanent: true);
  }
}
