import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:get/get.dart';

import '../../../../widgets/SelectContextMenu.dart';

class ReaderTheme {
  final Color readerBackgroundColor;
  final Color readerTextColor;
  final Color readerInfoColor;
  final Color pannelBackgroundColor;
  final Color pannelTextColor;
  final Color primaryColor;
  final Color dividerColor;
  final Color pannelContainerColor;
  final Color pannelContainerColorSelected;
  final String name;
  final String key;

  ReaderTheme(
      {required this.readerBackgroundColor,
      required this.readerTextColor,
      required this.readerInfoColor,
      required this.pannelBackgroundColor,
      required this.pannelTextColor,
      required this.primaryColor,
      required this.dividerColor,
      required this.pannelContainerColor,
      required this.pannelContainerColorSelected,
      required this.name,
      required this.key});
}

final ama = ReaderTheme(
    name: "观云",
    key: 'ama',
    readerBackgroundColor: const Color(0xfff6f1e7),
    readerTextColor: const Color(0xff262626),
    readerInfoColor: const Color(0xff96928c),
    pannelBackgroundColor: const Color(0xfffbfaf5),
    pannelTextColor: const Color(0xff262626),
    primaryColor: const Color(0xffebcd8b),
    dividerColor: const Color(0xffdbd6cd),
    pannelContainerColor: const Color(0xfff3f0e8),
    pannelContainerColorSelected: const Color(0xfff9f4ea));

final hashibami = ReaderTheme(
    name: "榛子",
    key: 'hashibami',
    readerBackgroundColor: const Color(0xfff4e9c8),
    readerTextColor: const Color(0xff262626),
    readerInfoColor: const Color(0xff908b76),
    pannelBackgroundColor: const Color(0xfff9f1da),
    pannelTextColor: const Color(0xff262626),
    primaryColor: const Color(0xffebcd8b),
    dividerColor: const Color(0xffd8d0b0),
    pannelContainerColor: const Color(0xffeae1c8),
    pannelContainerColorSelected: const Color(0xfff2e7c7));

final usuao = ReaderTheme(
    name: "青云",
    key: 'usuao',
    readerBackgroundColor: const Color(0xffe5f0e4),
    readerTextColor: const Color(0xff262626),
    readerInfoColor: const Color(0xff959e95),
    pannelBackgroundColor: const Color(0xfff4fbf4),
    pannelTextColor: const Color(0xff262626),
    primaryColor: const Color(0xff85e285),
    dividerColor: const Color(0xffcad5ca),
    pannelContainerColor: const Color(0xffe1ece1),
    pannelContainerColorSelected: const Color(0xffe2ede1));

final chigusa = ReaderTheme(
    name: "千草",
    key: 'chigusa',
    readerBackgroundColor: const Color(0xffe0edf1),
    readerTextColor: const Color(0xff262626),
    readerInfoColor: const Color(0xff879092),
    pannelBackgroundColor: const Color(0xffe7f5f6),
    pannelTextColor: const Color(0xff262626),
    primaryColor: const Color(0xff87cde1),
    dividerColor: const Color(0xffc7d1d5),
    pannelContainerColor: const Color(0xffe2eaec),
    pannelContainerColorSelected: const Color(0xffdfecf0));

final sekichiku = ReaderTheme(
    name: "石竹",
    key: 'sekichiku',
    readerBackgroundColor: const Color(0xfff0dfdf),
    readerTextColor: const Color(0xff262626),
    readerInfoColor: const Color(0xff9d9292),
    pannelBackgroundColor: const Color(0xfffaeceb),
    pannelTextColor: const Color(0xff262626),
    primaryColor: const Color(0xffe98989),
    dividerColor: const Color(0xffd8c9c9),
    pannelContainerColor: const Color(0xfff3e1e1),
    pannelContainerColorSelected: const Color(0xfff2e1e1));

final namari = ReaderTheme(
    name: "铅色",
    key: 'namari',
    readerBackgroundColor: const Color(0xffdcdcdc),
    readerTextColor: const Color(0xff262626),
    readerInfoColor: const Color(0xff868686),
    pannelBackgroundColor: const Color(0xffe7e7e7),
    pannelTextColor: const Color(0xff262626),
    primaryColor: const Color(0xffababab),
    dividerColor: const Color(0xffc6c5c6),
    pannelContainerColor: const Color(0xffe2e2e2),
    pannelContainerColorSelected: const Color(0xffdadada));

final karasubo = ReaderTheme(
    name: "雷云",
    key: 'karasubo',
    readerBackgroundColor: const Color(0xff1a1c1d),
    readerTextColor: const Color(0xff808080),
    readerInfoColor: const Color(0xff7e7e7e),
    pannelBackgroundColor: const Color(0xff17191a),
    pannelTextColor: const Color(0xff999999),
    primaryColor: const Color(0xff0f1112),
    dividerColor: const Color(0xff444444),
    pannelContainerColor: const Color(0xff202122),
    pannelContainerColorSelected: const Color(0xff181a1b));

final readerThemeList = [ama, hashibami, usuao, chigusa, sekichiku, namari, karasubo];



class ReaderThemeC extends GetxController{
  static ReaderThemeC get current => Get.find<ReaderThemeC>();
  late InAppWebViewController webViewController;
  late SelectContextMenu selectContextMenu;
  GlobalKey screenshotKEY  = GlobalKey();
  Rx<ReaderTheme> theme = readerThemeList[0].obs;
  Rx<int> currentindex = 3.obs;
  Rx<String> currentTitle = "".obs;
  Rx<double> readerFontSize = 22.0.obs;
  Rx<bool> pageTurnAnimation = true.obs;
  ScrollController scrollController = ScrollController(keepScrollOffset: true,initialScrollOffset: 100);
  changeTheme(type){
    theme = type;
  }
  
 
 
}