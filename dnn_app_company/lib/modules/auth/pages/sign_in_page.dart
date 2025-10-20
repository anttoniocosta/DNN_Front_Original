import 'package:dnn_app_company/modules/modules.dart';
import 'package:flutter/material.dart';

class SigninPage extends StatelessWidget {
  const SigninPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MobileLayout(
      needCenter: false,
      needScrollView: true,
      title: 'Entrar',
      hasLeading: true,
      maxWidth: Responsive.maxWidth(),
      appBarLeading: const MenuButtom(),
      drawer: const DrawerCustom(navbarItems: NaviItems()),
      bodyChild: SignInPartial(
        acessWithProviders: false,
        signInAction: () async {
          await authenticationController.getImpersonationFunction();
          offersController.getOffers();
          navigationController.navigatePageView(NavigationTabs.home);
          wsServices.start();
          ShoppingCartBinding().dependencies();
          await shoppingCartController.getShoppingCartSecondCall();
          shoppingCartController.deleteShoppingCart();
        },
        buttonRegisterTitle: 'Cadastre sua empresa',
      ),
    );
  }
}
