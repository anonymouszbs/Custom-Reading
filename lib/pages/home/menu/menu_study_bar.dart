import 'dart:ui';

import 'package:bot_toast/bot_toast.dart';
import 'package:ceshi1/widgets/public/loading1.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../common/network/ApiServices.dart';
import '../../../common/network/download.dart';
import '../../../config/dataconfig/normal_string_config.dart';
import '../../../untils/getx_untils.dart';
import '../../../untils/sp_util.dart';
import '../../../widgets/animation/stepwidget.dart';
import '../../../widgets/public/SliverGridDelegateWithFixedSize.dart';
import '../../../widgets/public/textwidget.dart';
import '../../bookTree/routers/booktree_page_id.dart';

class MenuStudy extends StatefulWidget {
  const MenuStudy({super.key});

  @override
  State<MenuStudy> createState() => _MenuStudyState();
}

class _MenuStudyState extends State<MenuStudy> {
  List toplevelListData = [
    {"id": 25, "lbmc": "学习任务"},
    {"id": 24, "lbmc": "个人书架"},
    {"id": 2, "lbmc": "读书笔记"}
  ];
  late PageController tabpageController = PageController(initialPage: 0);
  late PageController pageController = PageController(initialPage: 0);

  List bookPlanListData = [[], []];
  int currentindex = 0;

  LoaddingState state = LoaddingState.LOADDING;

  @override
  void initState() {
    getBookPlanList(25);
    super.initState();
  }

  getBookPlanList(resourceStateId) async {
    var jsondata =
        await ApiService.getBookPlanShelf(ResourceState: resourceStateId);

    if (jsondata['code'] == 1) {
      setState(() {
        bookPlanListData[currentindex] = jsondata['data'];
        if (bookPlanListData[currentindex].isEmpty) {
          state = LoaddingState.ERROR;
        }
        print(bookPlanListData);
      });
    } else {
      state = LoaddingState.ERROR;
      setState(() {});
    }
  }

