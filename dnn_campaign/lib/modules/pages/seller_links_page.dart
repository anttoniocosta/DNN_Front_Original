import 'package:dnn_campaign/dnn_campaign.dart';
import 'package:dnn_dependencies/get_export.dart';
import 'package:dnn_shared/dnn_shared.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class SellerLinksPage extends StatelessWidget {
  const SellerLinksPage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SellerLinkController>(
      builder: (_) {
        return MobileLayout(
          needCenter: _.isLoading.value,
          needScrollView: true,
          title: 'Links',
          maxWidth: Responsive.maxWidth(),
          bodyChild: GetBuilder<SellerLinkController>(
            builder: (_) {
              if (_.isLoading.value) {
                return const PageLoadingWidget();
              }

              if (_.sellerLinks.isEmpty) {
                return TryAgainPage(
                  message: 'Aparentemente você não possui links de vendas',
                  onTryAgain: () async => await _.getSellerLinks(),
                );
              }
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                      'Aqui estão os links dos produtos que você pode compartilhar. Ao utilizarem esses links, você como vendedor estará proporcionando a oportunidade para que os seus clientes adquiram Planos para cuidarem da saúde deles e/ou dos familiares.',
                      style: Fonts.bodyLarge(context)),
                  20.heightGap,
                  ..._.sellerLinks.map(
                    (e) => Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(e.name!, style: Fonts.titleLarge(context)),
                        10.heightGap,
                        CopyToClipboardWidget(textToClip: e.url!)
                      ],
                    ).paddingOnly(bottom: 16),
                  )
                ],
              );
            },
          ),
        );
      },
    );
  }
}
