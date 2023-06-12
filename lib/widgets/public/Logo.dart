

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Widget APPLOGO(){
  return SizedBox(
    width:ScreenUtil().setWidth(140) ,
    height:ScreenUtil().setHeight(150) ,
    child: Column(
      children: [
        Image.asset("assets/img/logo.png"),
        Text("IETM 电子教材",style: TextStyle(color: const Color(0xff8B8B8B),fontSize: ScreenUtil().setSp(20),fontWeight: FontWeight.bold),)
      ],
    ),
  );
}