  Widget topLovelWidget() {
    return toplevelListData.isEmpty
        ? Container()
        : Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: toplevelListData.asMap().keys.map((e) {
              return Container(
                alignment: Alignment.topLeft,
                width: ScreenUtil().setWidth(270),
                height: ScreenUtil().setHeight(70),
                child: TextButton.icon(
                    style: const ButtonStyle(
                        overlayColor:
                            MaterialStatePropertyAll(Colors.transparent)),
                    onPressed: () {
                      pageController.animateToPage(e,
                          duration: const Duration(milliseconds: 500),
                          curve: Curves.linear);
                      tabpageController.jumpToPage(
                        e,
                      );
                      getBookPlanList(toplevelListData[e]["id"]);
                      setState(() {
                        currentindex = e;
                      });
                    },
                    icon: Image.asset(
                      currentindex == e
                          ? "assets/img/tab_arrow.png"
                          : e == 0
                              ? "assets/img/tab_exam_normal.png"
                              : e == 1
                                  ? "assets/img/collect.png"
                                  : "assets/img/note.png",
                      height: ScreenUtil().setSp(22),
                      fit: BoxFit.cover,
                    ),
                    label: Text(
                      toplevelListData[e]["lbmc"],
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: ScreenUtil().setSp(23)),
                    )),
              );
            }).toList(),
          );
  }

  Widget datalist({data}) {
    return data.isEmpty
        ? Loading1(
            state: state,
          )
        : GridView.builder(
            itemCount: data.length,
            padding: const EdgeInsets.only(top: 0),
            gridDelegate: SliverGridDelegateWithFixedSize(
              ScreenUtil().setWidth(345),
              ScreenUtil().setHeight(240),
              mainAxisSpacing: 5.0,
            ),
            itemBuilder: (c, index) {
              final bookinfosaveid =
                  "${NormalFlagIdConfig.bookInfoId}${data[index]["ietm_id"]}";
              var map;
              bool isexit = false;
              if (SpUtil.containsKey(bookinfosaveid) == true) {
                map = SpUtil.getObject(bookinfosaveid);
                isexit = true;
              }
              return Material(
                  color: Colors.transparent,
                  child: InkWell(
                      onTap: () {
                        if (SpUtil.containsKey(NormalFlagIdConfig.bookDownload +
                                data[index]["ietm_id"].toString()) ==
                            true) {
                          currentToPage(BookTreePageId.bookdetails, arguments: [
                            data[index]["ietm_id"],
                            ApiService.AppUrl + data[index]["Thumbnail"]
                          ]);
                        } else {
                          DonwloadSource.current.donwload(
                              currentIndex: currentindex,
                              index: index,
                              ietmid: data[index]["ietm_id"]);

                          BotToast.showWidget(
                            toastBuilder: (cancelFunc) {
                              return Material(
                                color: const Color.fromRGBO(0, 0, 0, 0.50),
                                child: Stack(
                                  children: [
                                    Positioned(
                                        top: ScreenUtil().setHeight(239),
                                        left: ScreenUtil().setWidth(294),
                                        child: BackdropFilter(
                                          filter: ImageFilter.blur(
                                              sigmaX: 10, sigmaY: 10),
                                          child: Container(
                                            padding: EdgeInsets.only(
                                                left: ScreenUtil().setWidth(56),
                                                top: ScreenUtil().setHeight(35),
                                                right:
                                                    ScreenUtil().setWidth(56)),
                                            width: ScreenUtil().setWidth(778),
                                            height: ScreenUtil().setHeight(546),
                                            decoration: const BoxDecoration(
                                                boxShadow: [
                                                  BoxShadow(
                                                      blurRadius: 32,
                                                      color: Color.fromRGBO(
                                                          255, 255, 255, 0.20))
                                                ],
                                                gradient: LinearGradient(
                                                  begin: Alignment.topCenter,
                                                  end: Alignment.bottomCenter,
                                                  colors: [
                                                    Color.fromRGBO(
                                                        0, 0, 0, 0.05),
                                                    Color.fromRGBO(
                                                        0, 0, 0, 0.22)
                                                  ],
                                                ),
                                                image: DecorationImage(
                                                    colorFilter:
                                                        ColorFilter.mode(
                                                            Color.fromRGBO(255,
                                                                255, 255, 0),
                                                            BlendMode
                                                                .colorBurn),
                                                    image: AssetImage(
                                                      "assets/img/download_bg.png",
                                                    ),
                                                    fit: BoxFit.fill)),
                                            child: Column(
                                              children: [
                                                Row(
                                                  children: [
                                                    GestureDetector(
                                                      onTap: () => cancelFunc(),
                                                      child: SizedBox(
                                                        width: ScreenUtil()
                                                            .setWidth(100),
                                                        height: ScreenUtil()
                                                            .setHeight(40),
                                                        child: Image.asset(
                                                          "assets/img/downlaod_btn_back.png",
                                                          fit: BoxFit.fill,
                                                        ),
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      width: ScreenUtil()
                                                          .setWidth(174),
                                                    ),
                                                    Container(
                                                      alignment:
                                                          Alignment.center,
                                                      child: Text(
                                                        "下载队列",
                                                        style: TextStyle(
                                                            color: Colors.white,
                                                            fontSize:
                                                                ScreenUtil()
                                                                    .setSp(28)),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                SizedBox(
                                                  height: ScreenUtil()
                                                      .setHeight(49),
                                                ),
                                                Expanded(
                                                    child: Obx(
                                                  () => ListView.separated(
                                                    itemCount: DonwloadSource
                                                        .current
                                                        .taskList
                                                        .length,
                                                    itemBuilder:
                                                        (context, index) {
                                                      return Obx(
                                                          () => Container(
                                                                alignment:
                                                                    Alignment
                                                                        .center,
                                                                width: ScreenUtil()
                                                                    .setWidth(
                                                                        666),
                                                                height:
                                                                    ScreenUtil()
                                                                        .setHeight(
                                                                            60),
                                                                child: Column(
                                                                  children: [
                                                                    Row(
                                                                      mainAxisAlignment:
                                                                          MainAxisAlignment
                                                                              .spaceBetween,
                                                                      children: [
                                                                        SizedBox(
                                                                            width:
                                                                                ScreenUtil().setWidth(250),
                                                                            child: Text(
                                                                              DonwloadSource.current.taskList[index]["ietm_name"],
                                                                              maxLines: 1,
                                                                              style: TextStyle(
                                                                                  color: const Color.fromRGBO(
                                                                                    255,
                                                                                    255,
                                                                                    255,
                                                                                    1,
                                                                                  ),
                                                                                  fontSize: ScreenUtil().setSp(20)),
                                                                            )),
                                                                        SizedBox(
                                                                          width:
                                                                              ScreenUtil().setWidth(180),
                                                                          child: Obx(() =>
                                                                              Text(
                                                                                "${(DonwloadSource.current.taskList[index]["progress"] * 100)}%",
                                                                                style: TextStyle(color: Colors.grey, fontSize: ScreenUtil().setSp(18)),
                                                                              )),
                                                                        ),
                                                                        Row(
                                                                          children: [
                                                                            Text(
                                                                              DonwloadSource.current.taskList[index]["isdownload"] == true
                                                                                  ? "已完成"
                                                                                  : DonwloadSource.current.taskList[index]["ispause"] == true
                                                                                      ? "已暂停"
                                                                                      : "正在下载",
                                                                              style: TextStyle(color: Colors.grey, fontSize: ScreenUtil().setSp(18)),
                                                                            ),
                                                                            GestureDetector(
                                                                              onTap: () {},
                                                                              child: Icon(
                                                                                DonwloadSource.current.taskList[index]["ispause"] == true ? Icons.play_arrow : Icons.pause,
                                                                                color: Colors.white,
                                                                                size: ScreenUtil().setHeight(28),
                                                                              ),
                                                                            ),
                                                                          ],
                                                                        )
                                                                      ],
                                                                    ),
                                                                    SizedBox(
                                                                      height: ScreenUtil()
                                                                          .setHeight(
                                                                              5),
                                                                    ),
                                                                    Container(
                                                                      width: ScreenUtil()
                                                                          .setWidth(
                                                                              666),
                                                                      height: ScreenUtil()
                                                                          .setHeight(
                                                                              18),
                                                                      decoration:
                                                                          BoxDecoration(
                                                                        border: Border.all(
                                                                            width:
                                                                                1,
                                                                            color: Color.fromRGBO(
                                                                                153,
                                                                                153,
                                                                                153,
                                                                                1)),
                                                                        borderRadius:
                                                                            const BorderRadius.all(Radius.circular(8)),
                                                                      ),
                                                                      child:
                                                                          LinearProgressIndicator(
                                                                        value: DonwloadSource
                                                                            .current
                                                                            .taskList[index]["progress"],
                                                                        backgroundColor: Color.fromRGBO(
                                                                            255,
                                                                            255,
                                                                            255,
                                                                            0.10),
                                                                        valueColor:
                                                                            AlwaysStoppedAnimation<Color>(Color(0xFFFFBB1A)),
                                                                      ),
                                                                    )
                                                                  ],
                                                                ),
                                                              ));
                                                    },
                                                    separatorBuilder:
                                                        (BuildContext context,
                                                                int index) =>
                                                            Divider(
                                                      height: ScreenUtil()
                                                          .setWidth(26),
                                                    ),
                                                  ),
                                                ))
                                              ],
                                            ),
                                          ),
                                        ))
                                  ],
                                ),
                              );
                            },
                          );
                        }
                      },
                      child: Container(
                        padding: const EdgeInsets.only(
                            left: 10, right: 10, top: 0, bottom: 0),
                        color: const Color.fromRGBO(255, 255, 255, 0.15),
                        child: Flex(
                          direction: Axis.vertical,
                          children: [
                            Expanded(
                              flex: 80,
                              child: Row(
                                children: [
                                  Expanded(
                                    flex: 40,
                                    child: SizedBox(
                                      width: ScreenUtil().setWidth(121),
                                      height: ScreenUtil().setHeight(161),
                                      child: Image.network(
                                        ApiService.AppUrl +
                                            data[index]["Thumbnail"],
                                        fit: BoxFit.fill,
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: ScreenUtil().setWidth(20),
                                  ),
                                  Expanded(
                                      flex: 60,
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Ykttext(
                                              text: data[index]["ietm_name"],
                                              color: const Color(
                                                0xffffffff,
                                              ),
                                              fontsize: ScreenUtil().setSp(28),
                                              bold: FontWeight.normal),
                                          Ykttext(
                                              text:
                                                  "${data[index]["learners"]}66人学习",
                                              color: Colors.grey,
                                              fontsize: ScreenUtil().setSp(22),
                                              bold: FontWeight.normal),
                                          Row(
                                            children: [
                                              Text(
                                                "我的进度 ",
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize:
                                                        ScreenUtil().setSp(24)),
                                              ),
                                              StepWidget(
                                                  progress: isexit
                                                      ? map["LearningRate"]
                                                      : 0)
                                            ],
                                          )
                                        ],
                                      ))
                                ],
                              ),
                            ),
                            Expanded(
                              flex: 20,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                      alignment: Alignment.center,
                                      width: ScreenUtil().setWidth(200),
                                      height: ScreenUtil().setHeight(30),
                                      child: Text(
                                        "截止时间 ${data[index]["endtime"]}",
                                        style: TextStyle(
                                            color: Colors.grey,
                                            fontSize: ScreenUtil().setSp(20)),
                                      )),
                                  Container(
                                      alignment: Alignment.center,
                                      width: ScreenUtil().setWidth(100),
                                      height: ScreenUtil().setHeight(30),
                                      child: Text(
                                        "${data[index]["remainder"]}",
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: ScreenUtil().setSp(20)),
                                      )),
                                ],
                              ),
                            )
                          ],
                        ),
                      )));
            });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
          top: ScreenUtil().setHeight(28),
          left: ScreenUtil().setWidth(20),
          bottom: ScreenUtil().setHeight(28)),
      child: Stack(
        alignment: Alignment.topLeft,
        children: [
          PageView(
            physics: const NeverScrollableScrollPhysics(),
            controller: tabpageController,
            children: [
              SizedBox(
                width: ScreenUtil().setWidth(1116),
                height: ScreenUtil().setHeight(961),
                child: Image.asset(
                  "assets/img/selectbg1.png",
                  fit: BoxFit.fill,
                ),
              ),
              SizedBox(
                width: ScreenUtil().setWidth(1116),
                height: ScreenUtil().setHeight(961),
                child: Image.asset(
                  "assets/img/selectbg2.png",
                  fit: BoxFit.fill,
                ),
              ),
              SizedBox(
                width: ScreenUtil().setWidth(1116),
                height: ScreenUtil().setHeight(961),
                child: Image.asset(
                  "assets/img/selectbg3.png",
                  fit: BoxFit.fill,
                ),
              ),
            ],
          ),
          topLovelWidget(),
          Positioned(
              top: ScreenUtil().setHeight(100),
              child: Container(
                padding: EdgeInsets.only(
                    left: ScreenUtil().setWidth(40),
                    bottom: ScreenUtil().setHeight(40)),
                width: ScreenUtil().setWidth(1100),
                height: ScreenUtil().setHeight(800),
                child: PageView(
                  physics: const NeverScrollableScrollPhysics(),
                  controller: pageController,
                  children: [
                    datalist(data: bookPlanListData[0]),
                    datalist(data: bookPlanListData[1]),
                    Container(
                      alignment: Alignment.center,
                      child: Text(
                        "待开发",
                        style: TextStyle(color: Colors.white),
                      ),
                    )
                  ],
                ),
              )),
        ],
      ),
    );
  }
}
