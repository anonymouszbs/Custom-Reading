



import 'package:flutter/material.dart';

Widget Ykttext({text,color,fontsize,bold}){
  return Text(text,style: TextStyle(color: color,fontSize: fontsize,fontWeight:bold,),maxLines: 2,);
}