import 'dart:async';
import 'package:ceshi1/untils/getx_untils.dart';
import 'package:ceshi1/untils/utils_tool.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:get/get.dart';

import '../../../public/public_class_bean.dart';
import '../../../public/public_function.dart';
import '../controller/detailscontroller.dart';

class DocumentPdf extends StatefulWidget {
  const DocumentPdf({Key? key}) : super(key: key);

  @override
  State<DocumentPdf> createState() => _DocumentPdfState();
}

class _DocumentPdfState extends State<DocumentPdf> with WidgetsBindingObserver {
  final Completer<PDFViewController> _controller =
      Completer<PDFViewController>();

late AsyncSnapshot<PDFViewController> snapshot;
  var path;

  bool isvertical = true;
  @override
  void initState() {
    // TODO: implement initState

    super.initState();
    if (mounted) {
      UtilsToll.verticalScreen();
      path = currentGetArguments();
    }
    // UtilsToll.verticalScreen();
  }

  @override
  int? pages = 0;
  int? currentPage = 0;
  bool isReady = false;
  String errorMessage = '';
  saveprogress(double progress, id, int duration) {
    SourceMap sourceMap = getsourceidMap(id: id);
    if (sourceMap.progress < progress) {
      saveSource(id: id, map: {"progress": progress, "duration": duration});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(path["FileName"].toString().trim()),
        leading: IconButton(
            onPressed: () {
              if (mounted) {
                UtilsToll.ladnspaceScree();
              }
              DetailsController.current.shuaxin();

              Get.back();
            },
            icon: const Icon(
              Icons.arrow_back,
              color: Colors.white,
            )),
      ),
      backgroundColor: Colors.red,
      body: Stack(
        children: <Widget>[
          PDFView(
            filePath: path["FilePath"],
            enableSwipe: true,
            swipeHorizontal: true,
            autoSpacing: true,
            pageFling: true,
            pageSnap: true,
            defaultPage: currentPage!,
            fitPolicy: FitPolicy.BOTH,
            preventLinkNavigation:
                true, // if set to true the link is handled in flutter
            onRender: (_pages) {
              setState(() {
                pages = _pages;
                isReady = true;
                
          SourceMap sourceMap = getsourceidMap(id: path["id"]);      
          snapshot.data!.setPage(pages! ~/ (sourceMap.progress/100));
                

              });
            },
            onError: (error) {
              setState(() {
                errorMessage = error.toString();
              });
              print(error.toString());
            },
            onPageError: (page, error) {
              setState(() {
                errorMessage = '$page: ${error.toString()}';
              });
              print('$page: ${error.toString()}');
            },
            onViewCreated: (PDFViewController pdfViewController) {
              _controller.complete(pdfViewController);
            },
            onLinkHandler: (String? uri) {
              print('goto uri: $uri');
            },
            onPageChanged: (int? page, int? total) {
              //保存进度
              double progress = double.tryParse(
                  ((page! / (total! - 1)) * 100).toStringAsFixed(2))!;
              print(progress);
              saveprogress(progress, path["id"], page);

              setState(() {
                currentPage = page;
              });
            },
          ),
          errorMessage.isEmpty
              ? !isReady
                  ? const Center(
                      child: CircularProgressIndicator(),
                    )
                  : Container()
              : Center(
                  child: Text(errorMessage),
                )
        ],
      ),
      floatingActionButton: FutureBuilder<PDFViewController>(
        future: _controller.future,
        builder: (context, AsyncSnapshot<PDFViewController> snapshot) {
          this.snapshot = snapshot;
          if (snapshot.hasData) {
            return FloatingActionButton.extended(
              label: Row(
                children: [
                  isvertical ? const Icon(Icons.tablet) : const Icon(Icons.tablet_android),
                  Text(isvertical ? "横屏" : "竖屏")
                ],
              ), //Text("Go to ${pages! ~/ 2}"),
              onPressed: () async {
                // await snapshot.data!.setPage(pages! ~/ 2);

                isvertical
                    ? UtilsToll.ladnspaceScree()
                    : UtilsToll.verticalScreen();
                isvertical = !isvertical;
              },
            );
          }

          return Container();
        },
      ),
    );
  }
}
