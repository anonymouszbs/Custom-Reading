import 'package:ceshi1/public/public_class_bean.dart';
import 'package:ceshi1/untils/sp_util.dart';

import '../config/dataconfig/normal_string_config.dart';

//id是否存在

bool? findKey({id}) {
  // List key = [NormalFlagIdConfig.bookDownload,NormalFlagIdConfig.bookInfoId,NormalFlagIdConfig.sourcesId];
  // bool isint = false;
  // key.map((e){
  //   if(SpUtil.containsKey("$e$id")==true){
  //     isint = true;
  //   }
  // }).toList();

  return SpUtil.containsKey("$id");
}

String getsourceid({id}) {
  return "${NormalFlagIdConfig.sourcesId}$id";
}

///获取书籍资源信息
SourceMap getsourceidMap({required id}) {
  Map map = SpUtil.getObject(getsourceid(id: "$id"))!;
  List<String> stringList = List<String>.from( map["cfi"]);
  print(stringList);


  map["cfi"] = stringList;
  SourceMap sourceMap =
      SourceMap.fromJson(map);
  return sourceMap;
}

String getBookInfoid({id}) {
  return "${NormalFlagIdConfig.bookInfoId}$id";
}

///获取书籍信息
BookInfoMap getBookInfoidMap({required id}) {
  String bookInfoMapid = getBookInfoid(id: "$id");
  BookInfoMap bookInfoMap =
      BookInfoMap.fromJson(SpUtil.getObject(bookInfoMapid)!);
  return bookInfoMap;
}

String getBookDownloadid({id}) {
  return "${NormalFlagIdConfig.bookDownload}$id";
}

///获取下载列表
List<Map<dynamic, dynamic>> getBookDownloadList({id}) {
  String bookDownloadId = getBookDownloadid(id: "$id");
  return SpUtil.getObjectList(bookDownloadId)!;
}

void saveSource({required id, required map}) {
  String sourceId = getsourceid(id: "$id");
  if (findKey(id: sourceId) == true) {
    Map jmap = SpUtil.getObject(sourceId)!;
    for (var value in map.entries) {
      jmap[value.key] = value.value;
    }
    SpUtil.putObject(sourceId, Map.castFrom(jmap));
  } else {
    SpUtil.putObject(sourceId, Map.castFrom(map));
  }
}

///保存书籍信息表  书籍总进度等
void saveBookInfo({required id, required Map map}) {
  
 String bookInfoId = getBookInfoid(id: "$id");
  if (findKey(id: bookInfoId) == true) {
    Map jmap = SpUtil.getObject(bookInfoId)!;
    for (var value in map.entries) {
      jmap[value.key] = value.value;
    }
    SpUtil.putObject(bookInfoId, Map.castFrom(jmap));
  } else {
    SpUtil.putObject(bookInfoId, Map.castFrom(map));
  }
}
