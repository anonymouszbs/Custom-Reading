

import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../widgets/animation.dart';
import '../contants/theme.dart';

class MenuProgress extends StatelessWidget {
  const MenuProgress({super.key});

  @override
  Widget build(BuildContext context) {
    return AnimationsPY(
        padding: EdgeInsets.only(top: ScreenUtil().screenHeight*0.3-50),
        frame: Obx(()=> Container(
            
            color: ReaderThemeC.current.theme.value.pannelBackgroundColor,
            width: MediaQuery.of(context).size.width,
            height: ScreenUtil().screenHeight*0.3,
            child:Wrap(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 18),
                      child: Text(
                        "当前进度 ",
                        style:
                            TextStyle(fontSize: 16, color: ReaderThemeC.current.theme.value.pannelTextColor, fontWeight: FontWeight.bold),
                      ),
                    ),
                    Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 12),
                          child: IconButton(
                            icon: Icon(
                              Icons.keyboard_double_arrow_left_rounded,
                              color: ReaderThemeC.current.theme.value.primaryColor,
                            ),
                            onPressed: (){
                              BotToast.showText(text: "不支持");
                            },
                          ),
                        ),
                        Flexible(
                          child: SliderTheme(
                              data: SliderTheme.of(context).copyWith(
                                activeTrackColor: ReaderThemeC.current.theme.value.primaryColor,
                                inactiveTrackColor: ReaderThemeC.current.theme.value.pannelContainerColor,
                                trackHeight: 12,
                                overlayShape: SliderComponentShape.noOverlay,
                                thumbColor: Colors.white, //滑块颜色
                                thumbShape: const RoundSliderThumbShape(
                                  disabledThumbRadius: 7, //禁用是滑块大小
                                  enabledThumbRadius: 7, //滑块大小
                                ),
                              ),
                              child: Slider(
                                

                                
                                  value: 0.5,
                                  min: 0,
                                  max:
                                        1.0,
                                  onChanged: (val) {
                                   
                                  },
                                  onChangeEnd: (v){})),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 12),
                          child: IconButton(
                            icon: Icon(
                              Icons.keyboard_double_arrow_right_rounded,
                              color: ReaderThemeC.current.theme.value.primaryColor,
                            ),
                            onPressed: (){
                              BotToast.showText(text: "不支持");
                            },
                          ),
                        ),
                      ],
                    ),
                  ],
                )
              ],
            ))), tab: ReaduiType.LEFT,);
  }
}