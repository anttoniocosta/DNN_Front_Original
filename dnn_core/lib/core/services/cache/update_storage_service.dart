import 'dart:async';

class UpdateStorageService {
  const UpdateStorageService();
  static void updatePeriodicService(void Function(Timer) func,
      {int? minutes}) async {
    Timer.periodic(Duration(minutes: minutes ?? 30), func);
  }
}
