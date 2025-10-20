import 'package:dnn_app_company/components/portal_web_view.dart';
import 'package:dnn_app_company/modules/modules.dart';
import 'package:dnn_app_company/modules/use_terms/pages/pay_terms_page.dart';
import 'package:dnn_dependencies/get_export.dart';
import 'package:dnn_payment/modules/card/export.dart';
import 'package:flutter/foundation.dart';

abstract class AppPages {
  static final campaigns = <GetPage>[
    /// [CAMPAIGN] ****************
    GetPage(
      name: Routes.campaignMainOffers,
      page: () => const CampaignMainOffersPage(),
      bindings: [CampaignBinding(), ShoppingCartBinding()],
      transition: transitionPage(),
    ),
    GetPage(
      name: Routes.campaignMainOffersForDependent,
      page: () => const CampaignMainOffersForDependentPage(),
      bindings: [CampaignBinding(), ShoppingCartBinding()],
      transition: transitionPage(),
    ),
    GetPage(
      name: Routes.campaignCartPlansWithFidelity,
      page: () => const CampaignPlansWithFidelityPage(),
      bindings: [CampaignBinding(), ShoppingCartBinding()],
      transition: transitionPage(),
    ),
    GetPage(
      name: Routes.campaignComplementsOffers,
      page: () => const CampaignComplementsPage(),
      bindings: [CampaignBinding(), ShoppingCartBinding()],
      transition: transitionPage(),
    ),
    GetPage(
      name: Routes.campaignComplementsOffersForDependent,
      page: () => const CampaignComplementsForDependentPage(),
      bindings: [CampaignBinding(), ShoppingCartBinding()],
      transition: transitionPage(),
    ),
    GetPage(
      name: Routes.campaignHireForDependent,
      page: () => const CampaignHireForDependentPage(),
      bindings: [CampaignBinding(), ShoppingCartBinding()],
      transition: transitionPage(),
    ),
    GetPage(
      name: Routes.campaignCartResume,
      page: () => const CampaignCartResumePage(),
      bindings: [CampaignBinding(), ShoppingCartBinding()],
      transition: transitionPage(),
    ),
    GetPage(
      name: Routes.campaignCartConfirm,
      page: () => const CampaignCartConfirmPage(),
      bindings: [CampaignBinding(), ShoppingCartBinding()],
      transition: transitionPage(),
    ),
    GetPage(
      name: Routes.campaignDependentPersonalInfos,
      page: () => const CampaignDependentPersonalInfoPage(),
      bindings: [CampaignBinding(), ShoppingCartBinding()],
      transition: transitionPage(),
    ),
    GetPage(
      name: Routes.campaignDependentLocationInfos,
      page: () => CampaignDependentsZipCodePage(),
      bindings: [CampaignBinding(), ShoppingCartBinding()],
      transition: transitionPage(),
    ),
    GetPage(
      name: Routes.campaignPersonalInfos,
      page: () => const CampaignPersonalInfosPage(),
      bindings: [CampaignBinding(), ShoppingCartBinding()],
      transition: transitionPage(),
    ),
    GetPage(
      name: Routes.campaignLocationInfos,
      page: () => CampaignLocatonInfosPage(),
      bindings: [CampaignBinding(), ShoppingCartBinding()],
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
            page: () => const UseTermsPage(),
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
        GetPage(
          name: Routes.portalWebView,
          page: () => const PortalWebView(),
          transition: transitionPage(),
        ),
        ...helpers,
        ...invoices,
        ...campaigns,
        ...offers,
        ...register
      ];

  static Transition transitionPage({Transition? transition}) {
    if (kIsWeb) {
      return Transition.noTransition;
    }
    return transition ?? Transition.cupertino;
  }
}
