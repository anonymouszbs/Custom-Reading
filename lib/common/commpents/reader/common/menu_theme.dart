import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../widgets/animation.dart';
import '../contants/theme.dart';

class MenuThemes extends StatelessWidget {
  final void Function(ReaderTheme theme) onChangeTheme;
  const MenuThemes({super.key, required this.onChangeTheme});

  @override
  Widget build(BuildContext context) {
    return AnimationsPY(
        padding: EdgeInsets.only(top: ScreenUtil().screenHeight*0.6-50),
        frame: Obx(
          () => Container(
            color: ReaderThemeC.current.theme.value.pannelBackgroundColor,
            width: MediaQuery.of(context).size.width,
            height: (ScreenUtil().screenHeight-110)*0.4,
            child: Wrap(
              children: [
                Column(
                  
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 18),
                      child: Text(
                        "主题",
                        style:
                            TextStyle(fontSize: 16, color:  ReaderThemeC.current.theme.value.pannelTextColor, fontWeight: FontWeight.bold),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      child: SingleChildScrollView(
                        
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: readerThemeList.map((theme) {
                            return GestureDetector(
                              onTap: () {
                               // widget.onThemeItemTap(theme);
                               onChangeTheme(theme);
                              },
                              child: Container(
                                margin: const EdgeInsets.symmetric(horizontal: 8),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(4),
                                    border: Border.all(width: 0.7, color: theme.dividerColor),
                                    color: theme.pannelContainerColor),
                                padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
                                child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(bottom: 18),
                                        child: ClipOval(
                                          child: Container(
                                              width: 14,
                                              height: 14,
                                              decoration: BoxDecoration(
                                                  border: Border.all(color:  ReaderThemeC.current.theme.value.pannelBackgroundColor),
                                                  borderRadius: BorderRadius.circular(50),
                                                  color:  ReaderThemeC.current.theme.value.key == theme.key
                                                      ? theme.primaryColor
                                                      : theme.pannelContainerColor)),
                                        ),
                                      ),
                                      Text(
                                        theme.name.split("").join("\n"),
                                        style: TextStyle(color: theme.pannelTextColor),
                                      )
                                    ]),
                              ),
                            );
                          }).toList(),
                        ),
                      ),
                    )
                  ],
                )
              ],
            )

          )),tab: ReaduiType.LEFT,);
  }
}