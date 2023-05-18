

import 'package:bot_toast/bot_toast.dart';
import 'package:ceshi1/common/commpents/reader/contants/floatcontroller.dart';
import 'package:ceshi1/common/commpents/reader/contants/theme.dart';
import 'package:ceshi1/config/routers/routers.dart';
import 'package:ceshi1/untils/theme_tool.dart';
import 'package:ceshi1/untils/utils_tool.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class Application extends StatelessWidget {
  Application({Key? key}) : super(key: key);
  final botToast = BotToastInit();
  globalOnTap() {}
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(1280, 720),
      builder: (context, child) {
      return GetMaterialApp(
          initialRoute: UtilsToll.configrootpageid(), //初始化入口
          getPages: Routers.getAllRoutes(), //初始化路由集合
          debugShowCheckedModeBanner: false,
          builder: (context, child) {
            return botToast(context, child);
          },
          theme: ThemeData(brightness: Brightness.light),
          darkTheme: ThemeData(brightness: Brightness.dark),
          themeMode: Themetool.getlocalprofileaboutThemeModel(),
          initialBinding: AllControllerBinding(),
//           localizationsDelegates: const [
//             GlobalMaterialLocalizations.delegate,
//             GlobalCupertinoLocalizations.delegate,
//             GlobalWidgetsLocalizations.delegate
//           ],
//           locale: Locale(Platform.localeName.split('_')[0]),
// // Insert this line
//           supportedLocales: const [Locale("zh", "CN"), Locale("en", "US")],
        
      );
    });
  }
}

class AllControllerBinding implements Bindings {
  @override
  void dependencies() {
    // Get.put<UserStateController>(
    //   UserStateController(),
    //   permanent: true,
    // );
    // Get.put<ReadController>(
    //   ReadController(),
    //   permanent: true,
    // );
    Get.put<FloatController>(
      FloatController(),
      permanent: true
    );
    Get.put<ReaderThemeC>(
      ReaderThemeC(),
      permanent: true
    );
    // GloblConfig.initnormaldata();
  }
}
