import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import 'package:bot_toast/bot_toast.dart';
import 'package:ceshi1/common/network/findbookApi.dart';
import 'package:ceshi1/config/controller/user_state_controller.dart';
import 'package:ceshi1/pages/bookTree/routers/booktree_page_id.dart';
import 'package:ceshi1/pages/home/common/selectdimension2.dart';
import 'package:ceshi1/untils/getx_untils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../common/network/ApiServices.dart';
import '../../../widgets/public/SliverGridDelegateWithFixedSize.dart';
import '../../../widgets/public/loading1.dart';
import '../../../widgets/public/textwidget.dart';
import '../common/selectOptions.dart';

class MenuFindBar extends StatefulWidget {
  const MenuFindBar({super.key});

  @override
  State<MenuFindBar> createState() => _MenuFindBarState();
}

class _MenuFindBarState extends State<MenuFindBar> {
  late PageController tabpageController = PageController(initialPage: 0);
  late PageController pageController = PageController(initialPage: 0);
  var toplevelListData = [], bookListData = [[], [], []];
  int currentindex = 0;
  LoaddingState state = LoaddingState.LOADDING;
  @override
  void initState() {
    getTopLevel();
    super.initState();
  }

  //学习人数降序
  orderByitemidDescBookListData() {
    setState(() {
      bookListData[currentindex]
          .sort((a, b) => b['ietm_id'].compareTo(a['ietm_id']));
    });
  }

  orderBylearnersAscBookListData() {
    setState(() {
      bookListData[currentindex]
          .sort((a, b) => b['learners'].compareTo(a['learners']));
    });
  }

  getTopLevel() async {
    var data = {
      "username": UserStateController.current.user.username,
      "pwd": UserStateController.current.user.pwd
    };

    var reponse = await ApiService.getTopLevel(data);
    var jsondata = json.decode(reponse.data);

    if (jsondata['code'] == 1) {
      setState(() {
        toplevelListData = jsondata['data'];
      });
    } else {
      BotToast.showText(text: "加载错误");
    }
    geTopBookDataList(id: toplevelListData[0]['id'], index: 0);
  }

  //根据二级分类 刷新接口
  getSecondAryBooklist(int Dimension2) {
    Timer(const Duration(milliseconds: 1000), () async {
      var data = {
        "username": UserStateController.current.user.username,
        "pwd": UserStateController.current.user.pwd,
        "Dimension1": toplevelListData[currentindex]["id"],
        "Dimension2": Dimension2
      };

      print(data);

      var reponse = await FindBookApi.geTopBookDataList(data);
      var jsondata = json.decode(reponse.data);
      if (jsondata['code'] == 1) {
        if (jsondata["data"].length == 0) {
          state = LoaddingState.ERROR;
        }
        setState(() {
          bookListData[currentindex] = jsondata["data"];
        });
        BotToast.showText(text: "刷新成功");
      } else {
        BotToast.showText(text: "数据加载失败");
      }
    });
  }

//根据顶级分类获取接口
  geTopBookDataList({id, index}) async {
    setState(() {
      bookListData[index].clear();
    });
    Timer(const Duration(milliseconds: 1000), () async {
      var data = {
        "username": UserStateController.current.user.username,
        "pwd": UserStateController.current.user.pwd,
        "Dimension1": id
      };
      var reponse = await FindBookApi.geTopBookDataList(data);
      var jsondata = json.decode(reponse.data);
      if (jsondata['code'] == 1) {
        if (jsondata["data"].length == 0) {
          state = LoaddingState.ERROR;
        }
        setState(() {
          bookListData[index] = jsondata["data"];
        });
      } else {
        BotToast.showText(text: "数据加载失败");
      }
    });
  }

