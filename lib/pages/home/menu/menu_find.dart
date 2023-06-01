import 'package:bot_toast/bot_toast.dart';
import 'package:ceshi1/pages/home/menu/menu_find_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../widgets/public/textwidget.dart';

class MenuTypeList extends StatefulWidget {
  const MenuTypeList({super.key});

  @override
  State<MenuTypeList> createState() => _MenuTypeListState();
}

class _MenuTypeListState extends State<MenuTypeList>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  final List<String> options = ['Option 1', 'Option 2', 'Option 3'];
  String dropdownValue = 'Option 1';

  @override
  void initState() {
    super.initState();
    BotToast.showCustomNotification(toastBuilder: (tcancle){
      return Text("数据加载完毕");
    });
   
    _controller = AnimationController(vsync: this);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }



  @override
  Widget build(BuildContext context) {
    return  Container(
        padding: EdgeInsets.only(top: ScreenUtil().setHeight(28),left: ScreenUtil().setWidth(20),bottom:ScreenUtil().setHeight(28) ),
        alignment: Alignment.topLeft,
        width: ScreenUtil().setWidth(1116),
        height: ScreenUtil().setHeight(961),
        child:const MenuFindBar() ,
       );
  }
}
