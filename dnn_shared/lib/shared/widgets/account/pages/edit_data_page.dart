import 'package:dnn_dependencies/get_export.dart';

import 'package:dnn_shared/dnn_shared.dart';
import 'package:flutter/material.dart';

class EditDataPage extends StatelessWidget {
  const EditDataPage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AccountController>(
      builder: (_) {
        if (accountController.userAccount!.document!.isCpf) {
          return const _EditUserDataPage();
        } else if (accountController.userAccount!.document!.isCnpj) {
          return const _PartnerEditDataPage();
        } else {
          return const _EditUserDataPage();
        }
      },
    );
  }
}

class _EditUserDataPage extends StatefulWidget {
  const _EditUserDataPage();

  @override
  State<_EditUserDataPage> createState() => __EditUserDataPageState();
}

class __EditUserDataPageState extends State<_EditUserDataPage> {
  final _formKey = GlobalKey<FormState>();
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
                const PageHeader(pgEnum: PagesEnum.editUserData),
                const Divider(),
                Text('Seus dados pessoais', style: Fonts.titleLarge(context)),
                20.heightGap,
                NameInput(controller: updateAccountController.name),
                10.heightGap,
                CPFInput(
                  controller: updateAccountController.document,
                  isEnabled: updateAccountController.user?.document?.isEmpty,
                ),
                10.heightGap,
                RGInput(
                  controller: updateAccountController.registrationID,
                  isEnabled: true,
                ),
                10.heightGap,
                DateInput(
                  label: 'Data de nascimento',
                  controller: updateAccountController.birthDay,
                ),
                10.heightGap,
                GenderDropdownMenu(
                  controller: updateAccountController.gender,
                  isEnabled: true,
                ),
                20.heightGap,
                MaritalStatusDropdownMenu(
                  controller: updateAccountController.maritalStatus,
                  isEnabled: true,
                ),
                20.heightGap,
                PhoneInput(controller: updateAccountController.phone),
                10.heightGap,
                EmailInput(controller: updateAccountController.email),
                10.heightGap,
                StandartTextField(
                  labelText: 'Chave PIX',
                  controller: updateAccountController.pixKey,
                  keyboardType: TextInputType.text,
                  hintText: 'Sua chave pix aqui',
                  maxLines: 1,
                ),
                const Divider(),
                10.heightGap,
                Text('Seu endereço', style: Fonts.titleLarge(context)),
                20.heightGap,
                CEPInput(controller: updateAccountController.zipcode),
                10.heightGap,
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
                10.heightGap,
                ComplementInput(controller: updateAccountController.complement),
                10.heightGap,
                NeighborhoodInput(
                  controller: updateAccountController.neighborhood,
                ),
                10.heightGap,
                CityInput(controller: updateAccountController.city),
                10.heightGap,
                StateInput(controller: updateAccountController.state),
                22.heightGap,
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

class _PartnerEditDataPage extends StatefulWidget {
  const _PartnerEditDataPage();

  @override
  State<_PartnerEditDataPage> createState() => __PartnerEditDataPageState();
}

class __PartnerEditDataPageState extends State<_PartnerEditDataPage> {
  final _formKey = GlobalKey<FormState>();

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

class ColorfulText extends StatelessWidget {
  final String text;
  final Color color;
  final bool? isBold;

  const ColorfulText({
    super.key,
    required this.text,
    required this.color,
    this.isBold = false,
  });

  @override
  Widget build(BuildContext context) {
    final regex = RegExp(r'<color>(.*?)<\/color>');
    final matches = regex.allMatches(text);
    List<String> parts = [];
    int lastMatchedEnd = 0;

    for (var match in matches) {
      parts.add(text.substring(
          lastMatchedEnd, match.start)); // Add text before the match.
      parts.add(text.substring(match.start + '<color>'.length,
          match.end - '</color>'.length)); // Add the matched text.
      lastMatchedEnd = match.end;
    }
    parts.add(text.substring(lastMatchedEnd)); // Add the remaining text.

    final children = <TextSpan>[];
    for (var i = 0; i < parts.length; i++) {
      children.add(
        TextSpan(
          text: parts[i],
          style: Fonts.bodyLarge(context)
              .copyWith(color: i % 2 == 0 ? null : color),
        ),
      );
    }

    return RichText(
      text: TextSpan(
        children: children,
      ),
    );
  }
}
