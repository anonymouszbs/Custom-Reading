import 'package:ceshi1/config/dataconfig/pageid_config.dart';
import 'package:flutter/services.dart';
import 'dart:ui' as ui;

import '../common/App/common_sp_util.dart';

class UtilsToll {
  //配置入口
  static configrootpageid(){
    String rootroute = PageIdConfig.home;
    // ignore: unused_local_variable
    int intal = CommonSpUtil.getfirstinstal();
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
static  findkeysOrvalues(Map<dynamic, dynamic> map, String searchValue){
   return findKey(map,searchValue);

}
 static bool findKey(Map<dynamic, dynamic> map, String searchValue) {
  for (final key in map.keys) {
    final value = map[key];
    
    if (value == searchValue) {
      return true;
    } else if (value is Map<dynamic, dynamic>) {
      final result = findKey(value, searchValue);
      if (result==true) {
        return true;
      }
    }
  }
  
 return false;
}

}