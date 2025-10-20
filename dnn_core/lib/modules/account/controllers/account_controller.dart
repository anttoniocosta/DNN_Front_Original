import 'package:dnn_authentication/dnn_authentication.dart';
import 'package:dnn_core/all_exports.dart';
import 'package:dnn_core/core/jsons/json_path.dart';
import 'package:dnn_core/core/jsons/jsons.dart';
import 'package:dnn_dependencies/get_export.dart';
import 'package:dnn_shared/res/assets/media_res.dart';
import 'package:flutter/widgets.dart';

class AccountController extends GetxController {
  final IAccountRepository _repository;

  AccountController(this._repository);

  UserAccountInfoModel? _accountAccount;
  AccountResponseData? _accountCreated;
  List<MaritalStatusModel> maritalStatusList = [];
  ValueNotifier<String> userPhoto = ValueNotifier<String>(MediaRes.blankImg);
  String personId = '';

  void setAccount(AccountDetailsResponse? model) {
    _accountAccount = model?.data ?? null;
    userPhoto.value = model?.data?.photo ?? MediaRes.blankImg;
    update();
  }

  void setAccountCreated(AccountResponseData? model) {
    _accountCreated = model ?? null;
    update();
  }

  void setTokenToNull() {
    _accountCreated?.accessToken = null;
    update();
  }

  void setToken(String val) {
    _accountCreated?.accessToken = val;
    update();
  }

  UserAccountInfoModel? get userAccount => _accountAccount;
  AccountResponseData? get userCreated => _accountCreated;
  String? get userToken =>
      _accountCreated != null ? _accountCreated!.accessToken : null;

  String? firebaseToken;

  RxBool isLoading = false.obs;
  RxBool isLoadingAccountInfos = false.obs;

  String? documentToConnecionId = '';
  String userGuuid = '';

  setDocumentoToConnectionId(String value) {
    documentToConnecionId = value;
    update();
  }

  setIsLoading(RxBool loading, bool state) {
    loading.value = state;
    update();
  }

  CreateClinicParams? clinicCreate;

  /// Após fornecer os dados, cria a conta, e se, caso ela já exista
  /// retorna um token '[NULL]' e o envia para a tela de login, caso não,
  /// o usuário segue para a tela de escolha de pagamento.
  Future<bool> createAccount(AccountRequestModel account) async {
    setIsLoading(isLoading, true);
    bool created = false;
    try {
      final result = await _repository.createUserAccount(account: account);

      if (result.data != null) {
        setAccountCreated(result.data!.data);
        if (userToken == null) {
          switch (appContext.type) {
            case AppTypeEnum.CLIENT:
            case AppTypeEnum.COMPANY:
            case AppTypeEnum.SPECIALIST:
            case AppTypeEnum.CLINIC:
              authenticationController.login.text =
                  userCreated!.login!.formatDocument();
              break;
            default:
              authenticationController.login.text = userCreated!.login!;
              break;
          }
          navigationController.setIndex(NavigationTabs.home);
          update();
          Get.offAllNamed(Routes.basePage);
          SnackbarCustom.snackbarError(
            'Este documento já possui conta, acesse diretamente pela tela de Entrar',
          );
        } else {
          created = true;
          await storage.saveAccount(_accountCreated!);
          await storage.removeToken();
          await storage.setToken(userToken!);
          await getAccount();
          navigationController.getUserLogged();
          wsServices.start();
          switch (appContext.type) {
            case AppTypeEnum.COMPANY:
            case AppTypeEnum.SELLER:
              await authenticationController.getImpersonationFunction();
              break;
          }
          SnackbarCustom.snackbarSucess(
            'Sua conta foi criada com sucesso, em instantes você receberá um e-mail com seus dados e senha!',
          );
          navigationController.setIndex(NavigationTabs.home);
          update();
          Get.offAllNamed(Routes.basePage);
        }
      }
      if (result.error != null) {
        SnackbarCustom.snackbarError(result.error!.message!);
      }
    } catch (e) {
      SnackbarCustom.snackbarException(e);
    }
    setIsLoading(isLoading, false);

    return created;
  }

  ///Chama a API de retorno dos dados da conta do usuário logado.
  Future<void> getAccount() async {
    isLoadingAccountInfos.value = true;
    update();
    try {
      final result = await _repository.getAccountInfos();

      if (result.data != null) {
        setAccount(result.data);
        wsServices.start();
      } else {
        if (userAccount == null) {
          SnackbarCustom.snackbarException(
              'Ocorreu um problema, tente novamente mais tarde');
          authenticationController.signOut(() async {
            await navigationController.getUserLogged();
          });
          return;
        }
      }
    } catch (e) {
      SnackbarCustom.snackbarException('Erro ao obter os dados do perfil');
    }
    isLoadingAccountInfos.value = false;
    update();
  }

  Future<void> getMaritalStatus({bool? forceUpdate}) async {
    try {
      maritalStatusList = [];
      if (forceUpdate != true) {
        final dataBox = await MaritalStatusModel().getData();
        if (dataBox != null && dataBox.isNotEmpty) {
          maritalStatusList = dataBox;
        } else {
          final listMap =
              await JsonCustom.loadList(path: JsonPath.maritalStatus);
          maritalStatusList = [];
          listMap
              .map((e) => maritalStatusList.add(MaritalStatusModel.fromJson(e)))
              .toList();

          await dbContext.addData(
            key: DatabaseModels.maritalStatusModel,
            data: maritalStatusList,
            clearCurrentData: true,
          );
        }
        return;
      }

      final result = await _repository.getMaritalStatus();

      if (result.data != null) {
        maritalStatusList = result.data!;
        update();
      } else {
        SnackbarCustom.snackbarError(result.error!.message!);
      }
    } catch (e) {
      SnackbarCustom.snackbarException('Erro ao obter os dados do perfil');
    }
  }

  Future<void> handleSaveLocalData() async {
    authenticationController.login.text = _accountCreated!.login!;
    setTokenToNull();
    setAccount(null);
    await storage.saveAccount(_accountCreated);
    update();
  }

  Future<void> needPhoneValidation() async {
    Future.delayed(const Duration(seconds: 1), () {
      if (Get.currentRoute != Routes.otpValidation) {
        if (userAccount == null) return;
        if (!userAccount!.phoneNumberConfirmed! &&
            userAccount!.phoneNumber!.isNotEmpty) {
          Future.delayed(
            const Duration(milliseconds: 10),
            () => Get.toNamed(Routes.otpValidation),
          );
        }
      }
    });
  }
}
