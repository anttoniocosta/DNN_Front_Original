import 'dart:developer';

import 'package:dnn_campaign/dnn_campaign.dart';
import 'package:dnn_dependencies/get_export.dart';
import 'package:dnn_shared/dnn_shared.dart';
import 'package:flutter/material.dart';

class ShoppingCartController extends GetxController {
  final IShoppingCartRepository _repository;

  ShoppingCartController(this._repository);

  RxBool deleteShoppingCartLoading = false.obs;
  RxBool addShoppingCartLoading = false.obs;
  RxBool addDependentLoading = false.obs;
  RxBool shoppingCartPersonsLoading = false.obs;
  RxBool shoppingCartItemsLoading = false.obs;
  RxBool deleteShoppingCartPersonLoading = false.obs;
  RxBool deleteShoppingCartPlanLoading = false.obs;

  setLoading(RxBool loading, bool status) {
    loading.value = status;
    update();
  }

  bool alreadyShowedCartModal = false;
  bool hasCartOpen = false;
  String cartId = '';
  String depedentId = '';

  ShoppingCartItemsResponse? shoppingCartComplete;
  ShoppingCartPersonsResponse? shoppingCartPersons;
  List<AddShoppingDependent> pendingDependents = [];

  Future<void> getShoppingCart() async {
    String? guuid = await storage.getGUUID();
    try {
      final result = await _repository.getShoppingCart(userGuuid: guuid!);
      if (result.data != null) {
        storage.saveCartId(result.data!.id!);
        cartId = result.data!.id!;
        log(cartId);

        if (result.data!.hasCartOpen!) {
          await getShoppingCartPersons();
          if (appContext.type == AppTypeEnum.COMPANY) {
            if (shoppingCartPersons!.items!.length > 1) {
              CustomDialogs.shoppingCartDialog(
                continueOnTap: () => Get.back(),
                goToReume: () async {
                  Get.back();
                  Get.toNamed(Routes.campaignCartResume);
                },
                cancelOnTap: () async {
                  await deleteShoppingCart();
                  Get.back();
                },
              );
            }
          } else {
            CustomDialogs.shoppingCartDialog(
              continueOnTap: () => Get.back(),
              goToReume: () async {
                Get.back();
                Get.toNamed(Routes.campaignCartResume);
              },
              cancelOnTap: () async {
                await deleteShoppingCart();
                Get.back();
              },
            );
          }
        }
      } else {
        Get.back();
        SnackbarCustom.snackbarError(result.error!.message!);
      }
    } catch (e) {}
    update();
  }

  Future<void> getShoppingCartSecondCall() async {
    String? guuid = await storage.getGUUID();
    try {
      final result = await _repository.getShoppingCart(userGuuid: guuid!);
      if (result.data != null) {
        storage.saveCartId(result.data!.id!);
        cartId = result.data!.id!;
        log(result.data!.id!);
        hasCartOpen = result.data!.hasCartOpen!;
        update();
      }
    } catch (e) {}
    update();
  }

  Future<void> getShoppingCartPersons() async {
    setLoading(shoppingCartPersonsLoading, true);
    String? guuid = await storage.getGUUID();
    try {
      final result = await _repository.getShoppingCartPersons(
        userGuuid: guuid!,
      );
      if (result.data != null) {
        shoppingCartPersons = result.data;
        log(shoppingCartPersons!.items!.length.toString());
        update();
      }
    } catch (e) {}
    setLoading(shoppingCartPersonsLoading, false);
  }

  Future<void> getShoppingCartItems() async {
    setLoading(shoppingCartItemsLoading, true);
    String? guuid = await storage.getGUUID();
    try {
      final result = await _repository.getShoppingCartItems(
        userGuuid: guuid!,
      );

      if (result.data != null) {
        shoppingCartComplete = result.data;
        getShoppingCartPersons();
        update();
      }
    } catch (e) {}
    setLoading(shoppingCartItemsLoading, false);
  }

  Future<void> addShoppingCartMain() async {
    setLoading(addShoppingCartLoading, true);
    try {
      final result = await _repository.addShoppingCart(
        cartModel: await getCartModel(null, useCampaignActivated: true),
      );

      if (result.data != null) {
        shoppingCartComplete = result.data;
        getShoppingCartPersons();
        update();

        Get.toNamed(Routes.campaignCartResume);
      } else {
        if (result.error != null) {
          CustomDialogs.shoppingAlreadyHavePlan(
            title: result.error!.message!,
            addToDependent: () {
              Get.back();
              Get.toNamed(Routes.campaignDependentLocationInfos);
            },
            goToReume: () => Get.toNamed(Routes.campaignCartResume),
          );
        }
      }
    } catch (e) {
      debugPrint(e.toString());
    }
    setLoading(addShoppingCartLoading, false);
  }

