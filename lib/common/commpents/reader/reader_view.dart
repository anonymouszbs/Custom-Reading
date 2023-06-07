// ignore_for_file: prefer_interpolation_to_compose_strings



import 'package:bot_toast/bot_toast.dart';
import 'package:ceshi1/common/commpents/reader/common/menu_bottom.dart';
import 'package:ceshi1/common/commpents/reader/common/menu_float.dart';
import 'package:ceshi1/common/commpents/reader/common/menu_font.dart';
import 'package:ceshi1/common/commpents/reader/common/menu_progress.dart';
import 'package:ceshi1/common/commpents/reader/common/menu_settings.dart';
import 'package:ceshi1/common/commpents/reader/common/menu_toc.dart';
import 'package:ceshi1/common/commpents/reader/common/menu_top.dart';
import 'package:ceshi1/common/commpents/reader/contants/floatcontroller.dart';
import 'package:ceshi1/common/commpents/reader/contants/theme.dart';
import 'package:ceshi1/public/public_class_bean.dart';
import 'package:ceshi1/public/public_function.dart';
import 'package:ceshi1/untils/getx_untils.dart';
import 'package:ceshi1/untils/sp_util.dart';
import 'package:ceshi1/widgets/Floatbut.dart';
import 'package:ceshi1/widgets/public/loading1.dart';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../untils/utils_tool.dart';
import 'common/SelectContextMenu.dart';
import 'common/menu_theme.dart';
import 'utils/utilstool.dart';

enum MenuType { TOC, THeme, PROGRESS, FONT, SETTINGS }

class ReaderViewPage extends StatefulWidget {
  const ReaderViewPage({super.key});

  @override
  State<ReaderViewPage> createState() => _ReaderViewPageState();
}

