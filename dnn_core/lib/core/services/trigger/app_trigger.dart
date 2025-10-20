// import 'dart:developer';

// enum AppType { CLIENT, PARTNER, DOCTOR, SPECIALIST, CLINIC }

// final kClient = 'client';
// final kPartner = 'partner';
// final kDoctor = 'doctor';
// final kSpecialist = 'specialist';
// final kClinic = 'clinic';

// class AppTrigger {
//   static late final AppType _appType;
//   static late String _appTag = kClient;
//   static AppType get appType => _appType;

//   static setAppType(AppType val) {
//     _appType = val;
//     switch (appType) {
//       case AppType.PARTNER:
//         _appTag = kPartner;
//       case AppType.CLIENT:
//         _appTag = kClient;
//       case AppType.DOCTOR:
//         _appTag = kDoctor;
//       case AppType.SPECIALIST:
//         _appTag = kSpecialist;
//       case AppType.CLINIC:
//         _appTag = kClinic;
//         break;
//       default:
//     }
//     log(appType.toString());
//   }

//   static bool get isAppPartner => appType == AppType.PARTNER;
//   static bool get isAppDoctor => appType == AppType.DOCTOR;
//   static bool get isAppClient => appType == AppType.CLIENT;
//   static bool get isAppSpecialist => appType == AppType.SPECIALIST;
//   static bool get isAppClinic => appType == AppType.CLINIC;

//   static String get getAppTag => _appTag;
// }
