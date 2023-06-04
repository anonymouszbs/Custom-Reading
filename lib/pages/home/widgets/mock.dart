import 'package:ceshi1/config/dataconfig/normal_string_config.dart';
import 'package:ceshi1/untils/sp_util.dart';
import 'package:sticky_and_expandable_list/sticky_and_expandable_list.dart';

import '../../../public/public_class_bean.dart';
import '../../../public/public_function.dart';

///
/// create some example data.
///
class MockData {
  ///return a example list, by default, we have 4 sections,
  ///each section has 5 items.
  static List<ExampleSection> getExampleSections(
      [int sectionSize = 10, int itemSize = 5]) {
    var sections = List<ExampleSection>.empty(growable: true);

    List<String> keys = [];

    SpUtil.getKeys()!.toList().map((e) {
      if (e.contains(NormalFlagIdConfig.noteId)) {
        keys.add(e.split("Id")[1]);
      }
    }).toList();

    keys.map((id) {
      BookInfoMap bookInfoMap = getBookInfoidMap(id: id);
      var info = SpUtil.getObject(getNoteId(id: id));

      List cfg = info!["cfg"];
      List note = info["note"];
      List<String> text1 = List<String>.from(info["text"]);

      var section = ExampleSection()
        ..header = "${bookInfoMap.ietmName}"
        ..items = text1
        ..text = text1
        ..cfg = cfg
        ..id = id
        ..note = note
        ..expanded = true;
        sections.add(section);
    }).toList();
return sections;
    //  BookInfoMap  bookInfoMap=  getBookInfoidMap(id: note["id"]);
    //  var bookname = bookInfoMap.ietmName; //书名

    // for (int i = 0; i < sectionSize; i++) {
    //   var section = ExampleSection()
    //     ..header = "Header#$i"
    //     ..items = List.generate(itemSize, (index) => "ListTile #$index")
    //     ..expanded = true;
    //   sections.add(section);
    // }
    // return sections;
  }
}

///Section model example
///
///Section model must implements ExpandableListSection<T>, each section has
///expand state, sublist. "T" is the model of each item in the sublist.
class ExampleSection implements ExpandableListSection<String> {
  //store expand state.
  late bool expanded;

  //return item model list.
  late List<String> items;

  //example header, optional
  late String header;

  late String id;
  late List cfg;
  late List note;
  late List text;

  @override
  List<String> getItems() {
    return items;
  }

  @override
  bool isSectionExpanded() {
    return expanded;
  }

  @override
  void setSectionExpanded(bool expanded) {
    this.expanded = expanded;
  }
}
