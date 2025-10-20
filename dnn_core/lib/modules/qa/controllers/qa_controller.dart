import 'package:dnn_authentication/dnn_authentication.dart';
import 'package:dnn_core/all_exports.dart';
import 'package:get/get.dart';

class QualityAssuranceController extends GetxController {
  final IQARepository _repository;

  QualityAssuranceController(this._repository);

  ScenariosResponse? scenerios;
  bool hasQA = false;

  RxBool isLoading = false.obs;

  @override
  void onInit() {
    getHasScenarios();
    getScenarios();
    super.onInit();
  }

  @override
  void onClose() async {
    scenerios = null;
    super.onClose();
  }

  setLoading(bool val) {
    isLoading.value = val;
    update();
  }

  Future<void> getScenarios() async {
    setLoading(true);
    try {
      final result = await _repository.getScenarios();
      if (result.data != null) {
        scenerios = result.data!;
        update();
      }
    } catch (e) {}
    setLoading(false);
  }

  Future<void> getHasScenarios() async {
    try {
      final result = await _repository.getHasQA();

      if (result.data != null) {
        hasQA = result.data!;
        update();
      }
    } catch (e) {
      SnackbarCustom.snackbarException(e);
    }
  }

  Future<void> changeScenario(MemberModel member) async {
    await authenticationController.signIn(
        loginModel: LoginModel(login: member.login, password: member.password),
        () async {
      navigationController.getUserLogged();
      navigationController.setIndex(NavigationTabs.home);
      Get.offAllNamed(Routes.basePage);
    });
  }
}
