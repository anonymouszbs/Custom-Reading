import 'dart:async';
import 'dart:io';
import 'dart:typed_data';

import 'package:bot_toast/bot_toast.dart';
import 'package:ceshi1/common/commpents/reader/contants/theme.dart';
import 'package:ceshi1/common/commpents/reader/reader_view.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:flutter_tesseract_ocr/flutter_tesseract_ocr.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';

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
  Future<String> ocr() async {
    Directory tempDir = await getTemporaryDirectory();
    Uint8List? bytes =
        await ReaderThemeC.current.webViewController.takeScreenshot();
    String dir = tempDir.path;

    File file = File('$dir/test.webp');
    await file.writeAsBytes(bytes!);
    final url = file.path;
    var ocrText = await FlutterTesseractOcr.extractText(url,
        language: "chi_sim",
        args: {
          "psm": "2",
          "preserve_interword_spaces": "1",
        });

    return ocrText.replaceAll(RegExp(r" "), "");
  }

  startPlay() async {
    var result = 0;
    var readText;
    readText = await ocr();
    if(readText==""){
        readText = "翻页";
    }


    result = await FloatController.current.speak(readText);

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
      Timer(const Duration(milliseconds: 1000),(){
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
