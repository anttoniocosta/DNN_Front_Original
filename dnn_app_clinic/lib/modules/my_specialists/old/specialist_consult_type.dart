import 'package:dnn_dependencies/get_export.dart';
import 'package:dnn_shared/dnn_shared.dart';
import 'package:flutter/material.dart';

class SpecialistConsultTypePage extends StatefulWidget {
  const SpecialistConsultTypePage({super.key});

  @override
  State<SpecialistConsultTypePage> createState() =>
      _SpecialistConsultTypePageState();
}

class _SpecialistConsultTypePageState extends State<SpecialistConsultTypePage> {
  List<String> types = ["Presencial", "Online"];
  List<String> typesSelected = [];

  setType(String type) {
    setState(() {
      if (typesSelected.contains(type)) {
        typesSelected.remove(type);
      } else {
        typesSelected.add(type);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return MobileLayout(
      needCenter: false,
      needScrollView: true,
      title: 'Meus especialistas',
      maxWidth: Responsive.maxWidth(),
      bodyChild: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          10.heightGap,
          Text(
            'Quais as formas de atendimento desse especialista?',
            style: Fonts.headlineMedium(context),
          ),
          Text(
            '(selecione mais de uma opção se necessário)',
            style: Fonts.bodyMedium(context),
          ),
          60.heightGap,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              SizedBox(
                width: 106,
                height: 113,
                child: CardTabsHome(
                  isPrincipal: typesSelected.contains(types[0]),
                  title: types[0],
                  icon: FontAwesomeIcons.userDoctor,
                  onTap: () => setType(types[0]),
                ),
              ),
              SizedBox(
                width: 106,
                height: 113,
                child: CardTabsHome(
                  isPrincipal: typesSelected.contains(types[1]),
                  title: types[1],
                  icon: FontAwesomeIcons.laptopMedical,
                  onTap: () => setType(types[1]),
                ),
              ),
            ],
          ),
          24.heightGap,
        ],
      ),
      bottomNavigationBar: BottomConfirmButton(
        onTap: typesSelected.isEmpty
            ? null
            : () => Get.toNamed(Routes.addSpecialistPrice),
        title: 'Continuar',
      ),
    );
  }
}
