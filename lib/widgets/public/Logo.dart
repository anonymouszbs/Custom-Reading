

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Widget APPLOGO(){
  return SizedBox(
    width:ScreenUtil().setWidth(115) ,
    height:ScreenUtil().setHeight(59) ,
    child: Text("Logo",style: TextStyle(color: const Color(0xff8B8B8B),fontSize: ScreenUtil().setSp(42),fontWeight: FontWeight.bold),),
  );
}