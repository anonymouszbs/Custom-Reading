import 'dart:async';
import 'package:ceshi1/untils/getx_untils.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';

import '../../../public/public_class_bean.dart';
import '../../../public/public_function.dart';

class DocumentPdf extends StatefulWidget {
  const DocumentPdf({Key? key}) : super(key: key);

  @override
  State<DocumentPdf> createState() => _DocumentPdfState();
}

class _DocumentPdfState extends State<DocumentPdf> with WidgetsBindingObserver {
  final Completer<PDFViewController> _controller =
      Completer<PDFViewController>();
  var path;
  @override
  void initState() {
    // TODO: implement initState
    path = currentGetArguments();
    print(currentGetArguments());
    super.initState();
  }

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
        title: Text(path["FileName"]),
       
      ),
      backgroundColor: Colors.red,
      body: Stack(
        children: <Widget>[
          PDFView(
            filePath: path[
              "FilePath"
            ],
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
              double progress = double.tryParse(((page!/(total!-1))*100).toStringAsFixed(2))!;
print(progress);
             saveprogress(progress, path["id"], page);
              
              setState(() {
                currentPage = page;
              });
            },
          ),
          errorMessage.isEmpty
              ? !isReady
                  ? Center(
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
      ),
    );
  }
}
