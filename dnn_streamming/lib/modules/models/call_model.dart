import 'package:agora_rtc_engine/agora_rtc_engine.dart';

enum ClientTypeEnum { patient, doctor, triagem }

class CallModel {
  String? channelName;
  ClientRoleType? role;
  String? tokenId;

  CallModel({
    this.channelName,
    this.role,
    this.tokenId,
  });
}
