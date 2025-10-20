import 'package:dnn_authentication/dnn_authentication.dart';
import 'package:dnn_dependencies/get_export.dart';
import 'package:dnn_shared/dnn_shared.dart';
import 'package:flutter/material.dart';

class PersonInfosForProviderPage extends StatefulWidget {
  const PersonInfosForProviderPage({super.key});

  @override
  State<PersonInfosForProviderPage> createState() => _EditUserDataPageState();
}

class _EditUserDataPageState extends State<PersonInfosForProviderPage> {
  final _formKey = GlobalKey<FormState>();
  final _cpfKey = GlobalKey<FormState>();
  final _zipcodeKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    providersController.setDataToUpdate();
  }

  @override
  void dispose() {
    providersController.clear();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvoked: (val) async {
        CustomDialogs.confirmDialog(
          title:
              'Precisamos completar as sua informações de cadastro para continuar utilizando os serviços, deseja realmente sair?',
          backAcion: () => Get.back(),
          confirmAcion: () async {
            await authenticationController.signOut(() {
              navigationController.setIndex(NavigationTabs.home);
              navigationController.getUserLogged();
              Get.offAllNamed(Routes.basePage);
            });
          },
          context: context,
          backVisible: true,
        );
      },
      child: MobileLayout(
        needCenter: false,
        needScrollView: true,
        maxWidth: Responsive.maxWidth(),
        hasLeading: true,
        appBarLeading: const SizedBox(),
        title: 'Mais informações',
        bodyChild: GetBuilder<ProvidersController>(
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
                  Form(
                    key: _cpfKey,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Expanded(
                          flex: 3,
                          child: CPFInput(
                            controller: providersController.document,
                            isEnabled:
                                providersController.document.text.isEmpty,
                          ),
                        ),
                        if (providersController.document.text.isEmpty) ...[
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
                        ]
                      ],
                    ),
                  ),
                  RGInput(
                    controller: providersController.registration,
                    isEnabled: true,
                  ),
                  NameInput(controller: providersController.name),
                  DateInput(
                    label: 'Data de nascimento',
                    controller: providersController.birthDay,
                  ),
                  GenderDropdownMenu(
                    controller: providersController.gender,
                    isEnabled: true,
                  ),
                  10.heightGap,
                  MaritalStatusDropdownMenu(
                    controller: providersController.maritalStatus,
                    isEnabled: true,
                  ),
                  10.heightGap,
                  PhoneInput(controller: providersController.phone),
                  EmailInput(controller: providersController.email),
                  StandartTextField(
                    labelText: 'Chave PIX',
                    controller: providersController.pixKey,
                    keyboardType: TextInputType.text,
                    hintText: 'Sua chave pix aqui',
                    maxLines: 1,
                  ),
                  const Divider(),
                  10.heightGap,
                  Text('Seu endereço', style: Fonts.titleLarge(context)),
                  10.heightGap,
                  Form(
                    key: _zipcodeKey,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Expanded(
                          flex: 3,
                          child: CEPInput(
                            controller: providersController.zipCode,
                          ),
                        ),
                        const SizedBox(width: 10),
                        SearchButton(
                          onTap: () {
                            FocusScope.of(context).unfocus();
                            if (_zipcodeKey.currentState!.validate()) {
                              providersController.getUserAddressByCep(
                                  providersController.zipCode.text);
                            }
                          },
                        ),
                      ],
                    ),
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        flex: 3,
                        child: StreetInput(
                          controller: providersController.address,
                        ),
                      ),
                      10.widthGap,
                      Expanded(
                        flex: 2,
                        child: NumberInput(
                          controller: providersController.number,
                        ),
                      )
                    ],
                  ),
                  ComplementInput(controller: providersController.complement),
                  NeighborhoodInput(
                    controller: providersController.neighborhood,
                  ),
                  CityInput(controller: providersController.city),
                  StateInput(controller: providersController.state),
                  12.heightGap,
                  GetBuilder<UpdateAccountController>(builder: (_) {
                    return PrimaryButtonWidget(
                      isLoading: updateAccountController.isLoading.value,
                      titleButtom: 'Salvar',
                      onTap: () async {
                        if (_formKey.currentState!.validate()) {
                          await updateAccountController.updateAccount(
                              updatingFromProvider: true);
                          wsServices.start();
                        }
                      },
                    );
                  }),
                  12.heightGap,
                  SecondaryButtonWidget(
                    titleButtom: 'Voltar ao início',
                    onTap: () async {
                      CustomDialogs.confirmDialog(
                        title:
                            'Precisamos completar as sua informações de cadastro para continuar utilizando os serviços, deseja realmente sair?',
                        backAcion: () => Get.back(),
                        confirmAcion: () async {
                          await authenticationController.signOut(() {
                            navigationController.setIndex(NavigationTabs.home);
                            navigationController.getUserLogged();
                            Get.offAllNamed(Routes.basePage);
                          });
                        },
                        context: context,
                        backVisible: true,
                      );
                    },
                  ),
                  22.heightGap,
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
