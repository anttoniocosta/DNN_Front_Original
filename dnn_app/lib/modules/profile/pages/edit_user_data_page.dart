import 'package:dnn_app/modules/modules.dart';

import 'package:dnn_dependencies/get_export.dart';
import 'package:flutter/material.dart';

class EditUserDataPage extends StatefulWidget {
  const EditUserDataPage({super.key});

  @override
  State<EditUserDataPage> createState() => _EditUserDataPageState();
}

class _EditUserDataPageState extends State<EditUserDataPage> {
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
                10.heightGap,
                CPFInput(
                  controller: updateAccountController.document,
                  isEnabled: updateAccountController.user?.document?.isEmpty,
                ),
                RGInput(
                  controller: updateAccountController.registrationID,
                  isEnabled: true,
                ),
                NameInput(controller: updateAccountController.name),
                DateInput(
                  label: 'Data de nascimento',
                  controller: updateAccountController.birthDay,
                ),
                GenderDropdownMenu(
                  controller: updateAccountController.gender,
                  isEnabled: true,
                ),
                10.heightGap,
                MaritalStatusDropdownMenu(
                  controller: updateAccountController.maritalStatus,
                  isEnabled: true,
                ),
                10.heightGap,
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
                Text('Seu endereço', style: Fonts.titleLarge(context)),
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

  const ColorfulText(
      {super.key, required this.text, required this.color, this.isBold});

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
