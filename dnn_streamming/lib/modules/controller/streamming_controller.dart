import 'dart:developer';

import 'package:agora_rtc_engine/agora_rtc_engine.dart';
import 'package:agora_token_service/agora_token_service.dart';
import 'package:agora_uikit/agora_uikit.dart';
import 'package:dnn_dependencies/get_export.dart';
import 'package:dnn_streamming/modules/models/call_model.dart';

class StreammingController extends GetxController {
  final String appId = 'faa070c34cac41aab313ff015b118cfa';
  String agoraToken = '';
  CallModel? client;
  AgoraClient? agoraClient;

  List<int> remoteUids = <int>[];
  List<String> infosSetting = <String>[];
  RtcEngine? engine;
  bool localUserJoined = false;
  bool isTokenExpiring = false;
  bool isUserRemoteOut = false;

  void setClient({
    required String channelName,
    required ClientTypeEnum clientType,
    required String tokenId,
  }) {
    client = CallModel(
      channelName: channelName,
      role: ClientRoleType.clientRoleBroadcaster,
      tokenId: agoraToken,
    );
    update();
  }

  void setAgoraClient() {
    agoraClient = AgoraClient(
      agoraConnectionData: AgoraConnectionData(
        appId: appId,
        channelName: client!.channelName!,
        username: "user",
      ),
    );
    update();
  }

  Future<void> initEngine() async {
    await [Permission.microphone, Permission.camera].request();
    engine = createAgoraRtcEngine();
    await engine!.initialize(
      RtcEngineContext(
        appId: appId,
        channelProfile: ChannelProfileType.channelProfileLiveBroadcasting,
      ),
    );

    engine!.registerEventHandler(
      RtcEngineEventHandler(
        onError: (err, msg) {
          infosSetting.add('Tipo:$err  Msg: $msg');
          update();
        },
        onJoinChannelSuccess: (RtcConnection connection, int elapsed) {
          log("local user ${connection.localUid} joined");
          localUserJoined = true;
          infosSetting.add('Join:${connection.localUid}  Msg: $elapsed');
          update();
        },
        onUserJoined: (RtcConnection connection, int rUid, int elapsed) {
          log("remote user $rUid joined");
          remoteUids.add(rUid);
          isUserRemoteOut = false;
          infosSetting.add("remote user $rUid joined");
          update();
        },
        onUserOffline:
            (RtcConnection connection, int rUid, UserOfflineReasonType reason) {
          log("remote user $rUid left channel");
          remoteUids.removeWhere((id) => id == rUid);
          infosSetting.add("remote user $rUid  left channel");
          update();
        },
        onLeaveChannel: (RtcConnection connection, RtcStats stats) {
          log('[onLeaveChannel] connection: ${connection.toJson()} stats: ${stats.toJson()}');
          remoteUids.clear();
          isUserRemoteOut = true;
          update();
        },
        onTokenPrivilegeWillExpire: (RtcConnection connection, String token) {
          log('[onTokenPrivilegeWillExpire] connection: ${connection.toJson()}, token: $token');
        },
        onFirstRemoteVideoFrame:
            (connection, remoteUid, width, height, elapsed) {
          infosSetting.add('$remoteUid, $width, $height');
          update();
        },
      ),
    );

    await engine!.setClientRole(role: client!.role!);
    await engine!.enableVideo();
    await engine!.startPreview();

    if (isTokenExpiring) {
      engine!.renewToken(client!.tokenId!);
      isTokenExpiring = false;
    } else {
      await engine!.joinChannel(
        token: client!.tokenId!,
        channelId: client!.channelName!,
        uid: 0,
        options: ChannelMediaOptions(clientRoleType: client!.role!),
      );
    }
    update();
  }

  Future<void> disposeEngine() async {
    await engine!.leaveChannel();
    await engine!.release();
    remoteUids = <int>[];
    infosSetting = <String>[];
    engine = null;
    localUserJoined = false;
    isTokenExpiring = false;
  }

  void generateToken(String screeningId) {
    const appCertificate = '0726073fb7b0431abe96c6607946628b';
    const uid = '0';
    const role = RtcRole.publisher;
    const expirationInSeconds = 7200;
    final currentTimestamp = DateTime.now().millisecondsSinceEpoch ~/ 1000;
    final expireTimestamp = currentTimestamp + expirationInSeconds;

    agoraToken = RtcTokenBuilder.build(
      appId: appId,
      appCertificate: appCertificate,
      channelName: screeningId,
      uid: uid,
      role: role,
      expireTimestamp: expireTimestamp,
    );
    update();
  }
}
