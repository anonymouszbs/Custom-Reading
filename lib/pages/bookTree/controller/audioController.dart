import 'dart:async';

import 'package:audioplayers/audioplayers.dart';
import 'package:bot_toast/bot_toast.dart';
import 'package:ceshi1/config/dataconfig/normal_string_config.dart';
import 'package:ceshi1/public/public_class_bean.dart';
import 'package:ceshi1/public/public_function.dart';
import 'package:ceshi1/untils/sp_util.dart';
import 'package:get/get.dart';

enum MP3PLAYSTATE { STOP, PAUSE, PLAY }

class AudioCtroller extends GetxController {
  static AudioCtroller get current => Get.find<AudioCtroller>();
  late AudioPlayer audioPlayer = audioPlayer = AudioPlayer();
  List<StreamSubscription> streams = [];
  Duration? duration = Duration(seconds: 0);
  RxDouble step = 0.0.obs;
  Rx<MP3PLAYSTATE> playstate = MP3PLAYSTATE.STOP.obs;
  String path = "";
  // {id: 10, ietm_id: 7, ResourceType: mp3, FileName: 2、控制系统设计与仿真, FilePath: /storage/emulated/0/Android/data/com.example.ceshi1/files/al_flutter/al_audio/82678499574163720146af2a596999a5.mp3, Size: 0:01:50, edit: 0, LearningRate: 0}

  start({path, id}) async {
    this.path = path;
    playstate.value = MP3PLAYSTATE.PLAY;

   SourceMap sourceMap = getsourceidMap(id: id);

    int position = sourceMap.duration;
    if (sourceMap.progress == 100.00) {
      await audioPlayer.play(DeviceFileSource(path));
    } else {
      await audioPlayer.play(DeviceFileSource(path),
          position: Duration(seconds: position));
    }

    duration = await audioPlayer.getDuration();
    audioPlayer.onPositionChanged.listen((event) {
      double progress = event.inSeconds / duration!.inSeconds;

      progress = double.tryParse((progress * 100).toStringAsFixed(2))!;
      step.value = progress;
      step.refresh();

      saveprogress(progress, id, event.inSeconds);
    }); //播放进度
    audioPlayer.onPlayerStateChanged.listen((event) {
      print("播放完毕");
      switch (event) {
        case PlayerState.paused:
          playstate.value = MP3PLAYSTATE.PAUSE;
          break;
        case PlayerState.stopped:
          playstate.value = MP3PLAYSTATE.STOP;
          step.value = 0;
          break;
        case PlayerState.playing:
          playstate.value = MP3PLAYSTATE.PLAY;
          break;
        default:
          step.value = 0;
          playstate.value = MP3PLAYSTATE.STOP;
      }
    }); //播放结束
    audioPlayer.onPlayerComplete.listen((event) {
      playstate.value = MP3PLAYSTATE.STOP;
    });
  }

  saveprogress(double progress, id, int duration) {

    SourceMap sourceMap = getsourceidMap(id: id);
    if (sourceMap.progress < progress) {
      saveSource(id: id,map: {"progress":progress,"duration":duration});
    }
  }

  seekPlay({required double value, id}) async {
   
    SourceMap sourceMap = getsourceidMap(id: id);

    if (value > sourceMap.progress) {
      BotToast.showText(text: "不可向前拖动");
    } else {
      final duration1 = (value / 100) * (duration!.inSeconds);
      step.value = duration1;
      await audioPlayer.seek(Duration(seconds: duration1.toInt()));
    }
  }

  void resume() async {
    if (playstate.value == MP3PLAYSTATE.STOP) {
      await audioPlayer.play(DeviceFileSource(path));
    } else {
      await audioPlayer.resume();
      playstate.value = MP3PLAYSTATE.PLAY;
    }
  }

  pause() {
    audioPlayer.pause();
    playstate.value = MP3PLAYSTATE.PAUSE;
  }

  stop() {
    step.value = 0;
    audioPlayer.stop();
    playstate.value = MP3PLAYSTATE.STOP;
  }
}
