import 'package:bot_toast/bot_toast.dart';
import 'package:ceshi1/common/commpents/reader/contants/theme.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
enum Themetype{
  dark,
  light,
  tan
}

class UnderLinecolor{
  String red ="#${Colors.red.value.toRadixString(16).substring(2)}";
  String blue ="#${Colors.blue.value.toRadixString(16).substring(2)}";
  String amber ="#${Colors.amber.value.toRadixString(16).substring(2)}";
  String cyan ="#${Colors.cyan.value.toRadixString(16).substring(2)}";
}
class SelectContextMenu {
  bool isshow = false;
  InAppWebViewController webViewController;
  // ignore: non_constant_identifier_names
  late OverlayEntry GlobalUIoverlayEntry;

  SelectContextMenu(this.isshow, this.webViewController);
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
  Future<String> getSelection()async{
    return await webViewController.evaluateJavascript(source: 'currentContents.document.getSelection().toString();');
  }
  ///主题切换
  changeTheme(Themetype themetype){
    
    webViewController.evaluateJavascript(source: 'rendition.themes.select("雷云");');
  }
   ///划线
  underLine({required String color}){
    if (kDebugMode) {
      print(color);
    }
    webViewController.evaluateJavascript(source: '划线("$color");');
  }

  //下一页
  nextpage(){
   
    ReaderThemeC.current.pageTurnAnimation.value?webViewController.evaluateJavascript(source: '下一页(300);'):webViewController.evaluateJavascript(source: 'rendition.next();');//里面的参数是动画师长
  }
  //上一页
  prevpage(){
    ReaderThemeC.current.pageTurnAnimation.value?webViewController.evaluateJavascript(source: '上一页(300);'):webViewController.evaluateJavascript(source: 'rendition.prev();');//里面的参数是动画师长
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
                      nextpage();
                      close();
                    },
                    child: const Text("写笔记")),
                TextSelectionToolbarTextButton(
                  padding: TextSelectionToolbarTextButton.getPadding(0, 1),
                  onPressed: () async {
                    if (kDebugMode) {
                      print(await getSelection());
                    }
                    Clipboard.setData(ClipboardData(text: await getSelection()));
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
