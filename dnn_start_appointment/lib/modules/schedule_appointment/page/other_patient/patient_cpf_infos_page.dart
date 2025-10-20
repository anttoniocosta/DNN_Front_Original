import 'package:dnn_dependencies/get_export.dart';
import 'package:dnn_shared/dnn_shared.dart';
import 'package:flutter/material.dart';

class PatientCPFInfoPage extends StatefulWidget {
  const PatientCPFInfoPage({super.key});

  @override
  State<PatientCPFInfoPage> createState() => _PatientCPFInfoPageState();
}

class _PatientCPFInfoPageState extends State<PatientCPFInfoPage> {
  final _cpfKey = GlobalKey<FormState>();
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    providersController.clear();
    super.initState();
  }

  @override
  void dispose() {
    providersController.clear();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MobileLayout(
      needCenter: false,
      needScrollView: true,
      maxWidth: Responsive.maxWidth(),
      title: pagesController.currentPage(PagesEnum.personalInfos)?.name ?? '',
      bodyChild: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const PageHeader(pgEnum: PagesEnum.personalInfos),
          20.heightGap,
          FormPartialPersonalInfo(formKey: _formKey, cpfKey: _cpfKey),
          20.heightGap,
          GetBuilder<AccountController>(
            builder: (_) {
              return PrimaryButtonWidget(
                onTap: () {
                  if (_formKey.currentState!.validate() &&
                      _cpfKey.currentState!.validate()) {
                    Get.toNamed(Routes.schedulePatientZipcode);
                  }
                },
                titleButtom: 'Confirmar',
              );
            },
          ),
          20.heightGap,
        ],
      ),
    );
  }
}
