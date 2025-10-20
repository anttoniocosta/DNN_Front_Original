import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:dnn_shared/dnn_shared.dart';

class PDFDetailsPage extends StatefulWidget {
  const PDFDetailsPage({super.key, this.path});

  final String? path;

  @override
  State<PDFDetailsPage> createState() => _PDFDetailsPageState();
}

class _PDFDetailsPageState extends State<PDFDetailsPage> {
  final Completer<PDFViewController> _controller =
      Completer<PDFViewController>();
  int? pages = 0;
  int? currentPage = 0;
  bool isReady = false;
  String errorMessage = '';

  @override
  Widget build(BuildContext context) {
    return MobileLayout(
      needCenter: false,
      needScrollView: false,
      maxWidth: Responsive.maxWidth(),
      needPadding: false,
      title: 'Visualização do PDF',
      bodyChild: Stack(
        children: <Widget>[
          PDFView(
            filePath: widget.path,
            enableSwipe: false,
            swipeHorizontal: true,
            autoSpacing: false,
            pageFling: true,
            pageSnap: true,
            defaultPage: currentPage!,
            preventLinkNavigation: false,
            onRender: (pages) {
              setState(() {
                pages = pages;
                isReady = true;
              });
            },
            onError: (error) {
              setState(() {
                errorMessage = error.toString();
              });
            },
            onPageError: (page, error) {
              setState(() {
                errorMessage = '$page: ${error.toString()}';
              });
            },
            onViewCreated: (PDFViewController pdfViewController) {
              _controller.complete(pdfViewController);
            },
            onLinkHandler: (String? uri) {},
            onPageChanged: (int? page, int? total) {
              setState(() {
                currentPage = page;
              });
            },
          ),
          errorMessage.isEmpty
              ? !isReady
                  ? const Center(child: CircularProgressIndicator())
                  : Container()
              : Center(child: Text(errorMessage))
        ],
      ),
      floatingAction: pages! > 1
          ? FutureBuilder<PDFViewController>(
              future: _controller.future,
              builder: (context, AsyncSnapshot<PDFViewController> snapshot) {
                if (snapshot.hasData) {
                  return FloatingActionButton.extended(
                    label: Text("Go to ${pages! ~/ 2}"),
                    onPressed: () async {
                      await snapshot.data!.setPage(pages! ~/ 2);
                    },
                  );
                }
                return Container();
              },
            )
          : null,
    );
  }
}
