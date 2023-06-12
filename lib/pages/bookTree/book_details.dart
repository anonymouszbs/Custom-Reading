import 'dart:io';

import 'package:bot_toast/bot_toast.dart';
import 'package:ceshi1/common/commpents/reader/contants/floatcontroller.dart';
import 'package:ceshi1/common/commpents/reader/contants/theme.dart';
import 'package:ceshi1/common/commpents/reader/routers.dart/reader_page_id.dart';
import 'package:ceshi1/common/network/download.dart';
import 'package:ceshi1/pages/bookTree/controller/audioController.dart';
import 'package:ceshi1/pages/bookTree/controller/detailscontroller.dart';
import 'package:ceshi1/pages/bookTree/routers/booktree_page_id.dart';
import 'package:ceshi1/pages/home/routers/home_page_id.dart';
import 'package:ceshi1/public/public_class_bean.dart';
import 'package:ceshi1/untils/getx_untils.dart';
import 'package:ceshi1/untils/utils_tool.dart';
import 'package:ceshi1/widgets/animation/stepwidget.dart';
import 'package:ceshi1/widgets/public/pub_bg.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/state_manager.dart';

import '../../public/public_function.dart';
import 'audio/audio.dart';

class BookDetailsPage extends StatefulWidget {
  const BookDetailsPage({super.key});

  @override
  State<BookDetailsPage> createState() => _BookDetailsPageState();
}

class _BookDetailsPageState extends State<BookDetailsPage> {
  var bookid;

  bool isshow = false;
  String images = "";
  @override
  void initState() {
    // TODO: implement initState

    bookid = DetailsController.current.bookid.value;
    images = DetailsController.current.bookImage.value;
    on();

    super.initState();
  }

  on() {
    double step = 0.0;

    DetailsController.current.id = bookid;

    DetailsController.current.bookinfoData.value = getBookInfoidMap(id: bookid);

    print(bookid.toString());
    DetailsController.current.bookDownloadList.value =
        getBookDownloadList(id: bookid);

    DetailsController.current.bookDownloadList.map((e) {
      SourceMap sourceMap = getsourceidMap(id: e["id"]);
      step = step + sourceMap.progress;
    }).toList();
    DetailsController.current.progress.value =
        (step ~/ DetailsController.current.bookDownloadList.length).toInt();
    saveBookInfo(
        id: DetailsController.current.bookDownloadList[0]["ietm_id"],
        map: {"LearningRate": DetailsController.current.progress.value});
    FloatController.current.booknmae.value =
        DetailsController.current.bookinfoData.value.ietmName!;
  }

  onbook(index) {
    final type =
        DetailsController.current.bookDownloadList[index]["ResourceType"];
    print(type);
    switch (type) {
      case "mp3" || "MP3":
        BotToast.cleanAll();
        imagestep(
            id: DetailsController.current.bookDownloadList[index]['id'],
            onremove: () {
              AudioCtroller.current.start(
                  id: DetailsController.current.bookDownloadList[index]['id'],
                  path: DetailsController.current.bookDownloadList[index]
                      ['FilePath']);
            },
            child: Image.network(
              images,
              fit: BoxFit.cover,
            ),
            start: const Offset(0, 0),
            end: Offset(
                (ScreenUtil().screenWidth - ScreenUtil().setWidth(242)) / 2,
                (ScreenUtil().screenHeight - ScreenUtil().setHeight(450)) / 2));
        break;
      case "epub" || "EPUB":
        var filename =
            File(DetailsController.current.bookDownloadList[index]["FilePath"])
                .path
                .split('/')
                .last;
        UtilsToll().copyFiles(
            sourcePath: DetailsController.current.bookDownloadList[index]
                ["FilePath"],
            destinationPath: DonwloadSource.current.sourcePath);
        currentToPage(ReaderPageId.reader, arguments: [
          filename,
          DetailsController.current.bookDownloadList[index]
        ]);
        break;
      case "MP4" || "mp4":
        BotToast.showText(text: "text");
        currentToPage(BookTreePageId.video,
            arguments: DetailsController.current.bookDownloadList[index]);
        break;
      case "pdf" || "PDF":
        BotToast.showText(text: "text");
        currentToPage(BookTreePageId.documentpdf,
            arguments: DetailsController.current.bookDownloadList[index]);
        break;
      default:
    }
  }

  Widget textDL({str, color, fontsize}) {
    return ShaderMask(
      blendMode: BlendMode.srcIn,
      shaderCallback: (Rect bounds) {
        return LinearGradient(
          colors: color,
          stops: const [0.0, 1.0],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          tileMode: TileMode.clamp,
        ).createShader(bounds);
      },
      child: Text(str,
          textAlign: TextAlign.left,
          style: TextStyle(
            fontSize: fontsize,
          )),
    );
  }

  dgmentStr(str) {
    switch (str) {
      case "doc":
        return "doc";
      case "docx":
        return "docx";
      case "mp3":
        return "MP3";
      case "mp4":
        return "MP4";
      case "epub":
        return "电子书";
      case "pdf":
        return "PDF";
      default:
        return str;
    }
  }

