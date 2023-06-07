import 'package:bot_toast/bot_toast.dart';
import 'package:ceshi1/common/commpents/reader/contants/theme.dart';
import 'package:ceshi1/public/public_class_bean.dart';
import 'package:ceshi1/public/public_function.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

enum Themetype { dark, light, tan }

class UnderLinecolor {
  String red = "#${Colors.red.value.toRadixString(16).substring(2)}";
  String blue = "#${Colors.blue.value.toRadixString(16).substring(2)}";
  String amber = "#${Colors.amber.value.toRadixString(16).substring(2)}";
  String cyan = "#${Colors.cyan.value.toRadixString(16).substring(2)}";
}

class SelectContextMenu {
  bool isshow = false;
  InAppWebViewController webViewController;
  // ignore: non_constant_identifier_names
  late OverlayEntry GlobalUIoverlayEntry;

  SourceMap id;

  SelectContextMenu(
      {required this.isshow,
      required this.webViewController,
      required this.id});
  void close() {
    if (isshow != true) {
      return;
    }
    GlobalUIoverlayEntry.remove();
    isshow = false;

    var source = '''
  currentContents.document.getSelection().removeAllRanges();
''';
    webViewController.evaluateJavascript(source: source);
    // webViewController.clearFocus();
    // webViewController.requestFocusNodeHref();
  }

  ///获取选择文本
  Future<String> getSelection() async {
    return await webViewController.evaluateJavascript(
        source: 'currentContents.document.getSelection().toString();');
  }

  ///主题切换
  changeTheme(Themetype themetype) {
    webViewController.evaluateJavascript(
        source: 'rendition.themes.select("雷云");');
  }

  ///划线
  underLine({required String color}) async {
    if (kDebugMode) {
      print(color);
    }
    //获取所选择文本

    String selectText =
        await webViewController.evaluateJavascript(source: 'currentText;');
    final currentCfg =
        await webViewController.evaluateJavascript(source: 'currentCfg;');
    print(currentCfg);


    

    saveNote(id: "${id.id}", map: {
      "id": "${id.id}",
      "cfg": currentCfg.toString(),
      "text": selectText.replaceAll("\n", "").toString(),
      "note": "空_",
      "color": color
    });

    ReaderThemeC.current.webViewController.evaluateJavascript(source: '''
rendition.annotations.remove("$currentCfg", 'highlight');
                                onUnderline("$currentCfg","$color","${selectText.replaceAll("\n", "").toString()}","");
''');

   //  webViewController.evaluateJavascript(source: '划线("$color");');
  }

  ///写笔记
  writeNote(txt) async {
    if (txt.toString().trim() == "") {
      BotToast.showText(text: "所选内容不能为空");
      return;
    }
    String selectText =
        await webViewController.evaluateJavascript(source: 'currentText;');
    final currentCfg =
        await webViewController.evaluateJavascript(source: 'currentCfg;');
   TextEditingController textEditingController = TextEditingController();
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
                                  saveNote(id: "${id.id}", map: {
                                    "id": "${id.id}",
                                    "cfg": currentCfg.toString(),
                                    "text": txt.replaceAll("\n", ""),
                                    "note": ReaderThemeC.current.inputvalue.value,
                                    "color":  UnderLinecolor().cyan
                                  });

                                  ReaderThemeC.current.webViewController.evaluateJavascript(source: '''
rendition.annotations.remove("$currentCfg", 'highlight');
                                onUnderline("$currentCfg","${UnderLinecolor().cyan}","${ txt.replaceAll("\n", "")}","${textEditingController.text}");
''');
                                  BotToast.showText(text: "保存成功");
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

  //下一页
  nextpage() {
    ReaderThemeC.current.pageTurnAnimation.value
        ? webViewController.evaluateJavascript(source: '下一页(300);')
        : webViewController.evaluateJavascript(
            source: 'rendition.next();'); //里面的参数是动画师长
  }

  //上一页
  prevpage() {
    ReaderThemeC.current.pageTurnAnimation.value
        ? webViewController.evaluateJavascript(source: '上一页(300);')
        : webViewController.evaluateJavascript(
            source: 'rendition.prev();'); //里面的参数是动画师长
  }

  void show(offset, context, InAppWebViewController webviewcontroller) {
    if (isshow == true) {
      return;
    }
    GlobalUIoverlayEntry = OverlayEntry(builder: (context) {
      return GestureDetector(
          onTap: () {
            if (kDebugMode) {
              print("哈哈");
            }
            close();
          },
          child: TextSelectionToolbar(
              anchorAbove: offset,
              anchorBelow: offset,
              children: [
                ///复制文本
                ///
                TextSelectionToolbarTextButton(
                    padding: TextSelectionToolbarTextButton.getPadding(0, 5),
                    onPressed: () async {
                      String txt = await getSelection();
                      writeNote(txt);
                      close();
                    },
                    child: const Text("写笔记")),
                TextSelectionToolbarTextButton(
                  padding: TextSelectionToolbarTextButton.getPadding(0, 1),
                  onPressed: () async {
                    if (kDebugMode) {
                      print(await getSelection());
                    }
                    Clipboard.setData(
                        ClipboardData(text: await getSelection()));
                    BotToast.showText(text: "已复制");
                    close();
                  },
                  child: const Text("复制"),
                ),

                TextSelectionToolbarTextButton(
                  padding: TextSelectionToolbarTextButton.getPadding(0, 3),
                  onPressed: () async {
                    underLine(color: UnderLinecolor().red);
                    close();
                  },
                  child: const Icon(
                    Icons.format_color_text,
                    color: Colors.red,
                  ),
                ),
                TextSelectionToolbarTextButton(
                  padding: TextSelectionToolbarTextButton.getPadding(0, 4),
                  onPressed: () async {
                    underLine(color: UnderLinecolor().blue);
                    close();
                  },
                  child: const Icon(
                    Icons.format_color_text,
                    color: Colors.blue,
                  ),
                ),
                TextSelectionToolbarTextButton(
                  padding: TextSelectionToolbarTextButton.getPadding(0, 5),
                  onPressed: () async {
                    underLine(color: UnderLinecolor().amber);
                    close();
                  },
                  child: const Icon(
                    Icons.format_color_text,
                    color: Colors.amber,
                  ),
                ),
                TextSelectionToolbarTextButton(
                  padding: TextSelectionToolbarTextButton.getPadding(0, 5),
                  onPressed: () async {
                    underLine(color: UnderLinecolor().cyan);
                    close();
                  },
                  child: const Icon(
                    Icons.format_color_text,
                    color: Colors.cyan,
                  ),
                )
              ]));
    });
    Overlay.of(context).insert(GlobalUIoverlayEntry);
    isshow = true;
  }
}
