import 'package:dnn_app/modules/modules.dart';
import 'package:dnn_app/modules/use_terms/pages/pay_terms_page.dart';
import 'package:dnn_dependencies/get_export.dart';
import 'package:dnn_payment/modules/card/export.dart';
import 'package:dnn_start_appointment/core/bindings/schedule_binding.dart';
import 'package:dnn_streamming/dnn_streamming.dart';
import 'package:flutter/foundation.dart';

abstract class AppPages {
  /// [CAMPAIGN] ****************
  static final campaigns = <GetPage>[
    GetPage(
      name: Routes.campaignMainOffers,
      page: () => const CampaignMainOffersPage(),
      bindings: [CampaignBinding(), ShoppingCartBinding()],
      transition: transitionPage(),
    ),
    GetPage(
      name: Routes.campaignMainOffersForDependent,
      page: () => const CampaignMainOffersForDependentPage(),
      transition: transitionPage(),
    ),
    GetPage(
      name: Routes.campaignCartPlansWithFidelity,
      page: () => const CampaignPlansWithFidelityPage(),
      transition: transitionPage(),
    ),
    GetPage(
      name: Routes.campaignComplementsOffers,
      page: () => const CampaignComplementsPage(),
      bindings: [CampaignBinding()],
      transition: transitionPage(),
    ),
    GetPage(
      name: Routes.campaignComplementsOffersForDependent,
      page: () => const CampaignComplementsForDependentPage(),
      transition: transitionPage(),
    ),
    GetPage(
      name: Routes.campaignHireForDependent,
      page: () => const CampaignHireForDependentPage(),
      transition: transitionPage(),
    ),
    GetPage(
      name: Routes.campaignCartResume,
      page: () => const CampaignCartResumePage(),
      transition: transitionPage(),
    ),
    GetPage(
      name: Routes.campaignCartConfirm,
      page: () => const CampaignCartConfirmPage(),
      transition: transitionPage(),
    ),
    GetPage(
      name: Routes.campaignDependentPersonalInfos,
      page: () => const CampaignDependentPersonalInfoPage(),
      transition: transitionPage(),
    ),
    GetPage(
      name: Routes.campaignDependentLocationInfos,
      page: () => CampaignDependentsZipCodePage(),
      transition: transitionPage(),
    ),
    GetPage(
      name: Routes.campaignPersonalInfos,
      page: () => const CampaignPersonalInfosPage(),
      transition: transitionPage(),
    ),
    GetPage(
      name: Routes.campaignLocationInfos,
      page: () => CampaignLocatonInfosPage(),
      transition: transitionPage(),
    ),
  ];

  /// [INVOICES] ****************
  static final invoices = <GetPage>[
    GetPage(
        name: Routes.myInvoices,
        binding: InvoicesBinding(),
        page: () => const MyContractsPage(),
        transition: transitionPage()),
    GetPage(
        name: Routes.myContractsInvoices,
        page: () => const ContractInvoicesPage(),
        transition: transitionPage()),
    GetPage(
        name: Routes.myContractsInvoicesResume,
        page: () => const ContractInvoicesResumePage(),
        transition: transitionPage()),
    GetPage(
        name: Routes.myPlansDetails,
        page: () => MyInvoiceDetails(),
        transition: transitionPage()),
    GetPage(
        name: Routes.myInvoiceRecover,
        page: () => const InvoiceRecoverPaymentPage(),
        transition: transitionPage()),
  ];

  /// [OFFERS] ****************
  static final offers = <GetPage>[
    GetPage(
      name: Routes.offersPage,
      page: () => const OffersPage(),
      binding: OffersBinding(),
      transition: transitionPage(),
    ),
    GetPage(
      name: Routes.offersPageDetails,
      page: () => OfferDetailPage(),
      transition: transitionPage(),
    ),
  ];

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

