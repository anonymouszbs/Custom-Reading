import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../widgets/animation.dart';
import '../contants/theme.dart';

class MenuTop extends StatelessWidget {
  const MenuTop({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() =>  AnimationsPY(
       padding:const EdgeInsets.only(top: 0),
        frame: SizedBox(
          height: 60,
          child: AppBar(
            backgroundColor:
                ReaderThemeC.current.theme.value.pannelBackgroundColor,
            centerTitle: true,
            leading: Center(
              child: IconButton(
                  onPressed: () {
                    Get.back();
                  },
                  icon: Icon(
                    Icons.arrow_back,
                    color: ReaderThemeC.current.theme.value.pannelTextColor,
                  )),
            ),
            title: Text(
              ReaderThemeC.current.currentTitle.value,
              style: TextStyle(
                  color: ReaderThemeC.current.theme.value.pannelTextColor),
            ),
          ),
        ),
        tab: ReaduiType.TOP,
      ));
  }
}