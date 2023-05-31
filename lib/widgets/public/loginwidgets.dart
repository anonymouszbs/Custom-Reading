import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Widget LoginBg({child}) {
  return Container(
    alignment: Alignment.center,
    width: ScreenUtil().setWidth(510),
    height: ScreenUtil().setHeight(658),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(30),
      border: Border.all(
        color: Colors.grey,
        width: 1,
        style: BorderStyle.solid,
      ),
      gradient: const LinearGradient(
        colors: [
          Color.fromRGBO(255, 218, 128, 0.8),
          Color.fromRGBO(171, 255, 247, 0.5),
        ],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      color: Colors.white.withOpacity(0.3),
    ),
    child: Container(
      child: child,
      width: ScreenUtil().setWidth(498),
      height: ScreenUtil().setHeight(646),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        border: Border.all(
          color: const Color.fromRGBO(255, 218, 128, 0.8),
          width: 1,
          style: BorderStyle.solid,
        ),
        gradient: const LinearGradient(
          colors: [
            Color.fromRGBO(0, 0, 0, 0.05),
            Color.fromRGBO(0, 0, 0, 0.22),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        color: Colors.white.withOpacity(0.2),
      ),
    ),
  );
}

Widget RegeditBg({child}) {
  return Container(
    alignment: Alignment.center,
    width: ScreenUtil().setWidth(510),
    height: ScreenUtil().setHeight(747),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(30),
      border: Border.all(
        color: Colors.grey,
        width: 1,
        style: BorderStyle.solid,
      ),
      gradient: const LinearGradient(
        colors: [
          Color.fromRGBO(255, 218, 128, 0.8),
          Color.fromRGBO(171, 255, 247, 0.5),
        ],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      color: Colors.white.withOpacity(0.3),
    ),
    child: Container(
      child: child,
      width: ScreenUtil().setWidth(498),
      height: ScreenUtil().setHeight(733),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        border: Border.all(
          color: const Color.fromRGBO(255, 218, 128, 0.8),
          width: 1,
          style: BorderStyle.solid,
        ),
        gradient: const LinearGradient(
          colors: [
            Color.fromRGBO(0, 0, 0, 0.05),
            Color.fromRGBO(0, 0, 0, 0.22),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        color: Colors.white.withOpacity(0.2),
      ),
    ),
  );
}

///输入框
///
Widget EditTextfield({textcontroller, hintext, icon, inputFormatters}) {
  return Container(
      width: ScreenUtil().setWidth(360),
      height: ScreenUtil().setHeight(60),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.0),
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Color.fromRGBO(255, 255, 255, 0),
            Color.fromRGBO(255, 255, 255, 0.12)
          ],
        ),
      ),
      child: TextField(
        controller: textcontroller,
        textAlignVertical: TextAlignVertical.bottom,
        style: const TextStyle(
          color: Colors.white,
        ),
        inputFormatters: inputFormatters,
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
          suffixIcon: GestureDetector(
            child: Padding(
              padding: const EdgeInsets.all(8),
              child: Image.asset(
                icon,
              ),
            ),
          ),
        ),
      ));
}