  /// [SCHEDULE_APPOINTMENT] ********************
  static final scheduleAppointment = <GetPage>[
    GetPage(
      name: Routes.scheduleType,
      page: () => const AppointmentTypePage(),
      bindings: [ScheduleBinding()],
      transition: transitionPage(),
    ),
    GetPage(
      name: Routes.scheduleGeneralFilters,
      page: () => const AppointmentGeneralFiltersPage(),
      transition: transitionPage(),
    ),
    GetPage(
      name: Routes.scheduleCityFilter,
      page: () => const AppointmentCityFilterPage(),
      transition: transitionPage(),
    ),
    GetPage(
      name: Routes.scheduleClinicFilter,
      page: () => const ClinicPageStep(),
      transition: transitionPage(),
    ),
    GetPage(
      name: Routes.scheduleSpecialtyFilter,
      page: () => const SpecialtyPageStep(),
      transition: transitionPage(),
    ),
    GetPage(
      name: Routes.scheduleSpecialistFilter,
      page: () => const SpecialistPageStep(),
      transition: transitionPage(),
    ),
    GetPage(
      name: Routes.scheduleSpecialistAble,
      page: () => const SpecialistAvaiableHoursPage(),
      transition: transitionPage(),
    ),
    GetPage(
      name: Routes.scheduleSpecialtyAble,
      page: () => const SpecialtyAvaiableHoursPage(),
      transition: transitionPage(),
    ),
    GetPage(
      name: Routes.scheduleSelectSpecialist,
      page: () => const SpecialtySelectSpecialistPage(),
      transition: transitionPage(),
    ),
    GetPage(
      name: Routes.scheduleConfirm,
      page: () => const ConfirmAppointmentPage(),
      transition: transitionPage(),
    ),
    GetPage(
      name: Routes.scheduleConclusion,
      page: () => const AppointmentSucessPage(),
      transition: transitionPage(),
    ),
    GetPage(
      name: Routes.schedulePatientInfos,
      page: () => const PatientCPFInfoPage(),
      transition: transitionPage(),
    ),
    GetPage(
      name: Routes.schedulePatientZipcode,
      page: () => PatientZipCodePage(),
      transition: transitionPage(),
    ),
    GetPage(
      name: Routes.scheduleOtherPatient,
      page: () => const OtherPatientSelectPage(),
      transition: transitionPage(),
    ),
  ];

  /// [startAppointment] ****************
  static final startAppointment = <GetPage>[
    GetPage(
      name: Routes.startAppointment,
      page: () => const StartAppointmentSelectModel(),
      transition: transitionPage(),
      bindings: [
        CampaignBinding(),
        ShoppingCartBinding(),
        MyAppointmentsBinding()
      ],
    ),
  ];

  /// [MY_APPOINTMENTS] ****************
  static final myAppointments = <GetPage>[
    GetPage(
      name: Routes.myAppointments,
      page: () => const MyAppointmentsPage(),
      binding: MyAppointmentsBinding(),
      transition: transitionPage(),
    ),
    GetPage(
      name: Routes.myAppointmentsCancel,
      page: () => const CancelAppointmentPage(),
      transition: transitionPage(),
    ),
    GetPage(
      name: Routes.myAppointmentsCancelConfirm,
      page: () => const ConfirmCancelAppointmentPage(),
      transition: transitionPage(),
    ),
    GetPage(
      name: Routes.myAppointmentsReappoint,
      page: () => const ReAppointmentPage(),
      transition: transitionPage(),
    ),
    GetPage(
      name: Routes.myAppointmentsReappointConfirm,
      page: () => const ConfirmReappointmentPage(),
      transition: transitionPage(),
    ),
    GetPage(
      name: Routes.screenProntuaryClient,
      page: () => const PatientProntuaryPage(),
      transition: transitionPage(),
    ),
    GetPage(
      name: Routes.screenTriagemQueue,
      page: () => const QueueSchedulePage(),
      transition: transitionPage(),
    ),
    GetPage(
      name: Routes.streammingPatient,
      page: () => const ScreeningPatientPage(),
      transition: transitionPage(),
    ),
  ];

