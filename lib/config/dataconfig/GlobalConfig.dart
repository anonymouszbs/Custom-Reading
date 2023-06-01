import 'package:al_downloader/al_downloader.dart';
import 'package:ceshi1/untils/sp_util.dart';
import 'package:flutter/services.dart';

import '../../common/commpents/reader/utils/utilstool.dart';

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
    //服务器资源复制到本地
    await copyDemoToSandBox();

    
    //服务器初始化
    await startserver(); 
    //下载器初始化
    ALDownloader.initialize();
  }
  ///初始化默认数据
  static initnormaldata() async {

  }
}