  topLovelWidget() {
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

                      setState(() {
                        currentindex = e;
                        bookListData[currentindex].clear();
                        state = LoaddingState.LOADDING;
                      });
                      geTopBookDataList(
                          index: e, id: toplevelListData[e]['id']);
                    },
                    icon: Image.asset(
                      currentindex == e
                          ? "assets/img/tab_arrow.png"
                          : "assets/img/tab_exam_normal.png",
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
    return GridView.builder(
        itemCount: data.length,
        padding: const EdgeInsets.only(top: 0),
        gridDelegate: SliverGridDelegateWithFixedSize(
          ScreenUtil().setWidth(345),
          ScreenUtil().setHeight(240),
          mainAxisSpacing: 5.0,
        ),
        itemBuilder: (c, index) {
          return Material(
              color: Colors.transparent,
              child: InkWell(
                  onTap: () {},
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
                                flex: 4,
                                child:SizedBox(
                                  width: ScreenUtil().setWidth(121),
                                  height: ScreenUtil().setHeight(161),
                                  child:  Image.network(
                                  ApiService.AppUrl + data[index]["Thumbnail"],
                                  fit: BoxFit.fill,
                                ),)
                              ),
                              SizedBox(
                                width: ScreenUtil().setWidth(20),
                              ),
                              Expanded(
                                  flex: 6,
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
                                              "${data[index]["learners"]}999人已学习",
                                          color: Colors.grey,
                                          fontsize: ScreenUtil().setSp(22),
                                          bold: FontWeight.normal),
                                      Ykttext(
                                          text: "我的进度:10%",
                                          color: Colors.grey,
                                          fontsize: ScreenUtil().setSp(22),
                                          bold: FontWeight.normal),
                                    ],
                                  ))
                            ],
                          ),
                        ),
                        Expanded(
                          flex: 20,
                          child: Container(
                            decoration: const BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                              gradient: LinearGradient(
                                begin: Alignment.centerRight,
                                end: Alignment.centerLeft,
                                colors: [
                                  Color.fromRGBO(255, 255, 255, 0),
                                  Color.fromRGBO(255, 255, 255, 0.12)
                                ],
                              ),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                TextButton.icon(
                                    onPressed: () {},
                                    icon: Image.asset(
                                      "assets/img/download.png",
                                      fit: BoxFit.cover,
                                    ),
                                    label: Text(
                                      "下载至本地",
                                      style: TextStyle(color: Colors.white),
                                    )),
                                TextButton.icon(
                                    onPressed: () async {
                                      //添加至学习计划
                                      await ApiService.addBookShelf(
                                          UserID: UserStateController
                                              .current.user.id,
                                          IETM_ID: data[index]["ietm_id"]);
                                      setState(() {
                                          data[index]["Is_Plan"]=1;
                                        });  
                                    },
                                    icon: Image.asset(
                                      data[index]["Is_Plan"]==0?"assets/img/add.png":"assets/img/added.png",
                                      fit: BoxFit.cover,
                                    ),
                                    label: Text(
                                      data[index]["Is_Plan"]==0?"学习计划":"已加入计划",
                                      style: const TextStyle(color: Colors.white),
                                    ))
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  )));
        });
  }

  Widget EditTextfield({hintext, inputFormatters}) {
    return Container(
        width: ScreenUtil().setWidth(200),
        height: ScreenUtil().setHeight(50),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20.0),
          boxShadow: const [
            BoxShadow(
              color: Color.fromRGBO(255, 255, 255, 0),
            ),
            BoxShadow(color: Color.fromRGBO(255, 255, 255, 0.12))
          ],
        ),
        child: TextField(
          enabled: false,
          textAlignVertical: TextAlignVertical.bottom,
          style: const TextStyle(
            color: Colors.white,
          ),
          inputFormatters: inputFormatters,
          decoration: InputDecoration(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0),
              borderSide: BorderSide.none,
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0),
              borderSide: BorderSide.none,
            ),
            filled: true,
            fillColor: Colors.transparent,
            hintText: hintext,
            hintStyle: TextStyle(
              color: Colors.white.withOpacity(0.7),
            ),
          ),
        ));
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
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
            top: ScreenUtil().setHeight(90),
            child: Container(
              // color: Colors.red.withOpacity(0.2),
              width: ScreenUtil().setWidth(1100),
              padding: EdgeInsets.only(
                  left: ScreenUtil().setWidth(40),
                  right: ScreenUtil().setWidth(0)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      SizedBox(
                        width: ScreenUtil().setWidth(180),
                        height: ScreenUtil().setHeight(40),
                        child: SlectOptions(
                          onChanged: (value) {
                            switch (value) {
                              case "阅读量":
                                orderBylearnersAscBookListData();
                                BotToast.showText(
                                    text: "已按照阅读量排序",
                                    align: Alignment.topCenter);
                                break;
                              case "最新发布":
                                BotToast.showText(
                                    text: "已按照最新发布排序",
                                    align: Alignment.topCenter);
                                orderByitemidDescBookListData();
                                break;
                              case "最近阅读":
                                //留空
                                break;
                              default:
                            }
                          },
                          options: ['阅读量', '最新发布', '最近阅读'],
                          dropdownValue: "阅读量",
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      SizedBox(
                        width: ScreenUtil().setWidth(180),
                        height: ScreenUtil().setHeight(40),
                        child: SelectDimension2(
                          ondimension2: (Dimension2) {
                            setState(() {
                              state = LoaddingState.LOADDING;
                              bookListData[currentindex].clear();
                            });

                            getSecondAryBooklist(Dimension2);
                          },
                        ),
                      ),
                    ],
                  ),
                  InkWell(
                    onTap: () {
                      currentToPage(BookTreePageId.booktree);
                    },
                    child: EditTextfield(
                      hintext: "点击搜索",
                    ),
                  )
                ],
              ),
            )),
        Positioned(
            top: ScreenUtil().setHeight(170),
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
                  bookListData[0].length == 0
                      ? Loading1(
                          state: state,
                        )
                      : datalist(data: bookListData[0]),
                  bookListData[1].length == 0
                      ? Loading1(
                          state: state,
                        )
                      : datalist(data: bookListData[1]),
                  bookListData[2].length == 0
                      ? Loading1(
                          state: state,
                        )
                      : datalist(data: bookListData[2]),
                ],
              ),
            )),
      ],
    );
  }
}
