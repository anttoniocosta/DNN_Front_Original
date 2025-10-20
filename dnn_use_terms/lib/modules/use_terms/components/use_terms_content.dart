import 'package:dnn_dependencies/get_export.dart';
import 'package:dnn_shared/dnn_shared.dart';
import 'package:dnn_use_terms/dnn_use_terms.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';

class UseTermsContent extends StatelessWidget {
  const UseTermsContent({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<UseTermsController>(
      builder: (_) {
        if (_.isLoading.value) {
          return const PageLoadingWidget();
        }
        if (_.useTermsModel == null) {
          return TryAgainPage(
            message: 'Não foi possível obter os dados do Termos de Uso',
            onTryAgain: () async => await _.getUseTerms(),
          );
        }
        return Column(
          children: [
            HtmlWidget(
              useTermsController.useTermsModel!.content!,
              textStyle: Fonts.bodyMedium(context),
            ),
          ],
        ).paddingOnly(top: 6, bottom: 20);
      },
    );
  }
}
