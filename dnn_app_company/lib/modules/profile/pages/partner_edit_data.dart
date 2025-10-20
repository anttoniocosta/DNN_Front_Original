import 'package:dnn_app_company/modules/modules.dart';
import 'package:dnn_dependencies/get_export.dart';
import 'package:flutter/material.dart';

class PartnerEditDataPage extends StatefulWidget {
  const PartnerEditDataPage({super.key});

  @override
  State<PartnerEditDataPage> createState() => _PartnerEditDataPageState();
}

class _PartnerEditDataPageState extends State<PartnerEditDataPage> {
  final _formKey = GlobalKey<FormState>();
  bool? isProviderSignin = Get.arguments ?? false;
  @override
  void initState() {
    super.initState();
    updateAccountController.setDataToUpdate();
  }

  @override
  void dispose() {
    updateAccountController.clear();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MobileLayout(
      needCenter: false,
      needScrollView: true,
      maxWidth: Responsive.maxWidth(),
      title: pagesController.currentPage(PagesEnum.editUserData)!.name!,
      bodyChild: GetBuilder<UpdateAccountController>(
        builder: (_) {
          return Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // const PageHeader(pgEnum: PagesEnum.editUserData),
                Text(
                  'Atualize as informações da empresa em "Dados da empresa" e "Endereço da empresa". CNPJ não pode ser alterado. Lembre-se de clicar em "Salvar"',
                  style: Fonts.bodyLarge(context),
                ),
                const Divider(),
                Text('Dados da empresa', style: Fonts.titleLarge(context)),
                10.heightGap,
                CNPJInput(
                  controller: updateAccountController.document,
                  isEnabled: updateAccountController.user?.document?.isEmpty,
                ),
                StateSubscriptionInput(
                  controller: updateAccountController.registrationID,
                ),
                NameInput(controller: updateAccountController.name),
                DateInput(
                  label: 'Data criação',
                  controller: updateAccountController.birthDay,
                ),
                PhoneInput(controller: updateAccountController.phone),
                EmailInput(controller: updateAccountController.email),
                StandartTextField(
                  labelText: 'Chave PIX',
                  controller: updateAccountController.pixKey,
                  keyboardType: TextInputType.text,
                  hintText: 'Sua chave pix aqui',
                  maxLines: 1,
                ),
                const Divider(),
                10.heightGap,
                Text('Endereço da empresa', style: Fonts.titleLarge(context)),
                10.heightGap,
                CEPInput(controller: updateAccountController.zipcode),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      flex: 3,
                      child: StreetInput(
                        controller: updateAccountController.address,
                      ),
                    ),
                    10.widthGap,
                    Expanded(
                      flex: 2,
                      child: NumberInput(
                        controller: updateAccountController.number,
                      ),
                    )
                  ],
                ),
                ComplementInput(controller: updateAccountController.complement),
                NeighborhoodInput(
                  controller: updateAccountController.neighborhood,
                ),
                CityInput(controller: updateAccountController.city),
                StateInput(controller: updateAccountController.state),
                12.heightGap,
                PrimaryButtonWidget(
                  isLoading: updateAccountController.isLoading.value,
                  titleButtom: 'Salvar',
                  onTap: () async {
                    if (_formKey.currentState!.validate()) {
                      await updateAccountController.updateAccount();
                    }
                  },
                ),
                22.heightGap,
              ],
            ),
          );
        },
      ),
    );
  }
}