  static get pages => <GetPage>[
        GetPage(
            name: Routes.initialize,
            page: () => const InitializePage(),
            bindings: [
              PagesBinding(),
              InitializeBinding(),
              ConnectionBinding(),
            ],
            transition: transitionPage()),
        GetPage(
            name: Routes.splashPage,
            page: () => const SplashPage(),
            bindings: [
              PagesBinding(),
              InitializeBinding(),
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
              OffersBinding(),
              StartAppointmentBinding(),
              InvoicesBinding(),
              HelpersBinding(),
              PagesBinding(),
              CampaignBinding(),
              ShoppingCartBinding(),
              ScheduleBinding(),
              MyAppointmentsBinding(),
              StreammingBinding()
            ],
            transition: transitionPage()),
        GetPage(
            name: Routes.otpValidation,
            page: () => const OtpValidationPage(),
            transition: transitionPage()),
        GetPage(
            name: Routes.paymentStatus,
            bindings: [InvoicesBinding()],
            page: () => const PaymentFinalStatusPage(),
            transition: transitionPage()),
        GetPage(
            name: Routes.paymentError,
            page: () => PaymentDeinedPage(),
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
            name: Routes.paymentChoice,
            bindings: [
              CardBinding(),
              GatewayBinding(),
              InvoicesBinding(),
              CreditCardBinding(),
            ],
            page: () => const PaymentGatewayPage(),
            transition: transitionPage()),
        GetPage(
            name: Routes.renewalChoice,
            bindings: [
              CardBinding(),
              GatewayBinding(),
              InvoicesBinding(),
              UseTermsBinding(),
              ShoppingCartBinding(),
              CreditCardBinding(),
            ],
            page: () => const RenewalGatewayPage(),
            transition: transitionPage()),
        GetPage(
            name: Routes.paymentChoiceAddress,
            page: () => const MyChoiceAdressPage(),
            transition: transitionPage()),
        GetPage(
            name: Routes.useTerms,
            binding: UseTermsBinding(),
            page: () => UseTermsPage(
                  isDrawer: Get.arguments ?? false,
                ),
            transition: transitionPage()),
        GetPage(
            name: Routes.payTerms,
            page: () => const PayTermsPage(),
            transition: transitionPage()),
        GetPage(
            name: Routes.paymentResumeBoleto,
            binding: BilletBinding(),
            page: () => const PaymentBilletPage(),
            transition: transitionPage()),
        GetPage(
            name: Routes.creditCardInfos,
            page: () => const CreditCardInformationsPage(),
            transition: transitionPage()),
        GetPage(
            name: Routes.creditCardList,
            page: () => const MyCreditCardsListPage(),
            transition: transitionPage()),
        GetPage(
            name: Routes.indentifyCCV,
            page: () => const CreditCardInformCCVPage(),
            transition: transitionPage()),
        GetPage(
            name: Routes.addressForPayment,
            page: () => const MyAddressForPaymentPage(),
            transition: transitionPage()),
        GetPage(
            name: Routes.creditResumeFinishPage,
            page: () => const CreditCardResumePage(),
            transition: transitionPage()),
        GetPage(
            name: Routes.paymentResumePix,
            bindings: [PixBinding(), InvoicesBinding()],
            page: () => const PaymentPixPage(),
            transition: transitionPage()),
        GetPage(
            name: Routes.serviceChoiceDependent,
            page: () => const ServiceChoiceDependent(),
            transition: transitionPage()),
        GetPage(
          name: Routes.serviceCall,
          page: () => const ServiceCallPage(),
          transition: transitionPage(),
        ),
        GetPage(
          name: Routes.qaTest,
          page: () => const ProfileTestList(),
          transition: transitionPage(),
        ),
        ...helpers,
        ...invoices,
        ...campaigns,
        ...offers,
        ...register,
        ...scheduleAppointment,
        ...startAppointment,
        ...myAppointments,
      ];

  static Transition transitionPage({Transition? transition}) {
    if (kIsWeb) {
      return Transition.noTransition;
    }
    return transition ?? Transition.cupertino;
  }
}
