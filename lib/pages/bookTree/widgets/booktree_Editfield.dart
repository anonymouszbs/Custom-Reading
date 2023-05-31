import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


Widget textDL() {
    return ShaderMask(
      blendMode: BlendMode.srcIn,
      shaderCallback: (Rect bounds) {
        return const LinearGradient(
          colors: [
            Color(0xFFFFFFFF),
            Color(0xFFA5A5A5),
          ],
          stops: [0.0, 1.0],
          begin: Alignment.centerRight,
          end: Alignment.centerLeft,
          tileMode: TileMode.clamp,
        ).createShader(bounds);
      },
      child: RichText(
          text: TextSpan(children: [
        TextSpan(
            text: "分类导航",
            style: TextStyle(
                fontSize: ScreenUtil().setSp(28), fontWeight: FontWeight.bold)),
      ])),
    );
  }

Widget EditTextfield({textcontroller, hintext,required  Function(String value)onTap}) {
  return Container(
      width: ScreenUtil().setWidth(284),
      height: ScreenUtil().setHeight(40),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.0),
        gradient: const LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Color.fromRGBO(255, 255, 255, 0),
            Color.fromRGBO(255, 255, 255, 0.15)
          ],
        ),
      ),
      child: TextField(
        controller: textcontroller,
        textAlignVertical: TextAlignVertical.bottom,
        style: const TextStyle(
          color: Colors.white,
        ),
        onChanged: (value){
          onTap(value);
        },
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
            borderSide: BorderSide.none,
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
            borderSide: BorderSide.none,
          ),
          filled: true,
          fillColor: Colors.transparent,
          hintText: hintext,
          hintStyle: TextStyle(
            color: Colors.grey.withOpacity(0.7),
          ),
        
        ),
      ));
}