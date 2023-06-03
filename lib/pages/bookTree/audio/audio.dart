//显示一个动画

import 'package:bot_toast/bot_toast.dart';
import 'package:ceshi1/pages/bookTree/controller/audioController.dart';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../widgets/animation/animationposition.dart';
import '../../../widgets/animation/circulanimation.dart';

imagestep({child, start, end, required Function() onremove,id}) {
  BotToast.showWidget(toastBuilder: (cancelFunc) {
    return AnimatedMoveToPosition(
      moveWidget: Material(
          color: Colors.transparent,
          child: Container(
              decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.65),
                  borderRadius: const BorderRadius.all(Radius.circular(20))),
              width: ScreenUtil().setWidth(500),
              height: ScreenUtil().setHeight(500),
              child: Stack(
                children: [
                  Positioned(
                      right: 0,
                      child: IconButton(
                          onPressed: () {
                            BotToast.showText(text: "播放已结束");
                            AudioCtroller.current.stop();
                           
                            cancelFunc();
                          },
                          icon: const Icon(
                            Icons.close,
                            color: Colors.deepOrangeAccent,
                          ))),
                  Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Obx(() =>  CirculAnmation(
                            cease: AudioCtroller.current.playstate.value != MP3PLAYSTATE.PLAY?false:true,
                            child: ClipOval(
                                child: SizedBox(
                                    width: ScreenUtil().setWidth(242),
                                    height: ScreenUtil().setWidth(242),
                                    child: ClipRRect(
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(50)),
                                      child: child,
                                    ))))),
                        SizedBox(height: ScreenUtil().setHeight(20)),
                        Container(
                            alignment: Alignment.center,
                            width: ScreenUtil().setWidth(500),
                            height: ScreenUtil().setHeight(50),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                IconButton(
                                    onPressed: () {
                                      BotToast.showText(text: "播放已恢复");
                                      AudioCtroller.current.resume();
                                    },
                                    icon: Icon(Icons.play_arrow)),
                                IconButton(
                                    onPressed: () {
                                      BotToast.showText(text: "暂停");
                                      AudioCtroller.current.pause();
                                    },
                                    icon: Icon(Icons.pause)),
                                IconButton(
                                    onPressed: () {
                                      BotToast.showText(text: "播放已结束");
                                      AudioCtroller.current.stop();
                                    },
                                    icon: Icon(Icons.stop))
                              ],
                            )),
                        SizedBox(height: ScreenUtil().setHeight(20)),
                        Obx(() => Slider(
                              value: AudioCtroller.current.step.value,
                              max: 100.00,
                              onChanged: (value) {
                                 AudioCtroller.current.seekPlay(value:value,id:id);
                              },
                            ))
                      ]),
                ],
              ))),
      endPosition: end,
      startPosition: start,
      onRemove: () {
        onremove();
        // BotToast.cleanAll();
      },
    );
  });
}
