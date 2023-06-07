import 'dart:io';
import 'package:bot_toast/bot_toast.dart';
import 'package:ceshi1/public/public_class_bean.dart';
import 'package:ceshi1/public/public_function.dart';
import 'package:ceshi1/untils/getx_untils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'package:video_player/video_player.dart';

import '../../../config/dataconfig/normal_string_config.dart';
import '../../../untils/sp_util.dart';
import '../controller/detailscontroller.dart';
import 'controller/videocontroller.dart';

class VideoPlayScreen extends StatefulWidget {
  const VideoPlayScreen({Key? key}) : super(key: key);

  @override
  State<VideoPlayScreen> createState() => _VideoPlayScreenState();
}

class _VideoPlayScreenState extends State<VideoPlayScreen>
    with TickerProviderStateMixin {
  VideoController videoController = Get.put(VideoController());
  late VideoPlayerController _videoPlayerController;
  bool showControllerUIisopen = false,
      _showControllerUIisopen = false,
      showRightUIisopen = false,
      _showRightUIisopen = false;
  late OverlayEntry showControllerUIoverlayEntry, topUI, rightUI;
  late AnimationController topORbottomanimationController,
      rightAnimationController;
  double opacityValue = 0;
  late Map videoinfodata;

  saveprogress() async {
    var sourceId = videoinfodata["id"];
    SourceMap sourceMap = getsourceidMap(id: sourceId);

    Duration? duration = await _videoPlayerController.position;
    final progress = double.tryParse(
        ((duration!.inMilliseconds / videoController.d.value.inMilliseconds) *
                100)
            .toStringAsFixed(0));

    if (sourceMap.progress < progress!) {
      saveSource(
      id: sourceId,
      map: {"progress": progress, "duration": duration.inMilliseconds});
    }
  }

  void sekto() async {
    var sourceId = videoinfodata["id"];
    SourceMap sourceMap = getsourceidMap(id: sourceId);

    await _videoPlayerController
        .seekTo(Duration(milliseconds:sourceMap.duration));
  }

  @override
  void initState() {
    topORbottomanimationController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 500));
    rightAnimationController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 500));
    super.initState();
    videoinfodata = currentGetArguments();
    //  print(videoinfodata["FilePath"]);

    _videoPlayerController = VideoPlayerController.file(
        File(videoinfodata["FilePath"]),
        videoPlayerOptions: VideoPlayerOptions(allowBackgroundPlayback: true))
      ..initialize().then((_value) async {
        sekto();
        _videoPlayerController.play();

        videoController.d.value = _videoPlayerController.value.duration;
      })
      ..addListener(() {
        saveprogress();
        setState(() {
          videoController.p.value = _videoPlayerController.value.position;
        });
      });

    super.initState();
  }

  @override
  void dispose() {
    
    // TODO: implement dispose
    _videoPlayerController.dispose(); //播放器销毁

    //topORbottom
    if (showControllerUIisopen) {
      topORbottomanimationController.dispose();
      showControllerUIoverlayEntry.remove();
      topUI.remove();
    }
    //right
    if (showRightUIisopen) {
      rightUI.remove();
    }

    super.dispose();
  }

  openRightController() {
    if (showRightUIisopen) {
      _showRightUIisopen
          ? rightAnimationController.animateTo(0)
          : rightAnimationController.forward();
      _showRightUIisopen = !_showRightUIisopen;
    } else {
      showRightUI();
    }
  }

  openController() {
    if (showControllerUIisopen) {
      _showControllerUIisopen
          ? topORbottomanimationController.animateTo(0)
          : topORbottomanimationController.forward();
      _showControllerUIisopen = !_showControllerUIisopen;
    } else {
      showControllerWidet(context: context);
    }
  }

  showControllerWidet({
    context,
  }) {
    showControllerUIisopen = true;
    showControllerUIoverlayEntry = OverlayEntry(builder: (context) {
      //这里返回控制ui
      return Container(
          alignment: Alignment.bottomCenter,
          child: FadeTransition(
            opacity: CurvedAnimation(
                parent: topORbottomanimationController, curve: Curves.linear),
            child: Material(
                color: Colors.transparent,
                child: Container(
                  padding:
                      const EdgeInsets.only(bottom: 20, left: 20, right: 20),
                  height: ScreenUtil().setHeight(60),
                  child: Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Obx(() => Text(
                              "${videoController.p.toString().substring(0, 7)}/${videoController.d.toString().substring(0, 7)}",
                              style: const TextStyle(color: Colors.white),
                            )),
                        Expanded(
                            child: Obx(() => Slider(
                                value: (videoController.p.value.inMilliseconds /
                                        videoController
                                            .d.value.inMilliseconds) *
                                    100,
                                min: 0,
                                max: 100,
                                onChanged: (value) {
                                   var sourceId = videoinfodata["id"];
    SourceMap sourceMap = getsourceidMap(id: sourceId);
                                  Duration duration = Duration(
                                      milliseconds: (videoController
                                                  .d.value.inMilliseconds *
                                              (value / 100))
                                          .toInt());
                                  if (value >sourceMap.progress) {
                                    BotToast.showText(text: "不可向前拖动");
                                  } else {
                                    videoController.p.value = duration;
                                    _videoPlayerController.seekTo(duration);
                                  }
                                })))
                      ],
                    ),
                  ),
                )),
          ));
    });

    Overlay.of(context)?.insert(
      showControllerUIoverlayEntry,
    );

    topUI = OverlayEntry(builder: (context) {
      //这里返回控制ui
      return Container(
          alignment: Alignment.topLeft,
          child: FadeTransition(
            opacity: CurvedAnimation(
                parent: topORbottomanimationController, curve: Curves.linear),
            child: Material(
                color: Colors.transparent,
                child: SizedBox(
                  height: 50,
                  width: ScreenUtil().screenWidth,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                          splashColor: Colors.black,
                          iconSize: 50,
                          onPressed: () {
                            DetailsController.current.shuaxin();
                            Get.back();
                          },
                          icon: Icon(
                            Icons.chevron_left,
                            color: Colors.white,
                          )),
                      // IconButton(
                      //     splashColor: Colors.black,
                      //     iconSize: 40,
                      //     onPressed: () {
                      //       //显示列表
                      //       setState(() {
                      //         openRightController();
                      //       });
                      //     },
                      //     icon: Icon(
                      //       Icons.format_list_bulleted,
                      //       color: Colors.white,
                      //     ))
                    ],
                  ),
                )),
          ));
    });
    Overlay.of(context)?.insert(
      topUI,
    );
    topORbottomanimationController.forward();
  }

  showRightUI() {
    //  rightUI = OverlayEntry(builder: (context) {
    //   //这里返回控制ui
    //   showRightUIisopen = true;
    //   _showRightUIisopen = true;
    //   return AnimationsPY(
    //         frame: ListView.builder(
    //                 itemCount: videoList.length,
    //                 itemBuilder: (BuildContext context, int index) {
    //                   return ListTile(

    //                     title: Stack(
    //                       children: [
    //                         Image.network(
    //                         "http://42.192.3.15:66/server/index.php?s=/api/attachment/visitFile&sign=dc0978366e1aede67dd3418d2d7c2c73",fit: BoxFit.cover,),
    //                         Positioned.fill(child: Container(
    //                           alignment: Alignment.center,
    //                           child: Text("学习进度：0%",style: TextStyle(color: Colors.white,fontSize: 25,),
    //                         )))
    //                       ],
    //                       ),

    //                     onTap: () {
    //                       // 点击列表项触发的事件

    //                     },
    //                     dense: true,
    //                   );
    //                 },
    //               ), animationController: rightAnimationController,tab: readui.RIGHT,);
    // });
    // Overlay.of(context)?.insert(
    //   rightUI,
    // );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onDoubleTap: () {
        _videoPlayerController.value.isPlaying
            ? _videoPlayerController.pause()
            : _videoPlayerController.play();
        ;
      },
      onTap: () {
        if (_showRightUIisopen == true) {
          openRightController();
        }
        openController();
      },
      child: AspectRatio(
        aspectRatio: _videoPlayerController.value.aspectRatio,
        child: VideoPlayer(_videoPlayerController),
      ),
    );
  }
}
