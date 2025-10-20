import 'dart:async';
import 'dart:developer';

import 'package:dnn_dependencies/get_export.dart';
import 'package:signalr_netcore/signalr_client.dart';

import '../all_exports.dart';

class WSServices {
  late HubConnection? connection = null;
  DateTime signalLastConnection = DateTime.now();
  late DateTime? lastReceive = null;
  late String? connectionId = '';

  Future start() async {
    connectionId = await setConnectionId();
    if (connection == null) {
      await initPlatformState();
      verifySignarConnection();
    }
  }

  Future<void> closeConection() async {
    try {
      if (connection != null) await connection!.stop();
    } catch (e) {
      if (e is TimeoutException) {
        log('Operação demorou muito!');
      } else {
        log('Ocorreu um erro desconhecido: $e');
      }
    }
  }

  Future<String> setConnectionId() async {
    try {
      final user = await storage.getAccount();
      if (user!.login != null) return user.login!;
      return '';
    } catch (e) {
      return '';
    }
  }

  Future verifySignarConnection() async {
    try {
      if (connection!.state == HubConnectionState.Disconnected ||
          connection!.state == HubConnectionState.Disconnecting)
        await initPlatformState();
    } catch (e) {
      log("SignalR verifySignarConnection error: ${e.toString()}");
    }
    await Future.delayed(Duration(seconds: 15));
    verifySignarConnection();
  }

  Future<void> initPlatformState() async {
    try {
      connection = HubConnectionBuilder()
          .withUrl(
            dnnController.setSocketUrl(),
            options: HttpConnectionOptions(),
          )
          .withAutomaticReconnect()
          .build();

      await connection!.start();
      connection!.onclose(({error}) async {
        log("==========================================");
        log("Web Socket Status");
        log('Conexão fechada. Tentando reconectar...');
        log("==========================================");
        await Future.delayed(
            Duration(seconds: 5)); // Aguarde antes de tentar reconectar
        await initPlatformState(); // Tente reconectar
      });

      connection!.on(
        'ReceiveStartConnectionHub',
        (parameter) async {
          if (parameter != null) {
            setConnectionId();
            signalLastConnection = DateTime.now();
            log("==========================================");
            log("Web Socket Status");
            log(parameter.toString());
            log("==========================================");
          }
        },
      );

      connection!.on(
        'AppRefreshDataPush',
        (parameter) async {
          log("==========================================");
          log("AppRefreshDataPush: Atualizar dados usuario, contratos, (qdo for parceiro, partners) ");
          log("==========================================");
        },
      );

      connection!.on(
        'AppRefreshDataAllPush',
        (parameter) async {
          log("==========================================");
          log("AppRefreshDataPush: Atualizar dados usuario, contratos, (qdo for parceiro, partners) ");
          log("==========================================");
        },
      );

      connection!.on(
        'AppPaymentPush',
        (parameter) async {
          log("==========================================");
          log("AppPaymentPush");
          log(parameter.toString());
          log("==========================================");
          if (parameter != null && parameter.isNotEmpty) {
            if (Get.currentRoute != Routes.paymentResumePix) return;
          }
        },
      );

      await connection!.invoke('StartConnectionHub', args: [
        await setConnectionId(),
      ]);
    } catch (e) {
      log('Erro ao iniciar a conexão: $e');
      await Future.delayed(Duration(seconds: 5));
      await initPlatformState();
    }
  }
}