  itemSize(size) {
    return "${size * 1024}MB";
  }

  dgmentFile({filepath, filetype}) {
    switch (filetype) {
      case "mp3":
        break;
      case "mp4":
        break;
      default:
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () async {
          return false;
        },
        child: Scaffold(
            // floatingActionButton: FloatingActionButton(onPressed: () {

            //  on();
            // },child: Icon(Icons.refresh),),
            body: Stack(
          children: [
            Pub_Bg(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Container(
                    width: ScreenUtil().setWidth(456),
                    height: ScreenUtil().setHeight(876),
                    decoration: const BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage(
                              "assets/img/book_details_bg.png",
                            ),
                            fit: BoxFit.fitHeight)),
                    child: Stack(
                      alignment: Alignment.topCenter,
                      children: [
                        Positioned(
                          top: ScreenUtil().setHeight(32),
                          left: ScreenUtil().setWidth(106),
                          child: SizedBox(
                            width: ScreenUtil().setWidth(242),
                            height: ScreenUtil().setHeight(282),
                            child: Image.network(
                              images,
                              fit: BoxFit.fitHeight,
                            ),
                          ),
                        ),
                        Positioned(
                          top: ScreenUtil().setHeight(343),
                          child: Container(
                            alignment: Alignment.center,
                            width: ScreenUtil().setWidth(360),
                            //height: ScreenUtil().setHeight(100),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                textDL(
                                    str:
                                        "《${DetailsController.current.bookinfoData.value.ietmName}》",
                                    fontsize: ScreenUtil().setSp(28),
                                    color: [
                                      Color(0xffFFFFFF),
                                      Color(0xffA5A5A5)
                                    ]),
                                textDL(
                                    str:
                                        "作者:${DetailsController.current.bookinfoData.value.userNick}",
                                    fontsize: ScreenUtil().setSp(18),
                                    color: [
                                      Color.fromRGBO(255, 255, 255, 0.5),
                                      Color.fromRGBO(255, 255, 255, 0.5),
                                    ]),
                                SizedBox(
                                  height: ScreenUtil().setHeight(5),
                                ),
                                textDL(
                                    str:
                                        "教材类型：${DetailsController.current.bookinfoData.value.parentnodeid}",
                                    fontsize: ScreenUtil().setSp(18),
                                    color: [
                                      Color.fromRGBO(255, 255, 255, 0.5),
                                      Color.fromRGBO(255, 255, 255, 0.5),
                                    ]),
                                SizedBox(
                                  height: ScreenUtil().setHeight(5),
                                ),
                                textDL(
                                    str:
                                        "时间：${DetailsController.current.bookinfoData.value.createTime.toString()}",
                                    fontsize: ScreenUtil().setSp(18),
                                    color: [
                                      Color.fromRGBO(255, 255, 255, 0.5),
                                      Color.fromRGBO(255, 255, 255, 0.5),
                                    ]),
                                SizedBox(
                                  height: ScreenUtil().setHeight(40),
                                ),
                                Container(
                                  width: ScreenUtil().setWidth(222),
                                  height: ScreenUtil().setHeight(82),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.all(
                                          const Radius.circular(8)),
                                      border: Border.all(
                                          width: 1,
                                          color: const Color.fromRGBO(
                                              255, 255, 255, 0.4)),
                                      color: const Color.fromRGBO(
                                          255, 255, 255, 0.12)),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      Obx(() => RichText(
                                          textAlign: TextAlign.center,
                                          text: TextSpan(children: [
                                            TextSpan(
                                                text:
                                                    "${DetailsController.current.progress.value}%\n",
                                                style: TextStyle(
                                                    fontSize:
                                                        ScreenUtil().setSp(28),
                                                    color: Colors.white,
                                                    fontWeight:
                                                        FontWeight.bold)),
                                            TextSpan(
                                                text: "学习进度",
                                                style: TextStyle(
                                                    fontSize:
                                                        ScreenUtil().setSp(18),
                                                    color: const Color.fromRGBO(
                                                        255, 255, 255, 0.5),
                                                    fontWeight:
                                                        FontWeight.bold)),
                                          ]))),
                                      StepWidget(
                                          progress: DetailsController
                                              .current.progress.value
                                              .toInt())
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: ScreenUtil().setHeight(20),
                                ),
                                Container(
                                  alignment: Alignment.topCenter,
                                  width: ScreenUtil().setWidth(462),
                                  height: ScreenUtil().setHeight(280),
                                  child: ListView(
                                    padding: const EdgeInsets.all(0),
                                    children: [
                                      Text(
                                        "\t\t\t\t\t\t\t\t${DetailsController.current.bookinfoData.value.introduction}",
                                        textAlign: TextAlign.left,
                                        style: TextStyle(
                                            color: Colors.grey,
                                            fontSize: ScreenUtil().setSp(18)),
                                      )
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ],
                    )),
                Container(
                  padding: EdgeInsets.only(
                      top: ScreenUtil().setHeight(40),
                      right: ScreenUtil().setWidth(30)),
                  width: ScreenUtil().setWidth(900),
                  // height: ScreenUtil().setHeight(952),
                  child: ListView.separated(
                    itemCount:
                        DetailsController.current.bookDownloadList.length,
                    itemBuilder: (context, index) {
                      return Obx(() => Material(
                          color: Colors.transparent,
                          child: InkWell(
                            onTap: () async {
                              onbook(index);
                              //单机书籍

                              //单机书籍
                              // /storage/emulated/0/Android/data/com.example.ceshi1/files/al_flutter/al_document/e96a06ab184db85ba094ec4781add899.doc
                              //  File file =  File(booksourcesData[index]["FilePath"]);
                              //  List<int> bytes =  file.readAsBytesSync();
                              // var filename =  File(booksourcesData[index]["FilePath"]).path.split('/').last;
                              // print(filename);
                              // UtilsToll().copyFiles(sourcePath: booksourcesData[index]["FilePath"],destinationPath: DonwloadSource.current.sourcePath);

                              // currentToPage(ReaderPageId.reader,arguments: [filename,booksourcesData[index]]  );

                              // print(booksourcesData[index]);
                            },
                            child: Container(
                              decoration: const BoxDecoration(
                                gradient: LinearGradient(
                                  begin: Alignment.bottomCenter,
                                  end: Alignment.topCenter,
                                  colors: [
                                    Color.fromRGBO(255, 255, 255, 0.1),
                                    Color.fromRGBO(255, 255, 255, 0.0)
                                  ],
                                ),
                              ),
                              width: ScreenUtil().setWidth(320),
                              height: ScreenUtil().setHeight(140),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  Expanded(
                                      flex: 4,
                                      child: Text(
                                        "${DetailsController.current.bookDownloadList[index]["FileName"]}",
                                        maxLines: 2,
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: ScreenUtil().setSp(24)),
                                      )),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  Expanded(
                                      flex: 2,
                                      child: Text(
                                          dgmentStr(DetailsController.current
                                                  .bookDownloadList[index]
                                              ["ResourceType"]),
                                          style: TextStyle(
                                              color: Colors.grey,
                                              fontSize:
                                                  ScreenUtil().setSp(20)))),
                                  Expanded(
                                      flex: 2,
                                      child: Text(
                                          int.tryParse(DetailsController.current
                                                          .bookDownloadList[
                                                      index]["Size"]) !=
                                                  null
                                              ? "${(int.tryParse(DetailsController.current.bookDownloadList[index]["Size"])! / (1024 * 1024)).toStringAsFixed(2)}M"
                                              : DetailsController
                                                  .current
                                                  .bookDownloadList[index]
                                                      ["Size"]
                                                  .toString(),
                                          style: TextStyle(
                                              color: Colors.grey,
                                              fontSize:
                                                  ScreenUtil().setSp(20)))),
                                  Expanded(
                                      flex: 2,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          SizedBox(
                                            width: ScreenUtil().setWidth(20),
                                            height: ScreenUtil().setWidth(20),
                                            child: getsourceidMap(
                                                            id: DetailsController
                                                                    .current
                                                                    .bookDownloadList[
                                                                index]["id"])
                                                        .progress ==
                                                    100.00
                                                ? Image.asset(
                                                    "assets/img/complete.png")
                                                : CircularProgressIndicator(
                                                    backgroundColor:
                                                        const Color.fromRGBO(
                                                            102, 102, 102, 1),
                                                    valueColor:
                                                        const AlwaysStoppedAnimation<
                                                                Color>(
                                                            Color.fromRGBO(255,
                                                                207, 97, 1)),
                                                    value: getsourceidMap(
                                                                id: DetailsController
                                                                        .current
                                                                        .bookDownloadList[
                                                                    index]["id"])
                                                            .progress /
                                                        100,
                                                  ),
                                          ),
                                          SizedBox(
                                            width: ScreenUtil().setWidth(10),
                                          ),
                                          Text(
                                              "${getsourceidMap(id: DetailsController.current.bookDownloadList[index]["id"]).progress.toInt()}%",
                                              style: TextStyle(
                                                  color: Colors.grey,
                                                  fontSize:
                                                      ScreenUtil().setSp(20)))
                                        ],
                                      ))
                                ],
                              ),
                            ),
                          )));
                    },
                    separatorBuilder: (BuildContext context, int index) {
                      return Divider(
                        color: Colors.white10,
                        height: ScreenUtil().setHeight(
                          20,
                        ),
                      );
                    },
                  ),
                )
              ],
            ),
            Positioned(
                top: ScreenUtil().setHeight(950),
                left: ScreenUtil().setWidth(34),
                child: SizedBox(
                  height: ScreenUtil().setHeight(45),
                  width: ScreenUtil().setWidth(104),
                  child: Material(
                    color: Colors.transparent,
                    child: InkWell(
                      splashColor: Colors.grey,
                      onTap: () {
                        Get.back();
                      },
                      child: Stack(
                        children: [Image.asset("assets/img/btn_back.png")],
                      ),
                    ),
                  ),
                ))
          ],
        )));
  }
}
