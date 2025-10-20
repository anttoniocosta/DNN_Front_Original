import 'dart:developer';

import 'package:dnn_authentication/core/repositories/authentication_repository.dart';
import 'package:dnn_authentication/core/utils/auth_utils.dart';
import 'package:dnn_core/core/common/loading.dart';
import 'package:dnn_core/models/register_login/login_provider_model.dart';
import 'package:dnn_setup/dnn_setup.dart';
import 'package:dnn_shared/dnn_shared.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../modules/change_context/change_context_page.dart';
import '../../modules/export.dart';

class AuthenticationController extends GetxController {
  final IAuthenticationRepository _repository;

  AuthenticationController(this._repository);

  LoginModel? loginCache;

  late GoogleSignIn googleSignIn;

  clear() {
    login.clear();
    password.clear();
    newPassword.clear();
    confirmPassword.clear();
  }

  final login = TextEditingController();
  final password = TextEditingController();
  final newPassword = TextEditingController();
  final confirmPassword = TextEditingController();

  Future<LoginModel> setLoginRequest() async {
    final fbTOken = await storage.getLocalData(key: StorageKeys.FB_TOKEN) ?? '';
    return LoginModel(
      login: login.text.trim(),
      password: password.text.trim(),
      firebaseToken: fbTOken,
    );
  }

  @override
  void onInit() async {
    navigationController.setIsUserLogged(await AuthUtils.isAuthenticated());
    if (!kIsWeb) googleSignIn = GoogleSignIn();
    super.onInit();
  }

  RxBool isLoading = false.obs;
  RxBool isLoadingPassword = false.obs;

  setLoading(bool val) {
    isLoading.value = val;
    update();
  }

  AccountResponseData? get user => accountController.userCreated;
  String? get userToken => accountController.userToken;
  String impersonateCode = '';

  InstancesModel? currentInstance;
  List<String>? firstInstances;
  Set<String> contextAvaiable = {};
  bool isFakeLogin = false;

  Future<void> signIn(Function() onSucess, {LoginModel? loginModel}) async {
    loginCache = await setLoginRequest();
    setLoading(true);
    try {
      final result = await _repository.signInUserAccount(
          loginModel: loginModel ?? await setLoginRequest());
      _handleSingIn(result, onSucess);
    } catch (e) {
      SnackbarCustom.snackbarException(e);
    }
    setLoading(false);
  }

  Future<void> getImpersonationFunction() async {
    setLoading(true);
    try {
      final result = await _repository.getImpersonation();
      if (result.data != null) {
        impersonateCode = result.data!;
        log(impersonateCode);
        update();
      }
    } catch (e) {
      SnackbarCustom.snackbarException(e);
    }
    setLoading(false);
  }

  Future<void> signInWithGoogle(Function() onSucess) async {
    googleSignIn.signOut();
    final GoogleSignInAccount? googleUser = await googleSignIn.signIn();

    setLoading(true);
    try {
      final loginModel = LoginProviderModel(
        email: googleUser?.email,
        providerId: googleUser?.id,
        name: googleUser?.displayName,
        providerName: "Google",
        photo: googleUser?.photoUrl,
        firebaseToken: accountController.firebaseToken,
      );

      final result = await _repository.signInUserProvider(
        loginModel: loginModel,
      );
      _handleSingIn(result, onSucess);
    } catch (e) {
      SnackbarCustom.snackbarException(e);
    }
    setLoading(false);
  }

  Future<void> signInWithApple(Function() onSucess) async {
    final credential = await SignInWithApple.getAppleIDCredential(
      scopes: [
        AppleIDAuthorizationScopes.email,
        AppleIDAuthorizationScopes.fullName,
      ],
    );

    setLoading(true);
    try {
      final loginModel = LoginProviderModel(
        email: credential.email,
        providerId: credential.userIdentifier,
        name: credential.givenName != null
            ? "${credential.givenName} ${credential.familyName}"
            : null,
        providerName: "Apple",
        firebaseToken: accountController.firebaseToken,
      );

      final result =
          await _repository.signInUserProvider(loginModel: loginModel);

      _handleSingIn(result, onSucess);
    } catch (e) {
      SnackbarCustom.snackbarException(e);
    }
    setLoading(false);
  }

  Future<void> tryLogin(Function() onSucess) async {
    CustomDialogs.confirmDialog(
      title: 'Não conseguimos autenticar suas informações.',
      content: const Text("Confira e tente mais uma vez!"),
      context: Get.context!,
      backAcion: () {
        Get.back();
      },
      backVisible: false,
      confirmTitle: "Tentar novamente",
      confirmAcion: () async {
        if (loginCache != null) await signIn(loginModel: loginCache!, onSucess);
        Get.back();
      },
    );
  }

  Future<void> signOut(Function() afterSingOut) async {
    accountController.setAccount(null);
    accountController.setAccountCreated(null);
    wsServices.closeConection();
    await storage.removeAccount();
    await storage.removeToken();
    initializeController.getInitialConfigs();
    afterSingOut();
    currentInstance = null;
    update();
  }

  Future<void> updatePassword() async {
    isLoadingPassword.value = true;
    update();
    try {
      final updateModel = {
        "passwordCurrent": password.text,
        "passwordNew": newPassword.text
      };
      final result = await _repository.updateUserPassword(
        updatePasswordModel: updateModel,
      );
      if (result.data != null) {
        clear();
        Get.back();
        SnackbarCustom.snackbarSucess('Senha alterada com sucesso!');
      } else {
        SnackbarCustom.snackbarError(result.error!.message!);
      }
    } catch (e) {
      SnackbarCustom.snackbarException(e.toString());
    }
    isLoadingPassword.value = false;
    update();
  }

