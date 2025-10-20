import 'package:dnn_app_clinic/core/clinic/binding/clinic_create_binding.dart';
import 'package:dnn_app_clinic/modules/auth/ui/signUp/clinic_data_info_page.dart';
import 'package:dnn_app_clinic/modules/auth/ui/signUp/clinic_zip_code_page.dart';
import 'package:dnn_app_clinic/modules/modules.dart';
import 'package:dnn_authentication/dnn_authentication.dart';
import 'package:dnn_dependencies/get_export.dart';
import 'package:dnn_offers/dnn_offers.dart';
import 'package:dnn_setup/dnn_setup.dart';
import 'package:dnn_shared/dnn_shared.dart';

abstract class AppPages {
  /// [REGISTER] ****************
  static final register = <GetPage>[
    GetPage(
        name: Routes.registerClinic,
        page: () => const ClinicDataInfoPage(),
        transition: transitionPage()),
    GetPage(
        name: Routes.registerZipcode,
        page: () => ClinicZipcodePage(),
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

  /// [CLINIC_DATA] ****************
  static final clinicData = <GetPage>[
    GetPage(
        name: Routes.clinicaData,
        page: () => const ClinicDataPage(),
        transition: transitionPage()),
    GetPage(
        name: Routes.clinicaDataChanged,
        page: () => const SucessDataChangedPage(),
        transition: transitionPage()),
  ];

  /// [MY_ADS] ****************
  static final myAds = <GetPage>[
    GetPage(
        name: Routes.adSelectSpecialist,
        page: () => const AdSpecialistListPage(),
        transition: transitionPage()),
    GetPage(
        name: Routes.adSelectConclusion,
        page: () => const AdFinishedPage(),
        transition: transitionPage()),
    GetPage(
        name: Routes.adSelectDay,
        page: () => const SelectDaysAdPage(),
        transition: transitionPage()),
    GetPage(
        name: Routes.adSelectHour,
        page: () => const SelectHoursAdPage(),
        transition: transitionPage()),
  ];

  /// [MY_SPECIALISTS] ****************
  static final mySpecialists = <GetPage>[
    GetPage(
        name: Routes.mySpecialistList,
        page: () => const MySpecialistsListPage(),
        transition: transitionPage()),
    GetPage(
        name: Routes.addSpecialistInfos,
        page: () => const SpecialistPersonalInfosPage(),
        transition: transitionPage()),
    GetPage(
        name: Routes.addSpecialistLocation,
        page: () => const SpecialistPersonalZipCodePage(),
        transition: transitionPage()),
    GetPage(
        name: Routes.addSpecialistSpecialty,
        page: () => const SpecialistsSelectSpecialtyPage(),
        transition: transitionPage()),
    GetPage(
        name: Routes.addSpecialistDuration,
        page: () => const SpecialistConsultDurationPage(),
        transition: transitionPage()),
    GetPage(
        name: Routes.addSpecialistType,
        page: () => const SpecialistConsultTypePage(),
        transition: transitionPage()),
    GetPage(
        name: Routes.addSpecialistPrice,
        page: () => const SpecialistConsultPricePage(),
        transition: transitionPage()),
    GetPage(
        name: Routes.addSpecialistPhoto,
        page: () => const SpecialistPicturePage(),
        transition: transitionPage()),
    GetPage(
        name: Routes.addSpecialistConclusion,
        page: () => const SpecialistFinishRegisterPage(),
        transition: transitionPage()),
  ];

  /// [PUBLISH_AGENDA] ****************
  static final publishData = <GetPage>[
    GetPage(
        name: Routes.publishSpecialist,
        page: () => const AgendaSpecialistListPage(),
        transition: transitionPage()),
    GetPage(
        name: Routes.publishSelectDay,
        page: () => const SelectDaysToPublishPage(),
        transition: transitionPage()),
    GetPage(
        name: Routes.publishSelectHour,
        page: () => const SelectHoursToPublishPage(),
        transition: transitionPage()),
    GetPage(
        name: Routes.publishSelectConclusion,
        page: () => const PublishAgendaFinishedPage(),
        transition: transitionPage()),
  ];

  /// [MY_APPOINTMENTS] ****************
  static final myAppointments = <GetPage>[
    GetPage(
      name: Routes.appointmentSpecialistList,
      page: () => const AppointmentSpecialistListPage(),
      transition: transitionPage(),
    ),
    GetPage(
      name: Routes.appointmentSelectType,
      page: () => const ChoiceAppointmentTypePage(),
      transition: transitionPage(),
    ),
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
    GetPage(
      name: Routes.appointmentedConfirm,
      page: () => const AlreadyAppointmentedConfirmCancelPage(),
      transition: transitionPage(),
    ),
    GetPage(
      name: Routes.appointmentedConclusion,
      page: () => const AlreadyAppointmentedFinishedPage(),
      transition: transitionPage(),
    ),
    GetPage(
      name: Routes.reappoinmentSelectDay,
      page: () => const ReappointmentSelectDayPage(),
      transition: transitionPage(),
    ),
    GetPage(
      name: Routes.reappoinmentSelectHour,
      page: () => const ReappointmentHoursPage(),
      transition: transitionPage(),
    ),
    GetPage(
      name: Routes.reappoinmentConfirm,
      page: () => const ReappointmentConfirmPage(),
      transition: transitionPage(),
    ),
    GetPage(
      name: Routes.reappoinmentConclusion,
      page: () => const ReappointmentFinishedPage(),
      transition: transitionPage(),
    ),
    GetPage(
      name: Routes.onReappoinmentSelectDay,
      page: () => const OnReappointmentSelectDayPage(),
      transition: transitionPage(),
    ),
    GetPage(
      name: Routes.onReappoinmentSelectHour,
      page: () => const OnReappointmentHoursPage(),
      transition: transitionPage(),
    ),
    GetPage(
      name: Routes.canceledSelectDay,
      page: () => const CanceledSelectDayPage(),
      transition: transitionPage(),
    ),
    GetPage(
      name: Routes.canceledSelectHour,
      page: () => const CanceledHoursPage(),
      transition: transitionPage(),
    ),
    GetPage(
      name: Routes.finishedSelectDay,
      page: () => const AlreadyFinishedSelectDayPage(),
      transition: transitionPage(),
    ),
    GetPage(
      name: Routes.finishedSelectHour,
      page: () => const AlreadyFinishedHoursPage(),
      transition: transitionPage(),
    ),
  ];

  static get pages => <GetPage>[
        GetPage(
            name: Routes.initialize,
            page: () => const InitializePage(),
            bindings: [
              InitializeBinding(),
              OffersBinding(),
              ConnectionBinding(),
              ClinicCreateBinding()
            ],
            transition: transitionPage()),
        GetPage(
            name: Routes.splashPage,
            page: () => const SplashPage(),
            bindings: [
              InitializeBinding(),
              OffersBinding(),
              ConnectionBinding(),
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
              ClinicCreateBinding()
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
        ...clinicData,
        ...myAds,
        ...mySpecialists,
        ...publishData,
        ...myAppointments,
      ];
}
