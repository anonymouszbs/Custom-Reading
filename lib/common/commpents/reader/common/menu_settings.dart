import 'package:ceshi1/common/commpents/reader/contants/floatcontroller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../widgets/animation.dart';
import '../../../../widgets/firstGif.dart';
import '../contants/theme.dart';

class MenuSettings extends StatefulWidget {
  const MenuSettings({super.key});

  @override
  State<MenuSettings> createState() => _MenuSettingsState();
}

class _MenuSettingsState extends State<MenuSettings> {
  bool isPageTurn = true;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AnimationsPY(
      padding: EdgeInsets.only(top: ScreenUtil().screenHeight * 0.5 - 50),
      frame: Container(
          color: ReaderThemeC.current.theme.value.pannelBackgroundColor,
          width: MediaQuery.of(context).size.width,
          height: (ScreenUtil().screenHeight - 110) * 0.5,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(
                          height: (ScreenUtil().screenHeight - 110) * 0.5,
                          width: ScreenUtil().setWidth(300),
                          child: isPageTurn
                              ? Image.asset(
                                  "assets/img/pageturn.webp",
                                  fit: BoxFit.cover,
                                )
                              : const FirstGif(
                                  path: "assets/img/pageturn.webp",
                                ),
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Switch(
                              
                               activeColor: ReaderThemeC.current.theme.value.primaryColor,
                               inactiveThumbColor: ReaderThemeC.current.theme.value.pannelContainerColor,
                                value: isPageTurn,
                                onChanged: (v) {
                                  isPageTurn = v;
                                  setState(() {
                                    ReaderThemeC
                                        .current.pageTurnAnimation.value = v;
                                  });
                                }),
                            Text(
                              isPageTurn ? "翻书动画已开启" : "翻书动画已关闭",
                              style: const TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.bold),
                              textAlign: TextAlign.center,
                            )
                          ],
                        ),
                      ],
                    )
                  ],
                ),
              ),
              Expanded(
                  child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                          height: (ScreenUtil().screenHeight - 110) * 0.5,
                          width: ScreenUtil().setWidth(300),
                          child: Image.asset(
                            "assets/img/recitation.webp",
                            fit: BoxFit.contain,
                          )),
                      Expanded(
                        child: Column(
                          // mainAxisAlignment: MainAxisAlignment.center,
                          //shrinkWrap: true,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              "朗诵音量调节",
                              style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  height: 1),
                              textAlign: TextAlign.center,
                            ),
                            Slider(
                               thumbColor: Colors.white,
                               activeColor: ReaderThemeC.current.theme.value.primaryColor,
                               inactiveColor: ReaderThemeC.current.theme.value.pannelContainerColor,
                                value: FloatController
                                    .current.floatStyle.value.volume,
                                max: 1.0,
                                min: 0.0,
                                divisions: 10,
                                onChanged: (v) {
                                  FloatController
                                      .current.floatStyle.value.volume = v;
                                  setState(() {});
                                }),
                            const Text(
                              "朗诵语速调节",
                              style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  height: 0.1),
                              textAlign: TextAlign.center,
                            ),
                            Slider(
                                thumbColor: Colors.white,
                                activeColor: ReaderThemeC
                                    .current.theme.value.primaryColor,
                                inactiveColor: ReaderThemeC
                                    .current.theme.value.pannelContainerColor,
                                value: FloatController
                                    .current.floatStyle.value.rate,
                                max: 1.0,
                                min: 0.0,
                                divisions: 10,
                                label:
                                    "速率:${FloatController.current.floatStyle.value.rate}",
                                onChanged: (v) {
                                  FloatController
                                      .current.floatStyle.value.rate = v;
                                  setState(() {});
                                })
                          ],
                        ),
                      )
                    ],
                  )
                ],
              ))
            ],
          )),
      tab: ReaduiType.LEFT,
    );
  }
}