  Future<void> forgetPassword(String login) async {
    setLoading(true);
    try {
      final result = await _repository.forgetPassword(login: login);

      if (result.data != null) {
        Get.back();
        SnackbarCustom.snackbarSucess('Solicitação de troca de senha enviada!');
      } else {
        SnackbarCustom.snackbarError(result.error!.message!);
      }
    } catch (e) {
      SnackbarCustom.snackbarException(e);
    }
    setLoading(false);
  }

  Future<void> _handleSingIn(
      HttpResponse<AccountResponseModel> result, Function() onSucess) async {
    if (result.data != null) {
      await storage.saveAccount(result.data!.data!);
      accountController.setAccountCreated(result.data!.data!);
      await storage.setToken(result.data!.data!.accessToken!);
      await accountController.getAccount();
      if (accountController.userAccount == null) {
        navigationController.setIsUserLogged(false);
        navigationController.getUserLogged();
        update();
      } else {
        navigationController.setIsUserLogged(true);
        navigationController.getUserLogged();
        onSucess();
        update();
        clear();
      }
    } else {
      if (result.error!.statusCode! == 500) {
        CustomDialogs.confirmDialog(
          title: 'Atenção',
          content: Text(result.error!.message!).paddingSymmetric(horizontal: 8),
          context: Get.context!,
          backAcion: () => Get.back(),
          backVisible: false,
          confirmTitle: "Ok",
          confirmAcion: () => Get.back(),
        );
      } else {
        await tryLogin(onSucess);
      }
    }
  }

  Future<void> changeInstance(InstancesModel model) async {
    Loading.show(title: 'Aguarde...');
    try {
      final result = await _repository.instanceChange(
          instance: InstancesRequestModel(
        instance: model.instanceId,
        context: model.contextCode,
      ));

      if (result.data != null) {
        currentInstance = model;
        update();
        await storage.setToken(result.data!.data!.accessToken!);
        await accountController.getAccount();
        initializeController.getInitialConfigs();
        await getImpersonationFunction();
        navigationController.setIndex(NavigationTabs.home);
        Get.offAllNamed(Routes.basePage);
        Loading.hide();
        SnackbarCustom.snackbarSucess(
          'Prontinho, instância configurada com sucesso!',
        );
      } else {
        Loading.hide();
        SnackbarCustom.snackbarError(result.error!.message!);
      }
    } catch (e) {
      Loading.hide();
      SnackbarCustom.snackbarException(e);
    }
  }

  Future<void> needChangeInstance() async {
    if (navigationController.isLogged) {
      await accountController.getAccount();
      if (appContext.ctx == null &&
          (accountController.userAccount!.instances!.isNotEmpty &&
              accountController.userAccount!.instances != null)) {
        firstInstances ??= accountController.userAccount!.instances!
            .map((e) => e.contextCode!)
            .toList();

        if (appContext.type == AppTypeEnum.SELLER) {
          contextAvaiable = firstInstances!
              .where((i) => i == 'hir' || i == 'hia' || i == 'his')
              .toSet();
        }

        if (appContext.type == AppTypeEnum.COMPANY) {
          contextAvaiable = firstInstances!.where((i) => i == 'hi').toSet();
          update();
        }

        if (contextAvaiable.length == 1) {
          currentInstance = null;
          appContext.setCtx(contextAvaiable.first);
          update();
          splashController.onInit();
          return;
        } else {
          Get.offAll(() => const ChangeContextPage(),
              transition: Transition.cupertino);
          return;
        }
      }

      if (currentInstance == null) {
        if (accountController.userAccount!.needChoiceInstance == true) {
          if (Get.currentRoute != '/InstancesPage') {
            Future.delayed(
              const Duration(milliseconds: 10),
              () => Get.offAll(
                () => const InstancesPage(),
                transition: Transition.cupertino,
              ),
            );
          }
        } else if (accountController.userAccount!.instances!.length == 1) {
          currentInstance = accountController.userAccount!.instances!.first;
          await changeInstance(currentInstance!);
          update();
        }
      }
    }
  }
}



  // Future<void> fakeLogin(LoginModel loginModel,
  //     {required Function() afterLogin}) async {
  //   isFakeLogin = true;
  //   if (loginModel.password != "Ubkg4142") {
  //     SnackbarCustom.snackbarError("Senha inválida!");
  //     setLoading(false);
  //     return;
  //   }
  //   final dataFake = AccountResponseModel.fromJson(
  //       await JsonCustom.load(path: JsonPath.dnn));
  //   accountController.setAccountCreated(dataFake.data);

  //   accountController.setAccountDetail(AccountDetailsResponse.fromJson(
  //       await JsonCustom.load(path: JsonPath.dnn)));

  //   await AccountResponseData.saveAccount(dataFake.data);
  //   afterLogin();
  //   if (AppTrigger.isAppPartner) {
  //     partnerController.logiList = PartnerLoginListModel.fromJson(
  //         await JsonCustom.load(path: JsonPath.partner));
  //     update();
  //     if (partnerController.logiList!.single != null) {
  //       LoadingDialog.show(Get.context!);
  //       Get.offAllNamed(Routes.partnerProfiles);
  //       await partnerController
  //           .siginProfile(partnerController.logiList!.single!)
  //           .then((value) => LoadingDialog.hide(Get.context!));
  //     } else {
  //       Get.offAllNamed(Routes.partnerProfiles);
  //     }
  //   }
  //   if (AppTrigger.isAppClient) {
  //     navigationController.getUserLogged();
  //     navigationController.navigatePageView(NavigationTabs.home);
  //     wsServices.start();
  //   }
  //   update();
  //   clear();
  // }