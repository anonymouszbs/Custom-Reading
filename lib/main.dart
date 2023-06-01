import 'dart:async';

import 'package:bot_toast/bot_toast.dart';
import 'package:ceshi1/config/dataconfig/GlobalConfig.dart';
import 'package:ceshi1/pages/login/login.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'init/Appalication.dart';
import 'package:flutter/material.dart';


void main(List<String> args)async{
  
  runZonedGuarded(
    () => init(),
    // ignore: avoid_print
    (err, stace) => print(FlutterErrorDetails(exception: err, stack: stace)),
    zoneSpecification: ZoneSpecification(
      print: (Zone self, ZoneDelegate parent, Zone zone, String line) {
        if (line.length > 800) {
          parent.print(zone, '字符串长度为 ${line.length}');
        } else {
          parent.print(zone, line);
        }
      },
    ),
  );
}
init() async{
  WidgetsFlutterBinding.ensureInitialized();
  await GlobalConfig.init();
  
SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: []);
  runApp( Application());
} 










class MyApp extends StatelessWidget {
  
  const MyApp({super.key});
  
  @override
  Widget build(BuildContext context) {
     final bottoast  = BotToastInit();
    return  MaterialApp(
       builder: (context, child) { 
              //easyLoading(context, child);s
              return bottoast(context, child);},
      home: ScreenUtilInit(
        designSize: const Size(1280, 720),
        builder: (b,a){
        return const Transp();
      }),
    );
  }
}