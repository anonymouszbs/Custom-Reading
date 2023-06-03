import 'dart:convert';
import 'dart:io';

import 'package:al_downloader/al_downloader.dart';
import 'package:bot_toast/bot_toast.dart';
import 'package:ceshi1/common/network/ApiServices.dart';
import 'package:ceshi1/config/dataconfig/normal_string_config.dart';
import 'package:ceshi1/public/public_function.dart';
import 'package:ceshi1/untils/sp_util.dart';
import 'package:flutter_ffmpeg/flutter_ffmpeg.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';

import 'findbookApi.dart';

class DonwloadSource extends GetxController {
  static DonwloadSource get current => Get.find<DonwloadSource>();
  //所有资源的保存路径
  String sourcePath = "";

  RxList taskList = [].obs;

  RxList bookListData = [[], [], []].obs;

  final FlutterFFmpeg flutterFFmpeg = FlutterFFmpeg();

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

  donwload({ietmid, index, currentIndex}) async {
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

      if (urllist.isEmpty) {
        taskList.removeAt(taskId);
        taskList.refresh();
        return;
      }
      ALDownloaderBatcher.download(urllist,
          downloaderHandlerInterface:
              ALDownloaderHandlerInterface(progressHandler: (progress) {
            print(progress);
            taskList[taskId]["progress"] = progress;
            taskList.refresh();
          }, succeededHandler: () async {
            data.asMap().keys.map((e) async {
              //直接创建资源id 已经进度
              final sourcesid = getsourceid(id: data[e]["id"]);

              if (findKey(id: sourcesid) == false) {
                saveSource(id:  data[e]["id"], map: {
                  "id": data[e]["id"],
                  "progress": 0.0,
                  "cfi": [""],
                  "duration": 0
                });
              }

              String? filepath =
                  await ALDownloaderFileManager.getPhysicalFilePathForUrl(
                      urllist[e]);
              saveSources[e]["FilePath"] = filepath;

              saveSources[e]["LearningRate"] = 0; //初始进度
              if (saveSources[e]["ResourceType"] == "mp4" ||
                  saveSources[e]["ResourceType"] == "mp3") {
                var result =
                    await FlutterFFprobe().getMediaInformation(filepath!);
                int durationInMilliseconds =
                    double.parse(result.getMediaProperties()!['duration'])
                        .toInt();
                Duration duration = Duration(seconds: durationInMilliseconds);

                saveSources[e]["Size"] = duration.toString().split('.').first;
              }

              if (e == data.length - 1) {
                saveBooksources(
                    data: saveSources, ietmid: ietmid, bookinfo: jsondata);
                bookListData[currentIndex][index]["download"] = true;
                bookListData.refresh();
              }
            }).toList();

            //=保存记录

            taskList[taskId]["ispause"] = true;
            taskList[taskId]["isdownload"] = true;

            taskList.refresh();
            BotToast.showText(text: "${jsondata["ietm_name"]}  下载完成!");
          }, failedHandler: () {
            taskList.removeAt(taskList.length - 1);
            BotToast.showText(text: "下载失败,请检查网络");
          }, pausedHandler: () {
            BotToast.showText(text: "下载暂停,请检查网络");
          }));
    }
  }

  //创建文件
  createFile() async {
    String path = '${sourcePath}1.txt';

    var file = File(path);
    file.writeAsStringSync("哈哈哈哈哈哈");
  }

  //获取路径
  Future<String> getIndexHtmlPath() async {
    Directory cache = await getTemporaryDirectory();
    return '${cache.path}/assets/epub/';
  }

  //保存书籍下载目录到本地数据库
  Future<void> saveBooksources({data, ietmid, bookinfo}) async {
    var downloadsaveid = getBookDownloadid(id: ietmid);

    var bookinfosaveid = getBookInfoid(id: ietmid);
    Map bookinfodata = {
      "ietm_id": ietmid,
      "ietm_name": bookinfo["ietm_name"],
      "parentnodeid": bookinfo["parentnodeid"],
      "user_nick": bookinfo["user_nick"],
      "CreateTime": bookinfo["CreateTime"],
      "Introduction": bookinfo["Introduction"],
      "LearningRate": 0
    };

    if (findKey(id: bookinfosaveid) == false) {
      
      saveBookInfo(id: ietmid, map: bookinfodata);
    }

    if (findKey(id: downloadsaveid) == false) {
      SpUtil.putObjectList(
          downloadsaveid, List.castFrom<dynamic, Object>(data));
    } else {
      BotToast.showText(text: "已经下载过本资源，无需重复下载");
    }
  }
}

typedef DownloadProgressCallBack = Function(int count, int total);
