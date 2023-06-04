


import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'ceshi.dart';

class MenuNotePage extends StatefulWidget {
  const MenuNotePage({super.key});

  @override
  State<MenuNotePage> createState() => _MenuNotePageState();
}

class _MenuNotePageState extends State<MenuNotePage> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: ScreenUtil().screenWidth,
      height: ScreenUtil().screenHeight,
      child:
      Stack(
        children: [
          ExampleCustomSectionAnimation()
        ],
      )
      );
  }
}