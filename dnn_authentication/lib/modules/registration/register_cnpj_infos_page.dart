import 'package:dnn_dependencies/get_export.dart';
import 'package:dnn_shared/dnn_shared.dart';
import 'package:flutter/material.dart';

class RegisterCNPJInfoPage extends StatefulWidget {
  const RegisterCNPJInfoPage({super.key});

  @override
  State<RegisterCNPJInfoPage> createState() => _RegisterCNPJInfoPageState();
}

class _RegisterCNPJInfoPageState extends State<RegisterCNPJInfoPage> {
  final _cpfKey = GlobalKey<FormState>();
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    providersController.clear();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MobileLayout(
      needCenter: false,
      needScrollView: true,
      maxWidth: Responsive.maxWidth(),
      title: 'Dados da empresa',
      bodyChild: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Informe os dados da empresa solicitados abaixo.',
            style: Fonts.bodyLarge(context),
          ),
          20.heightGap,
          Form(
            key: _formKey,
            child: Column(
              children: [
                Form(
                  key: _cpfKey,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Expanded(
                        flex: 3,
                        child:
                            CNPJInput(controller: providersController.document),
                      ),
                      10.widthGap,
                      SearchButton(
                        onTap: () {
                          FocusScope.of(context).unfocus();
                          if (_cpfKey.currentState!.validate()) {
                            providersController.getPersonInfosByDocument(
                                providersController.document.text);
                          }
                        },
                      ),
                    ],
                  ),
                ),
                NameInput(
                  controller: providersController.name,
                  label: 'Razão social',
                  hint: 'Razão social da empresa',
                ),
                StateSubscriptionInput(
                  controller: providersController.registration,
                ),
                DateInput(
                  label: 'Data de criação',
                  controller: providersController.birthDay,
                ),
                PhoneInput(controller: providersController.phone),
                EmailInput(controller: providersController.email),
              ],
            ),
          ),
          GetBuilder<AccountController>(
            builder: (_) {
              return PrimaryButtonWidget(
                onTap: () {
                  if (_formKey.currentState!.validate() &&
                      _cpfKey.currentState!.validate()) {
                    providersController.gender.text = 'M';

                    Get.toNamed(Routes.registerZipcode);
                  }
                },
                titleButtom: 'Continuar',
              );
            },
          ),
        ],
      ),
    );
  }
}
