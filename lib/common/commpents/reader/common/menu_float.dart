
import 'package:bot_toast/bot_toast.dart';
import 'package:ceshi1/common/commpents/reader/contants/floatcontroller.dart';
import 'package:ceshi1/common/commpents/reader/contants/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class MenuFloat extends StatelessWidget {

  const MenuFloat({super.key});
  

  @override
  Widget build(BuildContext context) {
    //int lastBackPressedTime = 0;
    return Obx(() =>  FloatingActionButton(
            backgroundColor:
                ReaderThemeC.current.theme.value.pannelBackgroundColor,
            onPressed: () async{
            BotToast.cleanAll();
            BotToast.showWidget(toastBuilder: (n){
              FloatController.current.isshow.value = true;
              return  Container(
                  alignment: Alignment.center,
                   width: ScreenUtil().screenWidth,
                   height:  (ScreenUtil().screenHeight-110),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                     Flexible(flex: 9,child:  Image.asset("assets/img/booklisten.webp",fit: BoxFit.fill,), ),
                     Flexible(flex: 1,child: Wrap(
                      spacing: 10.0,
                      children: [
                        ElevatedButton(onPressed: (){
                           FloatController.current.pause();
                           BotToast.showText(text: "已暂停");
                        }, child: Text("暂停")),
                        ElevatedButton(onPressed: (){
                           FloatController.current.startPlay();
                            BotToast.showText(text: "已恢复");
                        }, child: Text("继续")),
                        ElevatedButton(onPressed: (){
                          FloatController.current.stop();
                          FloatController.current.isshow.value = false;
                          BotToast.showText(text: "已退出语音朗诵");
                          n();
                        }, child: Text("退出"))
                      ],
                     ) , ),
                    ],
                  ),
                
              );
            });

            FloatController.current.startPlay();
              // int now = DateTime.now().millisecondsSinceEpoch;
              // if (now - lastBackPressedTime > 1000) {
              //   lastBackPressedTime = now;
              // } else {
              //   FloatController.current.stop();
              //   return;
              // }

              // print(FloatController.current.floatStyle.value.ttsState);
              // switch (FloatController.current.floatStyle.value.ttsState) {
              //   case TtsState.stopped:
              //     BotToast.showText(
              //         text: "连续双击两次可直接退出所有播放",
              //         duration: const Duration(seconds: 3));
              //     FloatController.current.speak("夕阳无限好只是近黄昏");
              //     break;
              //   case TtsState.playing:
              //    BotToast.showText(
              //         text: "已暂停");
              //     FloatController.current.pause();
                  
              //     break;
              //   case TtsState.paused:
              //   BotToast.showText(text: "已恢复");
              //     FloatController.current.speak("夕阳无限好只是近黄昏");
              //     break;
              //   default:
              // }

              //
            },
            child: Icon(FloatController.current.ttsState.value==TtsState.stopped?Icons.headset:FloatController.current.ttsState.value==TtsState.playing?Icons.pause:Icons.play_arrow,
              color: ReaderThemeC.current.theme.value.pannelTextColor,
            ),
          ))
        ;
  }
}
