import 'package:ceshi1/untils/sp_util.dart';
import 'package:flutter/services.dart';

class GlobalConfig{
  //系统初始化
  static init()async{
   
    ///横屏初始化
    SystemChrome.setPreferredOrientations([
     DeviceOrientation.landscapeLeft,
     DeviceOrientation.landscapeRight
   ]);
    await initthirdparty();
  }
 /// 其他插件初始化
  static initthirdparty()async{
    await SpUtil.getInstance();
  }
  ///初始化默认数据
  static initnormaldata() async {

  }
}