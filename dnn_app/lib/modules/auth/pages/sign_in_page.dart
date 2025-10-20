import 'package:dnn_app/modules/modules.dart';
import 'package:flutter/material.dart';

class SigninPage extends StatefulWidget {
  final bool showAppBar;
  const SigninPage({super.key, this.showAppBar = true});

  @override
  State<SigninPage> createState() => _SigninPageState();
}

class _SigninPageState extends State<SigninPage> {
  @override
  Widget build(BuildContext context) {
    return MobileLayout(
      needCenter: false,
      needScrollView: true,
      title: 'Entrar',
      hasLeading: true,
      maxWidth: Responsive.maxWidth(),
      appBarLeading: const MenuButtom(),
      needAppBar: widget.showAppBar,
      drawer: const DrawerCustom(navbarItems: NaviItems()),
      bodyChild: SignInPartial(
        acessWithProviders: true,
        signInAction: () async {
          offersController.getOffers();
          navigationController.navigatePageView(NavigationTabs.home);
          wsServices.start();
          ShoppingCartBinding().dependencies();
          await shoppingCartController.getShoppingCartSecondCall();
          shoppingCartController.deleteShoppingCart();
        },
        buttonRegisterTitle: 'Criar conta',
      ),
    );
  }
}
