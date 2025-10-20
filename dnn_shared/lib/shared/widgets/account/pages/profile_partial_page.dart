import 'package:dnn_dependencies/get_export.dart';
import 'package:dnn_dependencies/sc_util.dart';
import 'package:dnn_shared/dnn_shared.dart';
import 'package:flutter/material.dart';

enum ProfileType { CNPJ, CPF, CPF_CNPJ }

class ProfilePartialPage extends StatelessWidget {
  const ProfilePartialPage({
    super.key,
    this.profileType,
  });

  final ProfileType? profileType;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AccountController>(
      builder: (_) {
        if (_.isLoadingAccountInfos.value) {
          return const PageLoadingWidget();
        }
        if (_.userAccount == null) {
          return TryAgainPage(
            message: 'Não foi possível obter os detalhes do seu perfil.',
            onTryAgain: () => _.getAccount(),
          );
        } else {
          final user = _.userAccount!;
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              10.heightGap,
              Center(
                child: GestureDetector(
                  onTap: () {
                    Get.to(
                      () => SeeImagePage(
                        img: user.photo ?? MediaRes.blankImg,
                        isFile: false,
                      ),
                      transition: Transition.noTransition,
                    );
                  },
                  child: Hero(
                    tag: user.photo ?? MediaRes.blankImg,
                    child: ProfilePictureWidget(user: user),
                  ),
                ),
              ),
              10.heightGap,
              Center(
                child: Text(
                  user.fullName!.capitalize!,
                  style: Fonts.titleLarge(context),
                  textAlign: TextAlign.center,
                ),
              ),
              Center(
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SvgPicture.asset(MediaRes.location),
                    10.widthGap,
                    Text(
                      '${user.city ?? ""} - ${user.state ?? ""}',
                      style: Fonts.titleSmall(context),
                    ),
                  ],
                ),
              ),
              10.heightGap,
              _textField('Nome', user.fullName!.capitalize!, context),
              10.heightGap,
              _textField(
                  'Documento', user.document?.formatDocument() ?? "", context),
              10.heightGap,
              _textField('Email', user.email!, context),
              10.heightGap,
              _textField(
                  switch (profileType) {
                    ProfileType.CPF => 'Data de nascimento',
                    ProfileType.CNPJ => 'Data de criação',
                    ProfileType.CPF_CNPJ => 'Data de nascimento/criação',
                    null => 'Data de nascimento'
                  },
                  user.birthday?.formatDate() ?? "",
                  context),
              10.heightGap,
              _textField(
                  'Telefone', user.phoneNumber?.formatPhone() ?? "", context),
              20.heightGap,
              PrimaryButtonWidget(
                titleButtom: 'Editar',
                onTap: () => Get.toNamed(Routes.myEditData),
              ),
              80.h.heightGap,
              const VersionTextWidget().toCenter,
              60.heightGap,
            ],
          );
        }
      },
    );
  }
}

Widget _textField(String title, String value, BuildContext context) {
  return Container(
    padding: AppConstants.contentPadding,
    height: 50,
    width: double.infinity,
    decoration: BoxDecoration(
      border: Border.all(color: AppColors.darkGreyColor),
      borderRadius: BorderRadius.circular(15),
    ),
    child: Row(
      children: [
        Text('$title: ', style: Fonts.titleSmall(context)),
        Text(value, style: Fonts.bodyLarge(context)),
      ],
    ),
  );
}

class ProfileInfosHeaderSection extends StatelessWidget {
  const ProfileInfosHeaderSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Text(
            'Informações pessoais',
            style: Fonts.titleMedium(context),
          ),
        ),
        SizedBox(
          height: 30,
          child: OutlinedButton(
            onPressed: () => Get.toNamed(Routes.myEditData),
            child: Text(
              'Editar',
              style: Fonts.titleSmall(context),
            ),
          ),
        ),
      ],
    );
  }
}
