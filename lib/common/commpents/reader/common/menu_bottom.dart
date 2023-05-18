import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../widgets/animation.dart';
import '../contants/theme.dart';

class MenuBottom extends StatelessWidget {
  const MenuBottom({super.key,required this.onTocTap, required this.onThemeStyleTap, required this.onProgressTap, required this.onFontTap,required this.onSettingsTap});
  final void Function() onTocTap;
  final void Function() onThemeStyleTap;
  final void Function() onProgressTap;
  final void Function() onFontTap;
  final void Function() onSettingsTap;
  @override
  Widget build(BuildContext context) {
    return AnimationsPY(
       padding:const EdgeInsets.only(top: 0),
        frame: Obx(
          () => Container(
            color: ReaderThemeC.current.theme.value.pannelBackgroundColor,
            width: ScreenUtil().screenWidth,
            height: 50,
            child: Wrap(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    //弹出目录
                    ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(50)),
                            backgroundColor: Colors.transparent,
                            shadowColor: Colors.transparent,
                            foregroundColor: ReaderThemeC
                                .current.theme.value.pannelTextColor),
                        onPressed: () {
                          onTocTap();
                        },
                        child: Icon(
                          Icons.menu,
                          color:
                              ReaderThemeC.current.theme.value.pannelTextColor,
                        )),
                        ///弹出主题
                    ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(50)),
                            backgroundColor: Colors.transparent,
                            shadowColor: Colors.transparent,
                            foregroundColor: ReaderThemeC
                                .current.theme.value.pannelTextColor),
                        onPressed: () {
                          onThemeStyleTap();
                        },
                        child: Icon(
                          Icons.palette_outlined,
                          color:
                              ReaderThemeC.current.theme.value.pannelTextColor,
                        )),
                        ///弹出进度
                    ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(50)),
                            backgroundColor: Colors.transparent,
                            shadowColor: Colors.transparent,
                            foregroundColor: ReaderThemeC
                                .current.theme.value.pannelTextColor),
                        onPressed: () {
                          onProgressTap();
                        },
                        child: Icon(
                          Icons.toll,
                          color:
                              ReaderThemeC.current.theme.value.pannelTextColor,
                        )),
                        //弹出字体
                    ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(50)),
                            backgroundColor: Colors.transparent,
                            shadowColor: Colors.transparent,
                            foregroundColor: ReaderThemeC
                                .current.theme.value.pannelTextColor),
                        onPressed: () {
                          onFontTap();
                        },
                        child: Icon(
                          Icons.text_format,
                          color:
                              ReaderThemeC.current.theme.value.pannelTextColor,
                        )),
                        //弹出设置
                    ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(50)),
                            backgroundColor: Colors.transparent,
                            shadowColor: Colors.transparent,
                            foregroundColor: ReaderThemeC
                                .current.theme.value.pannelTextColor),
                        onPressed: () {
                         onSettingsTap();
                        },
                        child: Icon(
                          Icons.settings_outlined,
                          color:
                              ReaderThemeC.current.theme.value.pannelTextColor,
                        )),
                  ],
                )
              ],
            ),
          ),
        ),
        tab: ReaduiType.BOTTOM,
      );
  }
}