  Future<void> addShoppingCartDependent() async {
    setLoading(addShoppingCartLoading, true);
    try {
      final result = await _repository.addShoppingCart(
          cartModel: await getCartModel(depedentId));

      if (result.data != null) {
        shoppingCartComplete = result.data;
        update();
        await getShoppingCartPersons();
        Get.offNamedUntil(
          Routes.campaignCartResume,
          ModalRoute.withName(Routes.campaignComplementsOffers),
        );
      } else {
        if (result.error != null) {
          CustomDialogs.shoppingAlreadyHavePlan(
            title: result.error!.message!,
            addToDependent: () => Get.offNamedUntil(
              Routes.campaignCartResume,
              ModalRoute.withName(Routes.campaignComplementsOffers),
            ),
            goToReume: () => Get.offNamedUntil(
              Routes.campaignCartResume,
              ModalRoute.withName(Routes.campaignComplementsOffers),
            ),
          );
        }
      }
    } catch (e) {
      debugPrint(e.toString());
    }
    setLoading(addShoppingCartLoading, false);
  }

  Future<void> addDependentToShoppingCart() async {
    setLoading(addDependentLoading, true);
    final model = AddShoppingDependent(
      document: providersController.setAccount().document,
      name: providersController.setAccount().name,
      birthday: providersController.setAccount().birthday,
      email: providersController.setAccount().email,
      phoneNumber: providersController.setAccount().phoneNumber,
      gender: providersController.setAccount().gender,
      registrationID: providersController.setAccount().registrationID,
      maritalStatus: providersController.setAccount().maritalStatus,
      address: providersController.setAccount().address,
    );
    try {
      final result = await _repository.addDependentCart(dependentModel: model);

      if (result.data != null) {
        depedentId = result.data!;
        pendingDependents.add(model);
        Get.toNamed(Routes.campaignMainOffersForDependent);
      } else {
        debugPrint(result.error!.message!);
      }
    } catch (e) {}
    setLoading(addDependentLoading, false);
  }

  Future<void> removeDependentToShoppingCart(
      AddShoppingDependent dependent) async {
    pendingDependents.remove(dependent);
    update();
  }

  Future<void> deleteShoppingCart() async {
    setLoading(deleteShoppingCartLoading, true);
    try {
      await _repository.deleteShoppingCart(cartId: cartId);
      await getShoppingCartSecondCall();
    } catch (e) {}
    setLoading(deleteShoppingCartLoading, false);
  }

  Future<void> deleteShoppidngCartPerson({required String personId}) async {
    setLoading(deleteShoppingCartPersonLoading, true);
    try {
      final result = await _repository.deleteShoppingCartPerson(
        deleteModel: DeleteShoppingCartPerson(
          cartId: cartId,
          personId: personId,
        ),
      );

      if (result.data != null) {
        await _handlerDeleteShoppingCartThings('Dependente');
      }
    } catch (e) {}
    setLoading(deleteShoppingCartPersonLoading, false);
  }

  Future<void> deleteShoppidngCartPlan(
      {required String personId, required String planId}) async {
    setLoading(deleteShoppingCartPlanLoading, true);
    try {
      final result = await _repository.deleteShoppingCartPlan(
        deleteModel: DeleteShoppingCartPlan(
            cartId: cartId, personId: personId, planId: planId),
      );
      if (result.data != null) {
        await _handlerDeleteShoppingCartThings('Plano');
      }
    } catch (e) {
      debugPrint(e.toString());
    }
    setLoading(deleteShoppingCartPlanLoading, false);
  }

  Future<void> _handlerDeleteShoppingCartThings(String thing) async {
    await getShoppingCartPersons();
    SnackbarCustom.snackbarSucess('$thing removido com sucesso!');
    if (shoppingCartPersons!.items!.isEmpty) {
      SnackbarCustom.snackbarSucess(
          'Você não possui item no carrinho, te direcionamos ao início!');
      Get.offAllNamed(Routes.basePage);
    }
  }

  /// Referece ao produto específico da empresa chamado [Ativar_Plano]
  String companyActivatePlanId = 'e440be3f-b6de-46fc-8b44-cd8d265f51bf';

  Future<AddShoppingCartModel> getCartModel(String? dependentId,
      {bool useCampaignActivated = false}) async {
    return AddShoppingCartModel(
      complements: campaignController.complementsId,
      planId: switch (appContext.type) {
        AppTypeEnum.CLIENT => campaignController.planId,
        AppTypeEnum.COMPANY => useCampaignActivated
            ? companyActivatePlanId
            : campaignController.planId,
        int() => campaignController.planId,
      },
      identifier: await storage.getGUUID(),
      dependentId: dependentId,
    );
  }
}
