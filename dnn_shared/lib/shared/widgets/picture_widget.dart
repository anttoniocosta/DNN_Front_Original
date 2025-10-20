import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:transparent_image/transparent_image.dart';

import '../../dnn_shared.dart';

class PictureWidget extends StatelessWidget {
  const PictureWidget({
    super.key,
    this.img,
    required this.size,
    this.radius,
  });

  final ValueNotifier<String>? img;
  final Size size;
  final double? radius;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size.width,
      height: size.height,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(radius ?? 500),
      ),
      child: Padding(
        padding: const EdgeInsets.all(1),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(radius ?? 500),
          child: _pictureWidget(
              img: img ?? ValueNotifier<String>(MediaRes.blankImg)),
        ),
      ),
    );
  }

  Widget _pictureWidget({required ValueNotifier<String> img}) {
    if (kIsWeb) {
      return FadeInImage.memoryNetwork(
        image: img.value,
        width: 50,
        fit: BoxFit.cover,
        placeholder: kTransparentImage,
        imageErrorBuilder: (context, error, stackTrace) {
          return Image.asset(MediaRes.blankImg, width: 50, fit: BoxFit.cover);
        },
        placeholderErrorBuilder: (context, error, stackTrace) {
          return Image.asset(MediaRes.blankImg, width: 50, fit: BoxFit.cover);
        },
      );
    }

    return ValueListenableBuilder<String>(
      valueListenable: img,
      builder: (BuildContext context, String value, child) {
        return CachedNetworkImage(
          imageUrl: value,
          width: 50,
          fit: BoxFit.cover,
          errorWidget: (context, url, error) =>
              Image.asset(MediaRes.blankImg, width: 50, fit: BoxFit.cover),
        );
      },
    );
  }
}
