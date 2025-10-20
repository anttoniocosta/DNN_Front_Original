import 'package:dnn_core/all_exports.dart';
import 'package:dnn_dependencies/get_export.dart';
import 'package:dnn_shared/dnn_shared.dart';
import 'package:dnn_use_terms/dnn_use_terms.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';

class PayTermsContent extends StatefulWidget {
  const PayTermsContent({super.key});

  @override
  State<PayTermsContent> createState() => _PayTermsContentState();
}

class _PayTermsContentState extends State<PayTermsContent> {
  String payTerm = '';

  @override
  void initState() {
    init();
    super.initState();
  }

  init() async {
    final terms = await storage.getPayTerm();
    if (terms == null) {
      Get.offNamed(Routes.paymentChoice);
    } else {
      payTerm = terms;
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<UseTermsController>(
      builder: (_) {
        if (_.isLoading.value) {
          return const PageLoadingWidget();
        }
        if (_.payTerms == null) {
          return TryAgainPage(
            message: 'Não foi possível obter os dados do Termos de Compra',
            onTryAgain: () async => await _.getUseTerms(),
          );
        }
        return Column(
          children: [
            HtmlWidget(
              _.payTerms!.content!.replaceFirst('@@useterms@@', payTerm),
              textStyle: Fonts.bodyMedium(context),
            ),
          ],
        ).paddingOnly(top: 6, bottom: 20);
      },
    );
  }
}
