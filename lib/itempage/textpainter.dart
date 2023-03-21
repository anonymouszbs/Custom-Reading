import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutterdemo1/itempage/pagebreaker.dart';

import '../DisplayConfig.dart';
import 'Selectabletextcontroller.dart';

DisplayConfig config = DisplayConfig.getDefault();

class TextPage extends StatelessWidget {
  final YdPage? ydPage;

  TextPage({Key? key, this.ydPage}) : super(key: key);
  final textStyle = TextStyle(
    color: Color(config.textColor),
    fontSize: config.textSize,
    fontWeight: config.isTextBold == 1 ? FontWeight.bold : FontWeight.normal,
    fontFamily: config.fontPath,
    height: config.lineSpace,
  );
  @override
  Widget build(BuildContext context) {
    if (ydPage == null) {
      return const Center(
        child: Text(''),
      );
    }

    return ydPage!.image == null
        ? SelectableText(
            ydPage!.text!,
            style: textStyle,
            toolbarOptions: ToolbarOptions(
              cut: true,
              paste: true,
              selectAll: true,
            
            ),
           selectionControls: MyTextSelectionControls(),
            
          )
        : Container(
            height: ScreenUtil().screenHeight,
            padding: EdgeInsets.only(
                left: config.marginLeft,
                top: config.marginTop,
                right: config.marginRight,
                bottom: config.marginBottom),
            child: Image.file(
              File(ydPage!.image![0].toString()),
              fit: BoxFit.fill,
            ),
          );
  }
}
