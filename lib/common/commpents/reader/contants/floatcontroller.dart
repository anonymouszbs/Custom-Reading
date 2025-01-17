import 'dart:async';
import 'package:ceshi1/common/commpents/reader/contants/theme.dart';
import 'package:ceshi1/public/public_class_bean.dart';
import 'package:ceshi1/public/public_function.dart';
import 'package:ceshi1/untils/sp_util.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
// import 'package:flutter_tesseract_ocr/flutter_tesseract_ocr.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:get/get.dart';


enum TtsState { playing, stopped, paused, continued }

class FloatStyle {
  double volume = 1.0, rate = 0.5;
  bool isshow = false;

  late TtsState ttsState = TtsState.stopped;
}

class FloatController extends GetxController {
  static FloatController get current => Get.find<FloatController>();
  Rx<FloatStyle> floatStyle = FloatStyle().obs;
  Rx<bool> isshow = false.obs;
  Rx<TtsState> ttsState = TtsState.stopped.obs;
  FlutterTts flutterTts = FlutterTts();
  RxInt time = 3000.obs;
  RxBool isShowReadView = false.obs;
  RxDouble progress = 0.0.obs;

  Rx<String> booknmae = "".obs;

  late InAppWebViewController webViewController;

  //这里用来判断用户是否点了跳转目录

  RxBool onToc = false.obs;

  String readtextactive = "";
  String readtext = "";
  //记录原来位置 回到原来位置时再ontac=tfalse 再记录进度
  String currentlocation = "";

  ///保存用户进度
  ///
  saveBooksourcesProgress({id, cfi, required double progress}) {
    print(progress);
    final sourcesid = getsourceid(id: id);

    if (onToc.value == false) {
      if (SpUtil.containsKey(sourcesid) == false) {
        saveSource(id: id, map: {
              "id": id,
              "progress": progress,
              "cfi": [cfi.toString()]
            });
        
      } else {
        SourceMap sourceMap = getsourceidMap(id: id);
        List<String> listcfi = sourceMap.cfi;
       
        if (progress >=
            sourceMap.progress) {
         
          if (sourceMap.cfi.contains(cfi.toString()) == false) {
            listcfi.add(cfi);
           saveSource(id: id, map: {
                "progress":progress,
                "cfi":listcfi
            });
           
          }
        }
      }
    }
  }

  // Future<String> ocr() async {
  //   Directory tempDir = await getTemporaryDirectory();
  //   Uint8List? bytes =
  //       await ReaderThemeC.current.webViewController.takeScreenshot();
  //   String dir = tempDir.path;

  //   File file = File('$dir/test.webp');
  //   await file.writeAsBytes(bytes!);
  //   final url = file.path;
  //   var ocrText =
  //       await FlutterTesseractOcr.extractText(url, language: "chi_sim", args: {
  //     "psm": "2",
  //     "preserve_interword_spaces": "1",
  //   });

  //   return ocrText.replaceAll(RegExp(r" "), "");
  // }

  removeSimilarParagraphs(String text1, String text2) {
    // Split text into paragraphs
    String replacetxt = "";
    List<String> paragraphs1 = text1.split('\n');
    List<String> paragraphs2 = text2.split('\n');
    for (var i = 0; i < paragraphs1.length; i++) {
      if (paragraphs2[0].contains(paragraphs1[i].toString().trim())) {
        replacetxt = paragraphs1[i].toString().trim();
        break;
      }
    }
    if (replacetxt == "") {
      return text2;
    } else {
      return text2.replaceFirst(replacetxt, "");
    }
  }

  startPlay() async {
    var result = 0;
  print(removeSimilarParagraphs(readtextactive, readtext));
    // print(removeSimilarParagraphs(readtextactive, readtext));
    result = await FloatController.current
        .speak(removeSimilarParagraphs(readtextactive, readtext));
    readtextactive = readtext;
  }

  Future speak(text) async {
    await flutterTts.setVolume(floatStyle.value.volume);
    await flutterTts.setSpeechRate(floatStyle.value.rate);

    if (text != null) {
      if (text!.isNotEmpty) {
        var result = await flutterTts.speak(text!);
        return result;
      } else {
        return 1;
      }
    } else {
      return 1;
    }
  }

  ///暂停播放
  Future pause() async {
    var result = await flutterTts.pause();
    if (result == 1) {
      ttsState.value = TtsState.paused;
    }
  }

  ///结束播放
  Future stop() async {
    var result = await flutterTts.stop();
    if (result == 1) {
      ttsState.value = TtsState.stopped;
    }
  }

  ///初始化的东西完全不需要在意
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    _setAwaitOptions();
    _getDefaultEngine();
    _getDefaultVoice();

    flutterTts.setStartHandler(() {
      ttsState.value = TtsState.playing;
    });

    flutterTts.setInitHandler(() {
      print("tts初始化成功");
    });

    flutterTts.setCompletionHandler(() {
      ttsState.value = TtsState.stopped;
      ReaderThemeC.current.selectContextMenu.nextpage();
      Timer(const Duration(milliseconds: 1000), () {
        startPlay();
      });
    });

    flutterTts.setCancelHandler(() {
      ttsState.value = TtsState.stopped;
    });

    flutterTts.setPauseHandler(() {
      ttsState.value = TtsState.paused;
    });

    flutterTts.setContinueHandler(() {
      ttsState.value = TtsState.continued;
    });

    flutterTts.setErrorHandler((msg) {
      ttsState.value = TtsState.stopped;
    });
  }

  Future _setAwaitOptions() async {
    await flutterTts.awaitSpeakCompletion(true);
  }

  Future _getDefaultVoice() async {
    var voice = await flutterTts.getDefaultVoice;
    if (voice != null) {
      print(voice);
    }
  }

  Future _getDefaultEngine() async {
    var engine = await flutterTts.getDefaultEngine;
    if (engine != null) {
      print(engine);
    }
  }
}
