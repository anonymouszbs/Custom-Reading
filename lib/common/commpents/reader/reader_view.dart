

import 'dart:io';
import 'dart:ui' as ui;

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
import 'package:ceshi1/widgets/Floatbut.dart';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_tesseract_ocr/flutter_tesseract_ocr.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';
import 'package:screenshot/screenshot.dart';

import '../../../untils/utils_tool.dart';
import '../../../widgets/SelectContextMenu.dart';
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
  var str = "";
  @override
  void initState() {
    super.initState();
    getpath();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    BotToast.cleanAll();
    super.dispose();
  }

  void getpath() async {
    // await copyDemoToSandBox();
    str = await getIndexHtmlPath();
    setState(() {});
  }

  late InAppWebViewController webViewController;
  

  UniqueKey uniqueKey = UniqueKey();
  String cTopId = "cTopId", cBottomId = "cBottomId", cLeftId = "cLeftId";
  bool showtop = false, showbottom = false, showleft = false,floatisShow = false;
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

            webViewController.evaluateJavascript(source: source);
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

            webViewController.evaluateJavascript(source: source);
          },
        );
      case MenuType.PROGRESS:
        child = const MenuProgress();
        break;
      case MenuType.FONT:
        child = MenuFont(
          onButtonTap: (index) {
            ReaderThemeC.current.readerFontSize.value = index.toDouble();
            webViewController.evaluateJavascript(
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

  void readerCreateListen() {
    //加载网页
    webViewController.loadUrl(
        urlRequest: URLRequest(
            url: WebUri.uri(Uri.parse("http://localhost:8080/index.html"))));
    //监听显示上下文菜单
    webViewController.addJavaScriptHandler(
        handlerName: 'showContextMenu',
        callback: (args) {
          if(FloatController.current.isshow.value==false){
            final message = args[0];
          BotToast.showText(text: "收到$message");
          BotToast.cleanAll();
          var offset = Offset(double.parse(message.toString().split("|")[0]),
              double.parse(message.toString().split("|")[1]));
          ReaderThemeC.current.selectContextMenu.show(offset, context, webViewController);
          }
          
        });
    //监听鼠标单机
    webViewController.addJavaScriptHandler(
        handlerName: 'closeShowContextMenu',
        callback: (args) {
          if(FloatController.current.isshow.value==false){
             if (ReaderThemeC.current.selectContextMenu.isshow == false) {
            showReadingControllerbar();
          } else {
            ReaderThemeC.current.selectContextMenu.close();
          }
          }
        });
    // 监听章节返回
    webViewController.addJavaScriptHandler(
        handlerName: 'callChapter',
        callback: (args) {
          chapterList = args[0]['toc'];
          // chapterList.map((e) {
          //   print(e['label']);
          // }).toList();
        });

    ///监听章节切换
    webViewController.addJavaScriptHandler(
        handlerName: 'chapterChange',
        callback: (args) {
          int a = 0;
          if (kDebugMode) {
            print(args[0]);
          }
          // if(FloatController.current.isshow.value==true){
          //   FloatController.current.startPlay();
          // }
          chapterList.map((e) {
            Map<dynamic, dynamic> map = e;
            if (map.containsValue(args[0])||UtilsToll.findkeysOrvalues(map, args[0])) {
              if (kDebugMode) {
                print(map['label']);
              }
              ReaderThemeC.current.currentTitle.value = map['label'];
              ReaderThemeC.current.currentindex.value = a;
            }
            a++;

            
          }).toList();
        });
  }

  


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButtonLocation: CustomFloatingActionButtonLocation(FloatingActionButtonLocation.endFloat, 0, - 40),
        floatingActionButton: floatisShow?const MenuFloat():null,
        body: Stack(
      children: [
        SizedBox(
          width:ScreenUtil().screenWidth.toInt().toDouble() ,
          height: ScreenUtil().screenHeight.toInt().toDouble(),
          child: InAppWebView(
          onWebViewCreated: (controller) async {
            ReaderThemeC.current.webViewController = controller;
            webViewController = controller;
            ReaderThemeC.current.selectContextMenu = SelectContextMenu(false, webViewController);
            readerCreateListen();
          },
          contextMenu: ContextMenu(),
          onRenderProcessGone: (controller, detail) {
            //输出错误
          },
          onContentSizeChanged: (controller, oldContentSize, newContentSize) {},
          onConsoleMessage: (controller, consoleMessage) {
             BotToast.showText(text: consoleMessage.message);
          },
          onLongPressHitTestResult: (controller, hitTestResult) {},
          gestureRecognizers: const {},
          onLoadStop: (controller, url) {
            
            // showErrorToast(context, "loadstop");
            Size size =
                Size(ScreenUtil().screenWidth, ScreenUtil().screenHeight);
            webViewController.evaluateJavascript(
                source:
                    'load(${size.width.toInt()},${size.height.toInt()});');
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
              width: 50,
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
              width: 50,
              height: ScreenUtil().screenHeight,
              child: GestureDetector(
                onTap: () {
                  ReaderThemeC.current.selectContextMenu.nextpage();
                },
              ),
            ))
      ],
    ));
  }
}