class _ReaderViewPageState extends State<ReaderViewPage>
    with TickerProviderStateMixin {
  var widgets;
  var str = "";
  var path = "";
  var sourceidData;

  @override
  void initState() {
    widgets = currentGetArguments();
    path = widgets[0];
    sourceidData = widgets[1];
    ReaderThemeC.current.bookid = sourceidData["id"];
    saveSource(id: sourceidData["id"], map: {"filepath": path.toString()});
    super.initState();
    getpath();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    ReaderThemeC.current.tocButtonsCurrentIndex.value = 0;
    BotToast.cleanAll();
    FloatController.current.onToc.value = false;
    FloatController.current.isShowReadView.value = false;
    super.dispose();
  }

  void getpath() async {
    // await copyDemoToSandBox();
    str = await getIndexHtmlPath();

    setState(() {});
  }

  UniqueKey uniqueKey = UniqueKey();
  String cTopId = "cTopId", cBottomId = "cBottomId", cLeftId = "cLeftId";
  bool showtop = false,
      showbottom = false,
      showleft = false,
      floatisShow = false;
  MenuType menuType = MenuType.TOC;
  List chapterList = [];
  showReadingControllerbar() {
    if (showtop == true || showbottom == true) {
      showtop = false;
      showbottom = false;
      setState(() {
        floatisShow = false;
      });
      BotToast.cleanAll();

      return;
    }
    topUi();
    BotToast.showWidget(
        toastBuilder: (n) {
          return MenuBottom(
            onTocTap: () {
              if (showtop) {
                BotToast.removeAll(cTopId);
                showtop = false;
                leftUI(type: MenuType.TOC);
              } else if (showleft == true && menuType == MenuType.TOC) {
                BotToast.removeAll(cLeftId);
                showleft = false;
                topUi();
              } else if (showleft == true && menuType != MenuType.TOC) {
                leftUI(type: MenuType.TOC);
              }
              menuType = MenuType.TOC;
            },
            onThemeStyleTap: () {
              if (showtop) {
                BotToast.removeAll(cTopId);
                showtop = false;
                leftUI(type: MenuType.THeme);
              } else if (showleft == true && menuType == MenuType.THeme) {
                BotToast.removeAll(cLeftId);
                showleft = false;
                topUi();
              } else if (showleft == true && menuType != MenuType.THeme) {
                leftUI(type: MenuType.THeme);
              }
              menuType = MenuType.THeme;
            },
            onProgressTap: () {
              if (showtop) {
                BotToast.removeAll(cTopId);
                showtop = false;
                leftUI(type: MenuType.PROGRESS);
              } else if (showleft == true && menuType == MenuType.PROGRESS) {
                BotToast.removeAll(cLeftId);
                showleft = false;
                topUi();
              } else if (showleft == true && menuType != MenuType.PROGRESS) {
                leftUI(type: MenuType.PROGRESS);
              }
              menuType = MenuType.PROGRESS;
            },
            onFontTap: () {
              if (showtop) {
                BotToast.removeAll(cTopId);
                showtop = false;
                leftUI(type: MenuType.FONT);
              } else if (showleft == true && menuType == MenuType.FONT) {
                BotToast.removeAll(cLeftId);
                showleft = false;
                topUi();
              } else if (showleft == true && menuType != MenuType.FONT) {
                leftUI(type: MenuType.FONT);
              }
              menuType = MenuType.FONT;
            },
            onSettingsTap: () {
              if (showtop) {
                BotToast.removeAll(cTopId);
                showtop = false;
                leftUI(type: MenuType.SETTINGS);
              } else if (showleft == true && menuType == MenuType.SETTINGS) {
                BotToast.removeAll(cLeftId);
                showleft = false;
                topUi();
              } else if (showleft == true && menuType != MenuType.SETTINGS) {
                leftUI(type: MenuType.SETTINGS);
              }
              menuType = MenuType.SETTINGS;
            },
          );
        },
        groupKey: cBottomId,
        key: uniqueKey);
    showtop = true;
    showbottom = true;
    setState(() {
      floatisShow = true;
    });
  }

  topUi() {
    showtop = true;
    BotToast.showWidget(
        toastBuilder: (n) {
          return const MenuTop();
        },
        groupKey: cTopId,
        key: uniqueKey);
  }

  leftUI({type}) {
    Widget child = Container();
    showleft = true;
    switch (type) {
      case MenuType.THeme:
        child = MenuThemes(
          onChangeTheme: (theme) {
            String source = '''
        rendition.themes.select("${theme.name}");
        ''';
            ReaderThemeC.current.theme.value = theme;

            FloatController.current.webViewController
                .evaluateJavascript(source: source);
          },
        );
        break;
      case MenuType.TOC:
        child = MenuToc(
          chapters: chapterList,
          onItemTap: (index, type) {
            if (kDebugMode) {
              print(type);
            }
            String source = '''
        rendition.display('$type');
        ''';
            FloatController.current.webViewController
                .evaluateJavascript(source: source);
          },
        );
        ReaderThemeC.current.tocScorllTo(chapterList.length);
        break;
      case MenuType.PROGRESS:
        child = const MenuProgress();
        break;
      case MenuType.FONT:
        child = MenuFont(
          onButtonTap: (index) {
            ReaderThemeC.current.readerFontSize.value = index.toDouble();
            FloatController.current.webViewController.evaluateJavascript(
                source: "rendition.themes.fontSize('${index}px')");
          },
        );
        break;
      case MenuType.SETTINGS:
        child = const MenuSettings();
        break;
    }
    BotToast.showWidget(
        toastBuilder: (n) {
          return child;
        },
        key: uniqueKey,
        groupKey: cLeftId);
  }

  initUnderline() {
    var id = sourceidData["id"];

    if (findKey(id: getNoteId(id: id)) == true) {
      print("开始化纤了");
      var info = SpUtil.getObject(getNoteId(id: id));
      List cfg = info!["cfg"];
      List note = info["note"];
      List color = info["color"];
      List text = info["text"];
      cfg.asMap().keys.map((e) async {
        if(!cfg[e].isEmpty){
          await FloatController.current.webViewController
            .evaluateJavascript(source: '''
            onUnderline("${cfg[e]}","${color[e]}","${text[e]}","${note[e]}",);
''');
        }
      }).toList();
    }
  }
///写笔记
  writeNote({cfg,color,txt,note}) async {
    var id = sourceidData["id"];
    if (txt.toString().trim() == "空_") {
     
      return;
    }
    TextEditingController textEditingController = TextEditingController(text: note.toString()=="空_"?"":note.toString());
    // String selectText =
    //     await FloatController.current.webViewController.evaluateJavascript(source: 'currentText;');
    // final currentCfg =
    //     await  FloatController.current.webViewController.evaluateJavascript(source: 'currentCfg;');
    BotToast.cleanAll();
    BotToast.showWidget(
      toastBuilder: (cancelFunc) {
        return Container(
          alignment: Alignment.topCenter,
          child: Material(
            color: Colors.transparent,
            child: SizedBox(
              width: 400,
              child: AlertDialog(
                titlePadding: EdgeInsets.all(0),
                actionsPadding: EdgeInsets.all(0),
                contentPadding: EdgeInsets.all(0),
                title: const Text('添加笔记'),
                content: TextField(
                   controller: textEditingController,
                  maxLines: 5,
                  onChanged: (value) {
                    print(value);
                    ReaderThemeC.current.inputvalue.value = value;
                  },
                ),
                actions: <Widget>[
                  Row(
                    children: [
                      Expanded(
                        child: Container(
                          width: 200,
                          height: 35,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(color: Colors.blue, width: 2),
                          ),
                          child: TextButton(
                            onPressed: () {
                              cancelFunc();
                            },
                            child: const Text(
                              '取消',
                              style: TextStyle(color: Colors.blue),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 10.w,
                      ),
                      Expanded(
                          child: Container(
                              width: 200,
                              height: 35,
                              decoration: BoxDecoration(
                                color: Colors.blue,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: TextButton(
                                onPressed: () async {
                                  saveNote(id: "$id", map: {
                                    "id": "$id",
                                    "cfg": cfg,
                                    "text": txt,
                                    "note": textEditingController.text,
                                    "color":   color
                                  });
                                  BotToast.showText(text: textEditingController.text);
                                  ReaderThemeC.current.webViewController.evaluateJavascript(source: '''
rendition.annotations.remove("$cfg", 'highlight');
                                onUnderline("$cfg","$color","$txt","${textEditingController.text}");
''');
// saveNote(id: "${id.id}", map: {
//                                     "id": "${id.id}",
//                                     "cfg": cfg.toString(),
//                                     "text": txt.toString().trim(),
//                                     "note":  textEditingController.text,
//                                     "color":  color
//                                   });
                                  // Utilstool.savebookkey(code);
                                  cancelFunc();
                                },
                                child: const Text(
                                  '保存',
                                  style: TextStyle(color: Colors.white),
                                ),
                              )))
                    ],
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }
  void readerCreateListen() {
    //加载网页
    FloatController.current.webViewController.loadUrl(
        urlRequest: URLRequest(
            url: WebUri.uri(Uri.parse("http://localhost:8080/index.html"))));

    //监听点击划线的地方
    FloatController.current.webViewController.addJavaScriptHandler(
        handlerName: 'onUnderline',
        callback: (args) async {
           print(args);
           writeNote(cfg: args[0][0],color: args[0][1],txt: args[0][2],note: args[0][3]);
        });

    //监听是否加载完毕
    FloatController.current.webViewController.addJavaScriptHandler(
        handlerName: 'epubinit',
        callback: (args)async {
          FloatController.current.isShowReadView.value = true;
          if (sourceidData["posi"] != null) {
           await  FloatController.current.webViewController.evaluateJavascript(
                source: '''rendition.display("${sourceidData["posi"]}");''');
            
            print(sourceidData["posi"]);
          } else {
            var sourcesid = getsourceid(id: sourceidData["id"]);

            if (findKey(id: sourcesid) == true) {
              SourceMap sourceMap = getsourceidMap(id: sourceidData["id"]);
              var currentlocation = sourceMap.cfi[sourceMap.cfi.length - 1];
              if (currentlocation == "") {
               await FloatController.current.webViewController
                    .evaluateJavascript(source: '''rendition.display();''');
              } else {
              await  FloatController.current.webViewController.evaluateJavascript(
                    source: '''rendition.display("$currentlocation");''');
              }
              BotToast.showText(text: currentlocation);
            }
            
          }
          initUnderline();
        });
    FloatController.current.webViewController.addJavaScriptHandler(
        handlerName: 'epubprogress',
        callback: (args) async {
          if (FloatController.current.onToc.value == false) {
            FloatController.current.progress.value =
                double.tryParse(args[0].toString())!;
            //获取当前位置
            var location = await FloatController.current.webViewController
                .evaluateJavascript(
                    source: '''rendition.currentLocation().start.cfi;''');

            print(sourceidData["id"].toString() + "这是实打实大苏打");
            FloatController.current.saveBooksourcesProgress(
                id: sourceidData["id"],
                cfi: location.toString(),
                progress: FloatController.current.progress.value);
            FloatController.current.currentlocation = location.toString();
          }
        });
    //监听显示上下文菜单
    FloatController.current.webViewController.addJavaScriptHandler(
        handlerName: 'showContextMenu',
        callback: (args) {
          if (FloatController.current.isshow.value == false) {
            final message = args[0];
            BotToast.showText(text: "收到$message");
            BotToast.cleanAll();
            var offset = Offset(double.parse(message.toString().split("|")[0]),
                double.parse(message.toString().split("|")[1]));
            ReaderThemeC.current.selectContextMenu.show(
                offset, context, FloatController.current.webViewController);
          }
        });
    //监听鼠标单机
    FloatController.current.webViewController.addJavaScriptHandler(
        handlerName: 'closeShowContextMenu',
        callback: (args) {
          if (FloatController.current.isshow.value == false) {
            if (ReaderThemeC.current.selectContextMenu.isshow == false) {
              showReadingControllerbar();
            } else {
              ReaderThemeC.current.selectContextMenu.close();
            }
          }
        });
    // 监听章节返回
    FloatController.current.webViewController.addJavaScriptHandler(
        handlerName: 'callChapter',
        callback: (args) {
          chapterList = args[0]['toc'];
          // chapterList.map((e) {
          //   print(e['label']);
          // }).toList();
        });

    ///监听章节切换
    FloatController.current.webViewController.addJavaScriptHandler(
        handlerName: 'chapterChange',
        callback: (args) async {
          print(args[0].toString());
          int a = 0;
          ReaderThemeC.current.currentTitle.value = args[0]['title'];

          if (kDebugMode) {
            print(args[0]);
          }
          // if(FloatController.current.isshow.value==true){
          //   FloatController.current.startPlay();
          // }
          chapterList.map((e) {
            Map<dynamic, dynamic> map = e;
            if (map.containsValue(args[0]['href']) ||
                UtilsToll.findkeysOrvalues(map, args[0]['href'])) {
              if (kDebugMode) {
                print(map['label']);
              }

              ReaderThemeC.current.currentTitle.value = args[0]['title'];
              ReaderThemeC.current.currentindex.value = a;
            }
            a++;
          }).toList();
        });
    FloatController.current.webViewController.addJavaScriptHandler(
        handlerName: 'readtext',
        callback: (args) async {
          FloatController.current.readtext = args[0].toString();
        });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () async {
          return false;
        },
        child: Scaffold(
            floatingActionButtonLocation: CustomFloatingActionButtonLocation(
                FloatingActionButtonLocation.endFloat, 0, -40),
             floatingActionButton: floatisShow ? const MenuFloat() : null,
//             floatingActionButton: FloatingActionButton(onPressed: () {
// //           print(FloatController.current.currentlocation);
//               FloatController.current.webViewController
//                   .evaluateJavascript(source: '''
// rendition.display("epubcfi(/6/10[x_chapter_0001.xhtml]!/4/14,/1:48,/1:268)");
// ''');

//               SpUtil.clear();
// //           //  DonwloadSource.current.createFile();
// //           print(path);
//             }),
            body: Stack(
              children: [
                SizedBox(
                  width: ScreenUtil().screenWidth.toInt().toDouble(),
                  height: ScreenUtil().screenHeight.toInt().toDouble(),
                  child: InAppWebView(
                    onWebViewCreated: (controller) async {
                      SourceMap sourceMap =
                          getsourceidMap(id: sourceidData["id"]);
                          
                      ReaderThemeC.current.webViewController = controller;
                      FloatController.current.webViewController = controller;
                      ReaderThemeC.current.selectContextMenu =
                          SelectContextMenu(
                              isshow: false,
                              webViewController:
                                  FloatController.current.webViewController,
                              id: sourceMap);
                      readerCreateListen();
                    },
                    contextMenu: ContextMenu(),
                    onRenderProcessGone: (controller, detail) {
                      //输出错误
                    },
                    onContentSizeChanged:
                        (controller, oldContentSize, newContentSize) {},
                    onConsoleMessage: (controller, consoleMessage) {
                      BotToast.showText(text: consoleMessage.message);
                    },
                    onLongPressHitTestResult: (controller, hitTestResult) {},
                    gestureRecognizers: const {},
                    onLoadStop: (controller, url) {
                      Size size = Size(
                          ScreenUtil().screenWidth, ScreenUtil().screenHeight);

                      FloatController.current.webViewController.evaluateJavascript(
                          source:
                              '''load(${size.width.toInt()},${size.height.toInt()},"$path",0);''');

                      // showErrorToast(context, "loadstop");
                    },

                    initialSettings: InAppWebViewSettings(
                        pageZoom: 1,
                        userAgent: "ReaderJs/NoScroll",
                        // verticalScrollBarEnabled: true,
                        // horizontalScrollBarEnabled: true,
                        supportZoom: false, //缩放手势禁用
                        hardwareAcceleration: true, //硬件加速开启
                        disableHorizontalScroll: true, //开启横向滚动
                        disableVerticalScroll: true, //关闭垂直滚动
                        disableContextMenu: true), //关闭上下文菜单
                  ),
                ),
                Positioned(
                    left: 0,
                    child: SizedBox(
                      width: ScreenUtil().setWidth(100),
                      height: ScreenUtil().screenHeight,
                      child: GestureDetector(
                        onTap: () {
                          ReaderThemeC.current.selectContextMenu.prevpage();
                        },
                      ),
                    )),
                Positioned(
                    right: 0,
                    child: SizedBox(
                      width: ScreenUtil().setWidth(100),
                      height: ScreenUtil().screenHeight,
                      child: GestureDetector(
                        onTap: () async {
                          var sourcesid = getsourceid(id: sourceidData["id"]);

                         
                          int now = DateTime.now().millisecondsSinceEpoch;
                          if (FloatController.current.onToc.value == true) {
                            ReaderThemeC.current.selectContextMenu.nextpage();
                          } else {
                            if (findKey(id: sourcesid) == true) {
                              SourceMap sourceMap =
                                  getsourceidMap(id: sourceidData["id"]);
                              if (sourceMap.progress <=
                                  FloatController.current.progress.value) {
                                if (now - lastBackPressedTime > 3000) {
                                  lastBackPressedTime = now;
                                  ReaderThemeC.current.selectContextMenu
                                      .nextpage();
                                } else {
                                  BotToast.showText(text: "别翻太快了,三秒后可翻动");
                                }
                              } else {
                                ReaderThemeC.current.selectContextMenu
                                    .nextpage();
                              }
                            } else if (FloatController.current.onToc.value ==
                                true) {
                              ReaderThemeC.current.selectContextMenu.nextpage();
                            } else {
                              ReaderThemeC.current.selectContextMenu.nextpage();
                            }
                          }

                          //
                        },
                      ),
                    )),
                Obx(() => FloatController.current.isShowReadView.value == false
                    ? const Positioned.fill(child: Loading1())
                    : Container()),
                Obx(() => FloatController.current.onToc.value == true
                    ? Positioned(
                        bottom: ScreenUtil().setHeight(155),
                        right: ScreenUtil().setWidth(20),
                        child: Container(
                          alignment: Alignment.center,
                          width: ScreenUtil().setWidth(230),
                          height: ScreenUtil().setHeight(50),
                          decoration: const BoxDecoration(
                              color: Colors.blue,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10))),
                          child: TextButton.icon(
                              onPressed: () {

                                SourceMap sourceMap =
                                    getsourceidMap(id: sourceidData["id"]);

                                var currentloaction =
                                    sourceMap.cfi[sourceMap.cfi.length - 1];
                                FloatController.current.onToc.value = false;
                                FloatController.current.progress.value =
                                    sourceMap.progress;
                                FloatController.current.webViewController
                                    .evaluateJavascript(source: '''
  rendition.display("$currentloaction");
''');
                              },
                              icon: Icon(
                                Icons.av_timer,
                                color: Colors.white,
                                size: ScreenUtil().setSp(22),
                              ),
                              label: Text(
                                "回到原来阅读位置",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: ScreenUtil().setSp(18)),
                              )),
                        ))
                    : Container())
              ],
            )));
  }

  int lastBackPressedTime = 0;
}
