import 'dart:async';
import 'dart:convert';

import 'package:bot_toast/bot_toast.dart';
import 'package:ceshi1/common/network/ApiServices.dart';
import 'package:ceshi1/pages/bookTree/widgets/booktree_Editfield.dart';
import 'package:ceshi1/pages/bookTree/widgets/ykt_content_tree.dart';
import 'package:ceshi1/widgets/public/loading1.dart';
import 'package:ceshi1/widgets/public/pub_bg.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../common/network/findbookApi.dart';
import '../../config/controller/user_state_controller.dart';

class BookTreePage extends StatefulWidget {
  const BookTreePage({super.key});

  @override
  State<BookTreePage> createState() => _BookTreePageState();
}

class _BookTreePageState extends State<BookTreePage> {
  late TextEditingController searchvalue = TextEditingController();
  var bookListData = [];
  String currentId = "",currentvalue = "";
  String searchietm_name = "";
  LoaddingState state = LoaddingState.LOADDING;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  geTopBookDataList() async {
    currentId = currentId == "" ? "0" : currentId;
    Timer(const Duration(milliseconds: 1000), () async {
      var data = {
        "username": UserStateController.current.user.username,
        "pwd": UserStateController.current.user.pwd,
        "parentnodeid": currentId,
        "ietm_name": searchietm_name
      };
      var reponse = await FindBookApi.geTopBookDataList(data);
      var jsondata = json.decode(reponse.data);
     
      if (jsondata['code'] == 1) {
        setState(() {
          bookListData = jsondata["data"];
           if(jsondata["data"].length==0){
        state = LoaddingState.ERROR;
      }
          print(bookListData);
        });
      } else {
        BotToast.showText(text: "数据加载失败");
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        const Pub_Bg(),
        Container(
          padding: EdgeInsets.all(ScreenUtil().setSp(30)),
          child: Flex(
            direction: Axis.horizontal,
            children: [
              Expanded(
                  flex: 25,
                  child: Container(
                    width: ScreenUtil().setWidth(263),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,

                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            textDL(),
                           Text("$currentvalue",
                              maxLines: 1,
                                style: TextStyle(
                                    overflow: TextOverflow.clip,
                                    fontSize: ScreenUtil().setSp(20),
                                    fontWeight: FontWeight.bold,
                                    color: Colors.grey)),
                            
                          ],
                        ),
                        SizedBox(
                          height: ScreenUtil().setHeight(22),
                        ),
                        Stack(
                          alignment: Alignment.topCenter,
                          children: [
                            Container(
                              width: ScreenUtil().setWidth(332),
                              height: ScreenUtil().setHeight(819),
                              decoration: const BoxDecoration(
                                  image: DecorationImage(
                                      fit: BoxFit.fill,
                                      image: AssetImage(
                                        "assets/img/booktree_bg.png",
                                      ))),
                            ),
                            Positioned(
                                top: ScreenUtil().setHeight(27),
                                child: SizedBox(
                                  width: ScreenUtil().setWidth(280),
                                  height: ScreenUtil().setHeight(40),
                                  child: EditTextfield(
                                    onTap: (Value){
                                       setState(() {
                                        state = LoaddingState.LOADDING;
                                        bookListData.clear();
                                     });
                                      searchietm_name = Value;
                                      geTopBookDataList();
                                    },
                                      textcontroller: searchvalue,
                                      hintext: "搜索分类目录"),
                                )),
                            Positioned(
                              top: ScreenUtil().setHeight(93),
                              child: SizedBox(
                                  width: ScreenUtil().setWidth(300),
                                  height: ScreenUtil().setHeight(768),
                                  child: YktContentTree(
                                    onValue: (value){
                                     setState(() {
                                        currentvalue  = value;
                                     });
                                    },
                                    onIndex: (index) {
                                      //点击分类
                                      currentId = index;
                                     setState(() {
                                        state = LoaddingState.LOADDING;
                                        bookListData.clear();
                                     });
                                      geTopBookDataList();
                                    },
                                  )),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: ScreenUtil().setHeight(25),
                        ),
                        SizedBox(
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
                                children: [
                                  Image.asset("assets/img/btn_back.png")
                                ],
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  )),
              //列表展示
              Expanded(
                  flex: 75,
                  child: Flex(
                    direction: Axis.vertical,
                    children: [
                      Expanded(
                          flex: 6,
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Text(
                                "封面",
                                style: TextStyle(
                                    color: Colors.grey,
                                    fontSize: ScreenUtil().setSp(20)),
                              ),
                              Text(
                                "教材名称",
                                style: TextStyle(
                                    color: Colors.grey,
                                    fontSize: ScreenUtil().setSp(20)),
                              ),
                              Text(
                                "一级分类",
                                style: TextStyle(
                                    color: Colors.grey,
                                    fontSize: ScreenUtil().setSp(20)),
                              ),
                              Text(
                                "二级分类",
                                style: TextStyle(
                                    color: Colors.grey,
                                    fontSize: ScreenUtil().setSp(20)),
                              ),
                              Text(
                                "作者",
                                style: TextStyle(
                                    color: Colors.grey,
                                    fontSize: ScreenUtil().setSp(20)),
                              )
                            ],
                          )),
                      Expanded(
                          flex: 94,
                          child:bookListData.isEmpty?Loading1(state: state,):  Container(
                            padding:
                                EdgeInsets.only(left: ScreenUtil().setWidth(0)),
                            child: ListView.builder(
                              padding: EdgeInsets.only(
                                  left: ScreenUtil().setWidth(31)),
                              itemCount: bookListData.length,
                              itemBuilder: (context, index) {
                                return Material(
                                  color: Colors.transparent,
                                  child: InkWell(
                                    onTap: () {},
                                    child: Container(
                                      decoration: const BoxDecoration(
                                        gradient: LinearGradient(
                                          begin: Alignment.centerLeft,
                                          end: Alignment.centerRight,
                                          colors: [
                                            Color.fromRGBO(255, 255, 255, 0.1),
                                            Color.fromRGBO(255, 255, 255, 0.0)
                                          ],
                                        ),
                                      ),
                                      width: ScreenUtil().setWidth(923),
                                      height: ScreenUtil().setHeight(152),
                                      child: Row(
                                        children: [
                                          Container(
                                            padding: EdgeInsets.only(
                                                left:
                                                    ScreenUtil().setWidth(14)),
                                            width: ScreenUtil().setWidth(110),
                                            height: ScreenUtil().setHeight(121),
                                            child: Image.network(
                                              ApiService.AppUrl +
                                                  bookListData[index]
                                                      ['Thumbnail'],
                                              fit: BoxFit.fill,
                                            ),
                                          ),
                                          SizedBox(
                                            width: ScreenUtil().setWidth(46),
                                          ),
                                          Expanded(
                                              child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceEvenly,
                                            children: [
                                              Expanded(
                                                child: Text(
                                                  bookListData[index]
                                                      ['ietm_name'],
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: ScreenUtil()
                                                          .setSp(28)),
                                                  maxLines: 2,
                                                  textAlign: TextAlign.center,
                                                ),
                                              ),
                                              SizedBox(
                                                width:
                                                    ScreenUtil().setWidth(20),
                                              ),
                                              Expanded(
                                                child: Text(
                                                    bookListData[index]
                                                        ['Dimension1name'],
                                                    style: TextStyle(
                                                        color: Colors.grey,
                                                        fontSize: ScreenUtil()
                                                            .setSp(24)),
                                                    maxLines: 1,
                                                    textAlign:
                                                        TextAlign.center),
                                              ),
                                              SizedBox(
                                                width:
                                                    ScreenUtil().setWidth(10),
                                              ),
                                              Expanded(
                                                child: Text(
                                                    bookListData[index]
                                                        ['Dimension2name'],
                                                    style: TextStyle(
                                                        color: Colors.grey,
                                                        fontSize: ScreenUtil()
                                                            .setSp(24)),
                                                    maxLines: 1,
                                                    textAlign:
                                                        TextAlign.center),
                                              ),
                                              SizedBox(
                                                width: ScreenUtil().setWidth(0),
                                              ),
                                              Expanded(
                                                child: Text(
                                                    bookListData[index]
                                                        ['authoridname'],
                                                    style: TextStyle(
                                                        color: Colors.grey,
                                                        fontSize: ScreenUtil()
                                                            .setSp(24)),
                                                    maxLines: 1,
                                                    textAlign:
                                                        TextAlign.center),
                                              ),
                                            ],
                                          ))
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              },
                            ),
                          ))
                    ],
                  ))
            ],
          ),
        ),
      ],
    );
  }
}
