import 'dart:async';

import 'package:bot_toast/bot_toast.dart';
import 'package:ceshi1/pages/bookTree/routers/booktree_page_id.dart';
import 'package:ceshi1/public/public_function.dart';
import 'package:ceshi1/untils/getx_untils.dart';
import 'package:ceshi1/widgets/public/loading1.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../common/network/download.dart';
import '../../widgets/animation/stepwidget.dart';
import '../../widgets/public/pub_bg.dart';
import 'controller/detailscontroller.dart';

class BookDetailsPreview extends StatelessWidget {
  const BookDetailsPreview({super.key});

  itemSize(size) {
    return "${size * 1024}MB";
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

  dgmentFile({filepath, filetype}) {
    switch (filetype) {
      case "mp3":
        break;
      case "mp4":
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // floatingActionButton: FloatingActionButton(onPressed: () {

        //  on();
        // },child: Icon(Icons.refresh),),
        body: Stack(
      children: [
        const Pub_Bg(),
        Obx(() =>  DetailsController.current.bookFileList.isEmpty
            ? const Loading1()
            : Row(
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
                                DetailsController.current.bookImage.value
                                    .toString(),
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
                                          "《${DetailsController.current.bookinfo["ietm_name"]}》",
                                      fontsize: ScreenUtil().setSp(28),
                                      color: [
                                        Color(0xffFFFFFF),
                                        Color(0xffA5A5A5)
                                      ]),
                                  textDL(
                                      str:
                                          "作者:${DetailsController.current.bookinfo["user_nick"]}",
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
                                          "教材类型：${DetailsController.current.bookinfo["parentnodeid"]}",
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
                                          "时间：${DetailsController.current.bookinfo["CreateTime"]}",
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
                                        TextButton.icon(
                                            onPressed: () {

                                              BotToast.showLoading();
                                              DonwloadSource.current.donwload(
                                                  currentIndex: 0,
                                                  index: DetailsController
                                                      .current.index,
                                                  ietmid: DetailsController
                                                      .current.ietmid);

                                              Timer.periodic(
                                                  Duration(milliseconds: 2000),
                                                  (_timer) {
                                                if (findKey(
                                                        id: getBookDownloadid(
                                                            id: DetailsController
                                                                .current
                                                                .ietmid)) ==
                                                    true) {
                                                      BotToast.cleanAll();
                                                  _timer.cancel();

                                                  Get.offNamed(BookTreePageId.bookdetails);;
                                                }
                                              });
                                            },
                                            icon: Icon(Icons.download),
                                            label: Text("下载"))
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
                                          "\t\t\t\t\t\t\t\t${DetailsController.current.bookinfo["Introduction"]}",
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
                      itemCount: DetailsController.current.bookFileList.length,
                      itemBuilder: (context, index) {
                        return Material(
                            color: Colors.transparent,
                            child: InkWell(
                              onTap: () async {
                                BotToast.showText(text: "请先下载");
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
                                          "${DetailsController.current.bookFileList[index]["FileName"]}",
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
                                            dgmentStr(
                                                "${DetailsController.current.bookFileList[index]["ResourceType"]}"),
                                            style: TextStyle(
                                                color: Colors.grey,
                                                fontSize:
                                                    ScreenUtil().setSp(20)))),
                                    Expanded(
                                        flex: 2,
                                        child: Text(
                                            "${(int.tryParse("${DetailsController.current.bookFileList[index]["Size"]}")! / (1024 * 1024)).toStringAsFixed(2)}M",
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
                                              child:
                                                  const CircularProgressIndicator(
                                                backgroundColor: Color.fromRGBO(
                                                    102, 102, 102, 1),
                                                valueColor:
                                                    AlwaysStoppedAnimation<
                                                            Color>(
                                                        Color.fromRGBO(
                                                            255, 207, 97, 1)),
                                                value: 0,
                                              ),
                                            ),
                                            SizedBox(
                                              width: ScreenUtil().setWidth(10),
                                            ),
                                            Text("0%",
                                                style: TextStyle(
                                                    color: Colors.grey,
                                                    fontSize:
                                                        ScreenUtil().setSp(20)))
                                          ],
                                        ))
                                  ],
                                ),
                              ),
                            ));
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
              )),
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
    ));
  }
}
