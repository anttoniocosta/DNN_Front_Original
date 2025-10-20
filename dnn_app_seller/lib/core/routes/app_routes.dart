import 'package:dnn_app_seller/components/portal_web_view.dart';
import 'package:dnn_app_seller/modules/modules.dart';
import 'package:dnn_campaign/dnn_campaign.dart';
import 'package:dnn_dependencies/get_export.dart';
import 'package:flutter/foundation.dart';

abstract class AppPages {
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
              HelpersBinding(),
              PagesBinding(),
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
            name: Routes.sellerLinks,
            page: () => const SellerLinksPage(),
            transition: transitionPage()),
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
        GetPage(
          name: Routes.portalWebView,
          page: () => const PortalWebView(),
          transition: transitionPage(),
        ),
        ...helpers,
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
