import 'dart:io';

import 'package:ceshi1/config/dataconfig/pageid_config.dart';
import 'package:ceshi1/pages/login/routers/login_page_id.dart';
import 'package:flutter/services.dart';
import 'dart:ui' as ui;

import '../common/App/common_sp_util.dart';

class UtilsToll {
  //配置入口
  static configrootpageid() {
    String rootroute = PageIdConfig.home;
    // ignore: unused_local_variable
    int intal = CommonSpUtil.getfirstinstal();

    rootroute = LoginPageId.login;
    return rootroute;
  }

  //获取图片第一帧
  static Future loadAssetImage(String path) async {
    final data = await rootBundle.load(path);
    final bytes = data.buffer.asUint8List();
    final codec = await ui.instantiateImageCodec(bytes);
    final frameInfo = await codec.getNextFrame();
    // print('帧数数量：${codec.frameCount}');
    // print('持续时间：${frameInfo.duration * frameCount}');
    return frameInfo.image.toByteData(format: ui.ImageByteFormat.png);
  }

  ///判断包中包是否searchvalue;
  static findkeysOrvalues(Map<dynamic, dynamic> map, String searchValue) {
    return findKey(map, searchValue);
  }

  static bool findKey(Map<dynamic, dynamic> map, String searchValue) {
    for (final key in map.keys) {
      final value = map[key];

      if (value == searchValue) {
        return true;
      } else if (value is Map<dynamic, dynamic>) {
        final result = findKey(value, searchValue);
        if (result == true) {
          return true;
        }
      }
    }

    return false;
  }

//移动文件 到另外一个目录

  void copyFiles({String? sourcePath, String? destinationPath}) {
    // 获取源目录下的所有文件列表
    File source = File(sourcePath!);

    Directory destination = Directory(destinationPath!);
    source.copy('${destination.path}/${source.path.split('/').last}');
  }

  void listFiles(String path) async {
    var dir = Directory(path);
    var files = await dir.list().where((entity) => entity is File).toList();

    for (var file in files) {
      print(file.path);
    }
  }

  //横屏
  static void ladnspaceScree() {
    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.landscapeLeft, DeviceOrientation.landscapeRight]);
  }

  //竖屏
  static void verticalScreen() {
    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  }
}
