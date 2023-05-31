import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../animation/fadeanimation.dart';
import '../fireanimation.dart';

// ignore: camel_case_types
class Pub_Bg extends StatefulWidget {
  const Pub_Bg({super.key});

  @override
  State<Pub_Bg> createState() => _Pub_BgState();
}

// ignore: camel_case_types
class _Pub_BgState extends State<Pub_Bg> {
  @override
  Widget build(BuildContext context) {
    return  FadeInWidget( key: GlobalKey(), child: Stack(
      children: [
        SizedBox(
          width: ScreenUtil().screenWidth,
          height: ScreenUtil().screenHeight,
          child: Image.asset(
            "assets/img/pagebg.png",
            fit: BoxFit.fill,
          ),
        ),
         
        Positioned.fill(
            child: InAppWebView(
                    initialData: InAppWebViewInitialData(data: fireanimation),
                    onWebViewCreated: (controller) {
                    },
                    initialSettings: InAppWebViewSettings(
                      transparentBackground: true,
                      disableHorizontalScroll: true, //开启横向滚动
                      disableVerticalScroll: true, //关闭垂直滚动
                    ))),

                 
      ],
    ));
  }
}