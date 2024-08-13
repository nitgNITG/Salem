import 'package:al_mariey/app/core/extensions_and_so_on/extesions.dart';
import 'package:al_mariey/app/modules/open_pdf/open_pdf_controller.dart';
import 'package:al_mariey/app/widgets/app_bars.dart';
import 'package:al_mariey/app/widgets/messages.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

import '../../utils/helper_funcs.dart';

// import 'package:flutter_cached_pdfview/flutter_cached_pdfview.dart';
class OpenPdfPage extends StatefulWidget {
  const OpenPdfPage({super.key, required this.fileUrl, required this.title});

  final String fileUrl;
  final String title;
  @override
  State<OpenPdfPage> createState() => _OpenPdfPageState();
}

class _OpenPdfPageState extends State<OpenPdfPage> {
  late PdfViewerController _pdfViewerController;
  late final OpenPdfController controller;

  @override
  void initState() {
    controller = OpenPdfController();

    _pdfViewerController = PdfViewerController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SizedBox(
            height: getScreenSize(context).height,
            width: getScreenWidth(context),
            child: Column(
              children: [
                NormalAppBar(title: widget.title),
                Stack(
                  children: [
                    SizedBox(
                      height: getScreenHeight(context) -
                          kToolbarHeight -
                          (MediaQuery.paddingOf(context).top),
                      child: SfPdfViewer.network(
                          // 'https://manpoweracademy.nitg-eg.com/webservice/pluginfile.php/185/mod_resource/content/1/%D8%B5%D9%8A%D8%A7%D9%86%D8%A9%20%D8%A7%D9%84%D9%85%D8%AD%D9%88%D9%84%20%201.pdf?forcedownload=1&token=2793d897f0933d310b9c3b72abfd3082',
                          widget.fileUrl, onDocumentLoadFailed: (err) {
                        showSnackBar(context, err.description);
                      }, controller: _pdfViewerController),
                    ),
                    /*           FutureBuilder<File>(
                      future: controller.downloadFile(
                          Uri.encodeFull(
                              'https://cdn.syncfusion.com/content/PDFViewer/flutter-succinctly.pdf'),
                          // Uri.encodeFull(widget.fileUrl),
                          'flutter-succinctly.pdf'),
                      builder:
                          (BuildContext context, AsyncSnapshot<File> snapshot) {
                        if (snapshot.connectionState == ConnectionState.done) {
                          if (snapshot.data != null) {
                            return SizedBox(
                                height: getScreenHeight(context) * 0.8,
                                child: SfPdfViewer.file(
                                  snapshot.data!,
                                  onDocumentLoadFailed: (error) {
                                    showSnackBar(context,
                                        error.description + " " + error.error);
                                  },
                                ));
                          }
                          return TryAgainErrorWidget(onclickTryAgain: () {});
                        } else if (snapshot.connectionState ==
                            ConnectionState.none) {
                          return Text('Press button to start.');
                        } else {
                          return CircularProgressIndicator();
                        }
                      },
                    ),*/
                    Positioned(
                        bottom: 3,
                        child: SizedBox(
                          width: getScreenSize(context).width,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                margin: const EdgeInsets.all(8),
                                color: Colors.black12,
                                child: const Icon(
                                  Icons.keyboard_arrow_down_outlined,
                                  size: 50,
                                  color: Colors.black87,
                                ).onTap(() {
                                  _pdfViewerController.nextPage();
                                }),
                              ),
                              Container(
                                color: Colors.black12,
                                margin: const EdgeInsets.all(8),
                                child: const Icon(
                                  Icons.keyboard_arrow_up_outlined,
                                  size: 50,
                                  textDirection: TextDirection.ltr,
                                  color: Colors.black87,
                                ).onTap(() {
                                  _pdfViewerController.previousPage();
                                }),
                              ),
                            ],
                          ),
                        ))
                  ],
                ),
              ],
            )));
  }
}
