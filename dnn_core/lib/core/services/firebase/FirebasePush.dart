import 'dart:developer';

import 'package:dnn_core/core/export.dart';
import 'package:dnn_core/dnn_core.dart';
import 'package:dnn_dependencies/dnn_dependencies.dart';
import 'package:dnn_dependencies/get_export.dart';
import 'package:flutter/material.dart';

class PushNotification {
  PushNotification({
    this.title,
    this.body,
    this.dataTitle,
    this.dataBody,
  });

  String? title;
  String? body;
  String? dataTitle;
  String? dataBody;
}

class FirebasePush {
  late final FirebaseMessaging _messaging;
  late NotificationSettings settings;
  late String token = "";
  PushNotification? _notificationInfo;
  FirebasePush();

  Future start() async {
    try {
      await registerNotification();
      await checkForInitialMessage();
    } catch (e) {
      Logs.p.e(e);
    }
  }

  Future<void> registerNotification() async {
    try {
      _messaging = FirebaseMessaging.instance;
      settings = await _messaging.requestPermission(
        alert: true,
        badge: true,
        provisional: false,
        sound: true,
      );
      // FirebaseMessaging.onBackgroundMessage(
      //     _firebaseMessagingBackgroundHandler);
    } catch (e) {
      log("erro: ${e.toString()}");
    }

    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
        PushNotification notification = PushNotification(
          title: message.notification?.title,
          body: message.notification?.body,
          dataTitle: message.data['title'],
          dataBody: message.data['body'],
        );

        _notificationInfo = notification;
      });
      if (await _messaging.isSupported()) {
        accountController.firebaseToken = await _messaging.getToken();
        String? fbToken = await _messaging.getToken();
        storage.saveLocalData(key: StorageKeys.FB_TOKEN, data: fbToken!);
        var token = await _messaging.getToken();
        log(token!);
        _messaging.subscribeToTopic('All').then((_) {
          log('Inscrito no tópico All com sucesso!');
        });
        _messaging.subscribeToTopic('Client').then((_) {
          log('Inscrito no tópico Client com sucesso!');
        });
      }

      FirebaseMessaging.onMessage.listen((RemoteMessage message) {
        PushNotification notification = PushNotification(
          title: message.notification?.title,
          body: message.notification?.body,
          dataTitle: message.data['title'],
          dataBody: message.data['body'],
        );

        _notificationInfo = notification;

        if (_notificationInfo != null) {
          Flushbar(
            margin: const EdgeInsets.all(8),
            borderRadius: BorderRadius.circular(8),
            title: _notificationInfo!.title!,
            message: _notificationInfo!.body!,
            flushbarPosition: FlushbarPosition.TOP,
            dismissDirection: FlushbarDismissDirection.HORIZONTAL,
            isDismissible: false,
            duration: const Duration(seconds: 5),
            onTap: (_) {
              log(message.data.toString());
            },
          ).show(Get.context!);
        }
      });
    } else {
      log('User declined or has not accepted permission');
    }
  }

  checkForInitialMessage() async {
    RemoteMessage? initialMessage =
        await FirebaseMessaging.instance.getInitialMessage();

    if (initialMessage != null) {
      PushNotification notification = PushNotification(
        title: initialMessage.notification?.title,
        body: initialMessage.notification?.body,
        dataTitle: initialMessage.data['title'],
        dataBody: initialMessage.data['body'],
      );

      _notificationInfo = notification;
    }
  }
}
