import 'dart:convert';
import 'dart:io';

import 'package:al_downloader/al_downloader.dart';
import 'package:bot_toast/bot_toast.dart';
import 'package:ceshi1/common/network/ApiServices.dart';
import 'package:ceshi1/config/dataconfig/normal_string_config.dart';
import 'package:ceshi1/untils/sp_util.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';

import 'findbookApi.dart';

class DonwloadSource extends GetxController {
  static DonwloadSource get current => Get.find<DonwloadSource>();
  //所有资源的保存路径
  String sourcePath = "";

  RxList taskList = [].obs;

  @override
  onInit() async {
    sourcePath = await getIndexHtmlPath();

    super.onInit();
  }

  
  pause({index}) {
    taskList[index]["ispause"] = true;
    ALDownloader.pause(taskList[index]["urllist"]);
  }

  start({index}) {
    taskList[index]["ispause"] = false;
    ALDownloader.download(taskList[index]["urllist"]);
  }

  donwload({ietmid}) async {
    var data = {"ietm_id": ietmid};
    var reponse = await FindBookApi.geTdownloadRes(data);
    var jsondata = json.decode(reponse.data);
    int taskId = 0;
    List<String> urllist = []; //下载地址列表
    List saveSources = [];
    if (jsondata['code'] == 1) {
      BotToast.showText(text: "开始下载${jsondata["ietm_name"]}");

      List data = jsondata["data"];
      data.map((e) {
        urllist.add(ApiService.AppUrl + e["FilePath"]);
        saveSources.add(e);
      }).toList();
      taskList.add({
        "ietm_name": jsondata["ietm_name"],
        "progress": 0.00,
        "ispause": false,
        "urllist": urllist,
        "isdownload": false
      });
      taskId = taskList.length - 1;
      

      // urllist.map((e)async{
      //   final physicalFilePath =
      //   await ALDownloaderFileManager.getPhysicalFilePathForUrl(e);
      //   if(physicalFilePath!.isNotEmpty){
      //     urllist.remove(e);
      //   }
      // }).toList();
      
      if(urllist.isEmpty){
        taskList.removeAt(taskId);
        return;
      }
      ALDownloaderBatcher.download(urllist,
          downloaderHandlerInterface:
              ALDownloaderHandlerInterface(progressHandler: (progress) {
                print(progress);
            taskList[taskId]["progress"] = progress;
          }, succeededHandler: () async {
            data.asMap().keys.map((e) async {
              saveSources[e]["FilePath"] =
                  await ALDownloaderFileManager.getPhysicalFilePathForUrl(
                      urllist[e]);
            });
            taskList[taskId]["ispause"] = false;
            taskList[taskId]["isdownload"] = true;
            saveBooksources(data: saveSources, ietmid: ietmid);
            BotToast.showText(text: "${jsondata["ietm_name"]}  下载完成!");
          }, failedHandler: () {
            taskList.removeAt(taskList.length - 1);
            BotToast.showText(text: "下载失败,请检查网络");
          }, pausedHandler: () {
            BotToast.showText(text: "下载暂停,请检查网络");
          }));
    }
  }

  //获取路径
  Future<String> getIndexHtmlPath() async {
    Directory cache = await getTemporaryDirectory();
    return '${cache.path}/assets/epub/';
  }

  //保存下载目录到本地数据库
  Future<void> saveBooksources({data, ietmid}) async {
    var saveid = "${NormalFlagIdConfig.bookDownload}$ietmid";

    if (SpUtil.containsKey(saveid) == false) {
      SpUtil.putObjectList(saveid, List.castFrom<dynamic, Object>(data));
    } else {
      BotToast.showText(text: "已经下载过本资源，无需重复下载");
    }
  }
}

typedef DownloadProgressCallBack = Function(int count, int total);
