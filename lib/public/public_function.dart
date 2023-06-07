import 'package:ceshi1/common/commpents/reader/contants/floatcontroller.dart';
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

String getNoteId({id}){
   return "${NormalFlagIdConfig.noteId}$id";
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


void saveNote({required id,required map}){

  print(map);
  String noteId = getNoteId(id: "$id");
  List ceshi;
  if(findKey(id: noteId)==true){
    Map jmap = SpUtil.getObject(noteId)!;
    jmap["id"] = map["id"];
    List cfg = jmap['cfg'];
    List text = jmap["text"];
    List note = jmap["note"];
    List color = jmap["color"];

    if(cfg.contains(map["cfg"])==true){
       print("已保存");
      int cfgindex = cfg.indexOf(map["cfg"]);
      text[cfgindex] = map["text"];
      note[cfgindex] = map["note"]==""?"空_":map["note"];
      color[cfgindex] = map["color"];
      SpUtil.putObject(noteId, Map.castFrom({"id":map["id"],"bookname":FloatController.current.booknmae.value,"cfg":cfg,"text":text,"note":note,"color":color}));
    }else{
      cfg.add(map["cfg"]);
      text.add(map['text']);
      note.add(map["note"]==""?"空_":map["note"]);
      color.add(map["color"]);
      SpUtil.putObject(noteId, Map.castFrom({"id":map["id"],"bookname":FloatController.current.booknmae.value,"cfg":cfg,"text":text,"note":note,"color":color}));
    }
    // if(jmap["cfg"].contains(map["cfg"])==true){
    //   print("已保存");
    //   int cfgindex = jmap["cfg"].indexOf(map["cfg"]);
    //   jmap["text"][cfgindex] = map["text"]==""?"空_":map["text"];
    //   jmap["note"][cfgindex] =map["note"]==""?"空_":map["note"];
    // }else{
    //   jmap["cfg"] = jmap["cfg"].add(map["cfg"]==""?"空_":map["cfg"]);
    //   jmap["text"] = jmap["text"].add(map["text"]==""?"空_":map["text"]);
    //   jmap["note"] = jmap["note"].add(map["note"]==""?"空_":map["note"]);
    // }
    
    // SpUtil.putObject(noteId, Map.castFrom(jmap));
  }else{
    Map jmap =  {"id":map["id"],"bookname":FloatController.current.booknmae.value,"cfg":[map["cfg"]],"text":[map["text"]],"note":[map["note"].toString()==""?"空_":map["note"].toString(),],"color":[map["color"]]};
    // jmap["cfg"] = jmap["cfg"].add(map["cfg"]);
    // jmap["text"] =   jmap["text"].add(map["text"]);
    // jmap["note"] = jmap["note"].add(map["note"]);
    SpUtil.putObject(noteId, Map.castFrom(jmap));
  }
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
