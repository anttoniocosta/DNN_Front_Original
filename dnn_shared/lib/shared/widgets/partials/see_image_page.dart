import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../../../dnn_shared.dart';

class SeeImagePage extends StatelessWidget {
  const SeeImagePage({super.key, required this.img, this.isFile = true});
  final String img;
  final bool? isFile;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        surfaceTintColor: Colors.black,
        foregroundColor: Colors.white,
      ),
      body: SafeArea(
        child: Container(
          constraints: BoxConstraints(maxWidth: Responsive.maxWidth()),
          child: FractionallySizedBox(
            widthFactor: 1,
            heightFactor: 0.7,
            child: Hero(tag: img, child: _body()),
          ).toCenter,
        ).toCenter,
      ),
    );
  }

  Widget _body() {
    if (isFile!) {
      return kIsWeb
          ? Image.network(
              (img),
              fit: BoxFit.cover,
              errorBuilder: (context, url, error) => Image.asset(
                MediaRes.blankImg,
                fit: BoxFit.cover,
              ),
            )
          : Image.file(
              File(img),
              fit: BoxFit.cover,
              errorBuilder: (context, url, error) => Image.asset(
                MediaRes.blankImg,
                fit: BoxFit.cover,
              ),
            );
    }
    if (img != MediaRes.blankImg) {
      return CachedNetworkImage(
        imageUrl: img,
        fit: BoxFit.cover,
        errorWidget: (context, url, error) => Image.asset(
          MediaRes.blankImg,
          fit: BoxFit.cover,
        ),
      );
    }
    return Image.asset(
      img,
      fit: BoxFit.cover,
      errorBuilder: (context, url, error) => Image.asset(
        MediaRes.blankImg,
        fit: BoxFit.cover,
      ),
    );
  }
}
