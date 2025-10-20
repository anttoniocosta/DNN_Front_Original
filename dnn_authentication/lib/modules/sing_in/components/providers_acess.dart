import 'dart:io';

import 'package:dnn_authentication/dnn_authentication.dart';
import 'package:dnn_shared/dnn_shared.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

class ProvidersAcess extends StatelessWidget {
  const ProvidersAcess({
    super.key,
    required this.acessWithProviders,
    required this.signInAction,
  });

  final bool acessWithProviders;
  final VoidCallback signInAction;

  @override
  Widget build(BuildContext context) {
    if (kIsWeb) return const SizedBox();
    return Visibility(
      visible: acessWithProviders,
      child: Column(
        children: [
          Text(
            'Ou',
            style: Fonts.titleSmall(context),
          ).toCenter,
          10.heightGap,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                child: LoginButton(
                  label: "Login Google",
                  assetName: MediaRes.googleLogo,
                  onPressed: () async =>
                      authenticationController.signInWithGoogle(signInAction),
                ).toCenter,
              ),
              Visibility(
                visible: Platform.isIOS,
                child: Flexible(
                  child: LoginButton(
                    label: "Login Apple",
                    assetName: MediaRes.appleLogo,
                    onPressed: () async =>
                        authenticationController.signInWithApple(signInAction),
                  ).toCenter,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
