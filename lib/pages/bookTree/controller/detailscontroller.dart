import 'dart:convert';
import 'dart:developer';

import 'package:get/get.dart';

import '../../../common/network/findbookApi.dart';
import '../../../public/public_class_bean.dart';
import '../../../public/public_function.dart';

class DetailsController extends GetxController {
  static DetailsController get current => Get.find<DetailsController>();

  Rx<BookInfoMap> bookinfoData = BookInfoMap().obs;
  RxList bookDownloadList = [].obs;
  int id = 0;
  double step = 0;
  RxInt progress = 0.obs;

  RxString bookImage = "".obs;

  RxInt bookid = 0.obs;
  //
  RxMap bookinfo = {}.obs;

  RxList bookFileList = [].obs;


  int currentindex = 0;
  int index = 0;
  setDetails({bookid,bookimage}){
    bookImage.value = bookimage;
    this.bookid.value = bookid;
  }


  
  var ietmid ;
  
  initdata({ietmid}) async{
    this.ietmid = ietmid;
     var data = {"ietm_id": ietmid};
    var reponse = await FindBookApi.geTdownloadRes(data);
    var jsondata = json.decode(reponse.data);
    bookinfo.value = jsondata;
    bookFileList.value = jsondata["data"];
    bookinfo.refresh();
    bookFileList.refresh();
    
  }

  shuaxin() {
   
   if(id!=0){
     step = 0;
    DetailsController.current.id = id;

    DetailsController.current.bookinfoData.value = getBookInfoidMap(id: id);
    print(id.toString());
    DetailsController.current.bookDownloadList.value =
        getBookDownloadList(id: id);

    DetailsController.current.bookDownloadList.map((e) {
      SourceMap sourceMap = getsourceidMap(id: e["id"]);
      step = step + sourceMap.progress;
    }).toList();

    progress.value =
        (step ~/ DetailsController.current.bookDownloadList.length).toInt();
    saveBookInfo(
        id: DetailsController.current.bookDownloadList[0]["ietm_id"],
        map: {"LearningRate": progress.value});

    bookDownloadList.refresh();
    bookinfoData.refresh();
   }
 
  }
}
