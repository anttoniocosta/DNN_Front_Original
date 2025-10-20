import 'package:dnn_app_clinic/core/clinic/controller/clinic_account_controller.dart';
import 'package:dnn_dependencies/get_export.dart';
import 'package:dnn_shared/dnn_shared.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class ClinicDataInfoPage extends StatefulWidget {
  const ClinicDataInfoPage({super.key});

  @override
  State<ClinicDataInfoPage> createState() => _ClinicDataInfoPageState();
}

class _ClinicDataInfoPageState extends State<ClinicDataInfoPage> {
  final _cpfKey = GlobalKey<FormState>();
  final _formKey = GlobalKey<FormState>();

  final clinicController = Get.find<ClinicAccountController>();

  @override
  void initState() {
    clinicController.clear();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MobileLayout(
      needCenter: false,
      needScrollView: true,
      maxWidth: Responsive.maxWidth(),
      title: 'Dados da clínica',
      bodyChild: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Informe os dados da clínica solicitados abaixo.',
            style: Fonts.bodyLarge(context),
          ),
          20.heightGap,
          Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
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
                  label: 'Nome da clínica',
                  hint: 'Nome da clínica',
                ),
                StateSubscriptionInput(
                  controller: providersController.registration,
                ),
                DateInput(
                  label: 'Data de criação',
                  controller: providersController.birthDay,
                ),
                EmailInput(
                  controller: providersController.email,
                ),
                Text(
                  'Escolha a senha para acesso',
                  style: Fonts.titleSmall(context),
                ).paddingSymmetric(vertical: 10),
                GetBuilder<ClinicAccountController>(
                  builder: (_) {
                    return PasswordInput(controller: _.passwordCtrl);
                  },
                ),
                20.heightGap,
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    GetBuilder<ClinicAccountController>(
                      builder: (_) {
                        return SizedBox(
                          height: 24,
                          width: 24,
                          child: Transform.scale(
                            scale: 1.3,
                            child: Checkbox.adaptive(
                              activeColor: AppColors.blueColor,
                              value: _.hasScreening,
                              onChanged: (val) => _.setHasScreening(val!),
                              semanticLabel: 'A clínica fará triagens?',
                            ),
                          ),
                        );
                      },
                    ),
                    20.widthGap,
                    Expanded(
                      child: Text(
                        'A clínica fará triagens?',
                        style: Fonts.titleMedium(context),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          30.heightGap,
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
          30.heightGap,
        ],
      ),
    );
  }
}
