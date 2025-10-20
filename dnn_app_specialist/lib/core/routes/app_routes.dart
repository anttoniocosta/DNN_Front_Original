import 'package:dnn_app_specialist/core/specialist/binding/specialista_binding.dart';
import 'package:dnn_app_specialist/modules/modules.dart';
import 'package:dnn_dependencies/get_export.dart';
import 'package:dnn_streamming/dnn_streamming.dart';
import 'package:flutter/foundation.dart';

abstract class AppPages {
  /// [REGISTER] ****************
  static final register = <GetPage>[
    GetPage(
        name: Routes.registerPersonal,
        page: () => const RegisterCPFInfoPage(),
        transition: transitionPage()),
    GetPage(
        name: Routes.registerCompany,
        page: () => const RegisterCNPJInfoPage(),
        transition: transitionPage()),
    GetPage(
        name: Routes.registerZipcode,
        page: () => RegisterZipCodePage(),
        transition: transitionPage()),
    GetPage(
        name: Routes.registerType,
        page: () => const RegisterTypesPage(),
        transition: transitionPage()),
  ];

  /// [HELPERS] ****************
  static final helpers = <GetPage>[
    GetPage(
        name: Routes.helpers,
        page: () => const HelpersPage(),
        transition: transitionPage()),
    GetPage(
        name: Routes.helpersDetails,
        page: () => HelpersHelpDetails(),
        transition: transitionPage()),
    GetPage(
        name: Routes.helpersList,
        page: () => HelpersSpecifiedList(),
        transition: transitionPage()),
  ];

  /// [MY_APPOINTMENTS] ****************
  static final myAppointments = <GetPage>[
    GetPage(
      name: Routes.appointmentedSelectDay,
      page: () => const AlreadyAppointmentedSelectDayPage(),
      transition: transitionPage(),
    ),
    GetPage(
      name: Routes.appointmentedSelectHour,
      page: () => const AlreadyAppointmentedHoursPage(),
      transition: transitionPage(),
    ),
  ];

  /// [HELPERS] ****************
  static final screening = <GetPage>[
    GetPage(
        name: Routes.triagemQueueDoctor,
        page: () => const ReadyAppointmentList(),
        transition: transitionPage()),
    GetPage(
        name: Routes.screenProntuaryClient,
        page: () => const StaticPatientProntuary(),
        transition: transitionPage()),
    GetPage(
        name: Routes.scheduledQueueDoctor,
        page: () => const ScheduledAppointmentList(),
        transition: transitionPage()),
    GetPage(
        name: Routes.streammingDoctor,
        page: () => const ScreeningDoctorPage(),
        transition: transitionPage()),
    GetPage(
        name: Routes.streammingTriagem,
        page: () => const ScreeningTriagemPage(),
        transition: transitionPage()),
  ];

  static get pages => <GetPage>[
        GetPage(
            name: Routes.initialize,
            page: () => const InitializePage(),
            bindings: [
              PagesBinding(),
              InitializeBinding(),
              ConnectionBinding(),
              StreammingBinding(),
              SpecialistBinding(),
            ],
            transition: transitionPage()),
        GetPage(
            name: Routes.splashPage,
            page: () => const SplashPage(),
            bindings: [
              PagesBinding(),
              InitializeBinding(),
              ConnectionBinding(),
              StreammingBinding(),
            ],
            transition: transitionPage()),
        GetPage(
            name: Routes.environment,
            page: () => const EnvironmentPage(),
            transition: transitionPage()),
        GetPage(
            name: Routes.noInternet,
            page: () => const NoInternetPage(),
            transition: transitionPage()),
        GetPage(
            name: Routes.badInternet,
            page: () => const BadInternetSignalPage(),
            transition: transitionPage()),
        GetPage(
            name: Routes.basePage,
            page: () => const BasePage(),
            bindings: [
              ConnectionBinding(),
              InitializeBinding(),
              HelpersBinding(),
              PagesBinding(),
              StreammingBinding(),
              SpecialistBinding(),
            ],
            transition: transitionPage()),
        GetPage(
            name: Routes.otpValidation,
            page: () => const OtpValidationPage(),
            transition: transitionPage()),
        GetPage(
            name: Routes.myEditData,
            page: () => const EditDataPage(),
            transition: transitionPage()),
        GetPage(
            name: Routes.myUpdatePassword,
            page: () => const ChangePasswordPage(),
            transition: transitionPage()),
        GetPage(
          name: Routes.authPage,
          page: () => const SigninPage(),
          transition: transitionPage(),
          bindings: [ConnectionBinding()],
        ),
        GetPage(
            name: Routes.forgetPassword,
            page: () => const ForgetPasswordPage(),
            transition: transitionPage()),
        GetPage(
            name: Routes.profile,
            page: () => const ProfilePage(),
            bindings: [AccountBinding()],
            transition: transitionPage()),
        GetPage(
            name: Routes.profileSettings,
            page: () => const ProfileSettingsPage(),
            bindings: [QualityAssuranceBinding()],
            transition: transitionPage()),
        GetPage(
          name: Routes.qaTest,
          page: () => const ProfileTestList(),
          transition: transitionPage(),
        ),
        ...helpers,
        ...register,
        ...myAppointments,
        ...screening
      ];

  static Transition transitionPage({Transition? transition}) {
    if (kIsWeb) {
      return Transition.noTransition;
    }
    return transition ?? Transition.cupertino;
  }
}
