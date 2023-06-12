import 'package:bot_toast/bot_toast.dart';
import 'package:ceshi1/common/commpents/reader/contants/floatcontroller.dart';
import 'package:ceshi1/common/commpents/reader/contants/theme.dart';
import 'package:ceshi1/pages/bookTree/controller/detailscontroller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../public/public_function.dart';
import '../../../../untils/sp_util.dart';
import '../../../../widgets/animation.dart';

// ignore: must_be_immutable
class MenuToc extends StatelessWidget {
  final List chapters;
  final void Function(int index, String type) onItemTap;
  const MenuToc({super.key, required this.chapters, required this.onItemTap});

  @override
  Widget build(BuildContext context) {
    var info;
    List cfg = [];
    List note = [];
    List<String> text1 = [];
    List color = [];
    if (findKey(id: getNoteId(id: ReaderThemeC.current.bookid)) == true) {
      print("数据捕捉");
      var info = SpUtil.getObject(getNoteId(id: ReaderThemeC.current.bookid));
      cfg = info!["cfg"];
      note = info["note"];
      text1 = List<String>.from(info["text"]);
      color = List<String>.from(info["color"]);
    }
    return AnimationsPY(
      padding: EdgeInsets.only(top: ScreenUtil().screenHeight * 0.3 - 50),
      frame: Container(
          color: ReaderThemeC.current.theme.value.pannelBackgroundColor,
          width: MediaQuery.of(context).size.width,
          height: (ScreenUtil().screenHeight - 110) * 0.8,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Obx(
                () => Row(
                  children: [
                    TextButton(
                        onPressed: () {
                          ReaderThemeC.current.tocButtonsCurrentIndex.value = 0;
                          ReaderThemeC.current.tocPageController.jumpToPage(0);
                        },
                        child: Text(
                          "目录",
                          style: TextStyle(
                              color: ReaderThemeC.current.tocButtonsCurrentIndex
                                          .value ==
                                      0
                                  ? Colors.red
                                  : ReaderThemeC
                                      .current.theme.value.pannelTextColor,
                              fontSize: 16,
                              fontWeight: FontWeight.w600),
                        )),
                    TextButton(
                        onPressed: () {
                          ReaderThemeC.current.tocButtonsCurrentIndex.value = 1;
                          ReaderThemeC.current.tocPageController.jumpToPage(1);
                          print(ReaderThemeC.current.bookid);
                          print(SpUtil.getKeys());
                        },
                        child: Text(
                          "笔记",
                          style: TextStyle(
                              color: ReaderThemeC.current.tocButtonsCurrentIndex
                                          .value ==
                                      1
                                  ? Colors.red
                                  : ReaderThemeC
                                      .current.theme.value.pannelTextColor,
                              fontSize: 16,
                              fontWeight: FontWeight.w600),
                        ))
                  ],
                ),
              ),
              Expanded(
                  child: PageView(
                physics: const NeverScrollableScrollPhysics(),
                controller: ReaderThemeC.current.tocPageController,
                children: [
                  ListView.separated(
                    physics: const ClampingScrollPhysics(),
                    controller: ReaderThemeC.current.tocScrollController,
                    cacheExtent: 46,
                    itemBuilder: (context, index) {
                      if (index == 0) {
                        return const SizedBox(
                          height: 1,
                        );
                      } else {
                        final chapter = chapters[index - 1];
                        return InkWell(
                            onTap: () {
                              FloatController.current.onToc.value = true;
                              ReaderThemeC.current.currentindex.value =
                                  index - 1;
                              onItemTap(index - 1, chapter['href']);
                            },
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 10),
                              child: Obx(
                                () => Text(
                                  chapter['label'],
                                  style: TextStyle(
                                      color: ReaderThemeC
                                                  .current.currentindex.value ==
                                              (index - 1)
                                          ? ReaderThemeC
                                              .current.theme.value.primaryColor
                                          : ReaderThemeC.current.theme.value
                                              .pannelTextColor,
                                      fontSize: 13),
                                ),
                              ),
                            ));
                      }
                    },
                    separatorBuilder: (BuildContext context, int index) {
                      return Divider(
                        indent: 16,
                        endIndent: 16,
                        height: 0,
                        thickness: 0.4,
                        color: ReaderThemeC.current.theme.value.dividerColor,
                      );
                    },
                    itemCount: chapters.length + 1,
                  ),
                  ListView.builder(
                    padding: const EdgeInsets.all(0),
                    itemCount: cfg.length,
                    itemBuilder: (context, index) {
                      return Material(
                        color: Colors.transparent,
                        child: InkWell(
                          onTap: () {
                            print("${cfg[index]}");
                            BotToast.cleanAll();
                            FloatController.current.webViewController
                                .evaluateJavascript(source: '''
rendition.display("${cfg[index]}");
''');
                          },
                          child: ListTile(
                            leading: SizedBox(
                              width: 30.w,
                              height: 30.w,
                              child: CircleAvatar(
                                backgroundColor: Colors.tealAccent,
                                child: Text(
                                  "${index + 1}",
                                  style: TextStyle(color: Colors.black),
                                ),
                              ),
                            ),
                            title: Text(
                              "划线：${text1[index].length > 30 ? text1[index].substring(0, 29) : text1[index]}",
                              maxLines: 1,
                              style: TextStyle(
                                  color: Color(int.parse(
                                      "0xff${color[index].toString().substring(1)}"))),
                            ),
                            trailing: Text(
                              note[index] == "空_"
                                  ? ""
                                  : "笔记：${note[index].length > 30 ? note[index].substring(0, 29) : note[index]}",
                              maxLines: 1,
                              style: TextStyle(
                                  color: Color(int.parse(
                                      "0xff${color[index].toString().substring(1)}"))),
                            ),
                          ),
                        ),
                      );
                    },
                  )
                ],
              )),
            ],
          )),
      tab: ReaduiType.LEFT,
    );
  }
}
