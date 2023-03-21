import 'dart:developer';
import 'dart:io';
import 'package:archive/archive.dart';
import 'package:epubx/epubx.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutterdemo1/DisplayConfig.dart';
import 'package:flutterdemo1/analyzer.dart';
import 'package:flutterdemo1/analyzer_html.dart';
import 'package:flutterdemo1/itempage/DisplayPage.dart';
import 'package:flutterdemo1/itempage/pagebreaker.dart';
import 'package:flutterdemo1/itempage/textpainter.dart';
import 'package:path_provider/path_provider.dart';
import 'package:xml/xml.dart';

import 'dart:ui' as ui;
class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  DisplayConfig config = DisplayConfig.getDefault();
  PageController pageController = PageController();
  List<YdPage> page = [];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    ctr();
  }

  ctr() async {
    page = await Ctr().spilit();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final textStyle = TextStyle(
      color: Color(config.textColor),
      fontSize: config.textSize,
      fontWeight: config.isTextBold == 1 ? FontWeight.bold : FontWeight.normal,
      fontFamily: config.fontPath,
      height: config.lineSpace,
    );
    return Scaffold(
        body: Stack(
      children: [
        PageView.builder(
          controller: pageController,
          onPageChanged: (int) {},
          scrollDirection: Axis.horizontal,
          itemBuilder: ((context, index) {
            int realIndex = index * 2;

            return DisPlayPage(1,  page[realIndex], realIndex > page.length - 2 ? null:page[realIndex + 1]);
           
          }),
          itemCount: (page.length / 2).truncate(),
        ),
        Positioned(
          left: 0,
          top: 0,
            child: Container(
             
              alignment: Alignment.centerLeft,
              width: 100,
              height: ScreenUtil().screenHeight,
              child: InkWell(
          onTap: () {
              pageController.previousPage(duration: Duration(milliseconds: 300), curve: Curves.linear);
          },
        ),
            )),
            Positioned(
        
              right: -1,
            child: Container(
              
              alignment: Alignment.centerRight,
              width: 100,
              height: ScreenUtil().screenHeight,
              child: InkWell(
          onTap: () {
              pageController.nextPage(duration: Duration(milliseconds: 300), curve: Curves.linear);
          },
        ),
            ))
      ],
    ));
  }
}

class Ctr {
  DisplayConfig config = DisplayConfig.getDefault();

  ///加载asset资源
  static loadFromAssets(String assetName, String type) async {
    final bytes = await rootBundle.load(assetName);
    switch (type) {
      case "image":
        final image = await decodeImageFromList(bytes.buffer.asUint8List());
        return image;
      case "byte":
        return bytes.buffer.asUint8List();
    }
  }

  spilit() async {
    String bookpath = "img/人为何需要音乐.epub";
    EpubBook epub = await EpubReader.readBook(
        await loadFromAssets(bookpath, "byte")); //读取epub
    String bookUZpath = await gettruepath(
        rootpath: epub.Schema!.ContentDirectoryPath.toString(),
        bookpath: bookpath); //获取解压后的epub真目录
    String content =  epub.Chapters![7].HtmlContent!;
    List<String> image = await getimageList(content,bookUZpath) ;


    print(image);
    content = AnalyzerHtml.getHtmlString(content).replaceAll("\n\n", "\n");
    content = content.replaceAllMapped(RegExp(r'<img\s+[^>]*>'), (match) => "☏");
    
    

    List<YdPage> str = PageBreaker(generateContentTextSpan(content),
            generateTextPageSize(Size(ScreenUtil().screenWidth, ScreenUtil().screenHeight)),image)
        .splitPage();
    log(str.length.toString());
    return str;
  }
///加载本地资源
static loadFromLocal(String path,String type)async{
  final bytes = await File(path).readAsBytes();
  switch (type) {
    case "image":
      final image = await decodeImageFromList(bytes);
      return image;
    case "byte":
      return bytes.buffer.asUint8List();
  }
}
  Future<List<String>> getimageList(content,bookUZpath)async{
      List data = jxxhtml(content);
      List<String> listimage = [];
      for (var i = 0; i < data.length; i++) {
   
          listimage.add(bookUZpath+data[i]);
        }
        return listimage;
  }

  static jxxhtml(content){
    List img = [];
   
  var document = XmlDocument.parse(content);
  var imgTags = document.findAllElements('img');
  
  for (var imgTag in imgTags) {
    final src = imgTag.getAttribute('src');
    if (src != null) {
      img.add(src.replaceAll("..", ""));
    }
  }

  
  return img;
  }
  //计算分页的大小
  Size generateTextPageSize(size) {
    var textPageSize = Size(size.width - config.marginLeft - config.marginRight,
        size.height - config.marginTop - config.marginBottom); //显示区域减去外边距
    if (config.isSinglePage == 1) {
      //单页
      return textPageSize;
    } else {
      //双页
      return Size(
          (textPageSize.width - config.inSizeMargin) / 2, textPageSize.height);
    }
  }

  TextSpan generateContentTextSpan(String chapterContent) {
    final textStyle = TextStyle(
      color: Color(config.textColor),
      fontSize: config.textSize,
      fontWeight: config.isTextBold == 1 ? FontWeight.bold : FontWeight.normal,
      fontFamily: config.fontPath,
      height: config.lineSpace,
    );

    final textSpan = TextSpan(
      text: chapterContent,
      style: textStyle,
    );
    return textSpan;
  }

  gettruepath({required rootpath, bookpath}) async {
    var unzippath = await unZip(bookpath);
    var truepath = rootpath == "" ? unzippath : unzippath + "/" + rootpath;
    log(truepath);
    return truepath;
  }
  //解压获得真实路径

  static unZip(zippath) async {
    final tempDir = await getTemporaryDirectory();
    final extractionPath = Directory('${tempDir.path}/extraction/folder');
    // 如果解压目录不存在，创建它
    if (!extractionPath.existsSync()) {
      extractionPath.createSync(recursive: true);
    }
    // 读取asset中的zip文件
    final bytes = await rootBundle.load(zippath);
    final archive = ZipDecoder().decodeBytes(bytes.buffer.asUint8List());
    for (final file in archive) {
      final filePath = '${extractionPath.path}/${file.name}';
      if (file.isFile) {
        final data = file.content as List<int>;
        File(filePath)
          ..createSync(recursive: true)
          ..writeAsBytesSync(data);
      } else {
        Directory(filePath)..create(recursive: true);
      }
    }
    // 获取解压后的路径
    final extractedFolderPath = extractionPath.path;
    return extractedFolderPath;
  }
}
