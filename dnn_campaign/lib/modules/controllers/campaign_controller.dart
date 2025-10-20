import 'dart:developer';

import 'package:dnn_campaign/dnn_campaign.dart';
import 'package:dnn_core/all_exports.dart';
import 'package:dnn_dependencies/get_export.dart';
import 'package:flutter/foundation.dart';

class CampaignController extends GetxController {
  final ICampaignRepository _repository;

  CampaignController({
    required ICampaignRepository repository,
  }) : _repository = repository;

  RxBool getCampaignLoading = false.obs;
  RxBool getComplementsLoading = false.obs;

  setLoading(RxBool loading, bool status) {
    loading.value = status;
    update();
  }

  @override
  onInit() async {
    if (campaigns.isEmpty) await getCampaignsV3();
    super.onInit();
  }

  void clearChoicedPlans() {
    complementsId = [];
    planId = '';
  }

  List<String> complementsId = [];
  String planId = '';

  List<CampaignProductModel> campaigns = [];
  List<CampaignProductModel> complements = [];
  List<GatewayDataModel> gateways = [];
  String? campaignError;

  Future<void> getCampaigns() async {
    setLoading(getCampaignLoading, true);
    try {
      final result = await _repository.getCampaigns();

      if (result.data != null) {
        campaigns = result.data!;
      } else {
        campaignError = result.error!.message!;
      }
      update();
    } catch (e) {
      campaignError = e.toString();
    }
    update();
    setLoading(getCampaignLoading, false);
  }

  Future<void> getCampaignsV3() async {
    setLoading(getCampaignLoading, true);
    try {
      final result = await _repository.getCampaignsV3();

      if (result.data != null) {
        campaigns = result.data!;
      } else {
        campaignError = result.error!.message!;
      }
      update();
    } catch (e) {
      campaignError = e.toString();
    }
    update();
    setLoading(getCampaignLoading, false);
  }

  Future<void> getComplementsV3({required String id}) async {
    setLoading(getComplementsLoading, true);
    try {
      final result = await _repository.getComplementsV3(id: id);

      if (result.data != null) {
        complements = result.data!;
      } else {
        log(result.error!.message!);
      }
      update();
    } catch (e) {
      log(e.toString());
    }
    update();
    setLoading(getComplementsLoading, false);
  }

  // void setGateways(List<GatewayDataModel> gt) {
  //   gateways = gt;
  //   update();
  // }

  addComplementToList(bool val, String id) {
    if (!val) {
      complementsId.removeWhere((e) => e == id);
    } else {
      complementsId.addIf(!complementsId.contains(id), id);
    }
    debugPrint(complementsId.toString());
    update();
  }
}
