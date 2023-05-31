

import 'package:ceshi1/main.dart';
import 'package:ceshi1/pages/home/menu/menu_study_bar.dart';
import 'package:ceshi1/pages/my/routers/my_page_id.dart';
import 'package:ceshi1/untils/getx_untils.dart';
import 'package:ceshi1/widgets/public/Logo.dart';
import 'package:ceshi1/widgets/public/pub_bg.dart';

import 'package:flutter/material.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../common/keepalive.dart';
import '../../widgets/animation/fadeanimation.dart';
import 'menu/menu_leftbar.dart';
import 'menu/menu_find.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
 // late LeftBarCtr leftBarCtr = Get.find<LeftBarCtr>();
  late PageController leftBarCtr = PageController(initialPage: 0);
  @override
  void initState() {
    // TODO: implement initState

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      body: Stack(
        children: [
          Pub_Bg(),
          Flex(
            direction: Axis.horizontal,
            children: [
              Expanded(
                  flex: 15,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        padding: EdgeInsets.only(
                            left: ScreenUtil().setWidth(0),
                            top: ScreenUtil().setHeight(34)),
                        child: APPLOGO(),
                      ),
                      Container(
                        padding:
                            EdgeInsets.only(bottom: ScreenUtil().setHeight(0)),
                        child: MenuLeftBar(
                          onTap: (index) {
                           leftBarCtr.animateToPage(index, duration: Duration(milliseconds: 1000), curve: Curves.bounceOut);
                          },
                        ),
                      ),
                      Container(
                        padding:
                            EdgeInsets.only(bottom: ScreenUtil().setHeight(50)),
                        alignment: Alignment.centerRight,
                        child: SizedBox(
                          width: ScreenUtil().setWidth(180),
                          height: ScreenUtil().setHeight(96),
                          child: Stack(
                            alignment: Alignment.centerLeft,
                            children: [
                              Image.asset(
                                "assets/img/btn_to_user_center.png",
                                fit: BoxFit.cover,
                                height: ScreenUtil().setHeight(96),
                              ),
                              Positioned(
                                left: ScreenUtil().setWidth(20),
                                child: Row(
                                  children: [
                                    const SizedBox(
                                      width: 30,
                                      height: 30,
                                      child: CircleAvatar(
                                        radius: 50,
                                        backgroundImage: NetworkImage(
                                            'http://q2.qlogo.cn/headimg_dl?dst_uin=2669771396&spec=100',
                                            scale: 1.0),
                                      ),
                                    ),
                                    Text(
                                      "个人中心",
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold,
                                          fontSize: ScreenUtil().setSp(22)),
                                    )
                                  ],
                                ),
                              ),
                              Positioned.fill(
                                  child: Material(
                                color: Colors.transparent,
                                child: InkWell(
                                  splashColor: Colors.grey,
                                  onTap: () {
                                    //点击登录
                                    currentToPage(MYPageId.index);
                                  },
                                ),
                              ))
                            ],
                          ),
                        ),
                      ),
                    ],
                  )),
              Expanded(
                  flex: 85,
                  child: Flex(
                    direction: Axis.vertical,
                    children: [
                      //tabbar
                      Expanded(flex: 8, child: PageView(
                        physics:const NeverScrollableScrollPhysics(),
                        scrollDirection: Axis.vertical,
                        controller: leftBarCtr,
                        children: [
                          KeepLivepage(frame: FadeInWidget(key: GlobalKey(), child:const MenuTypeList())),
                          FadeInWidget(key: GlobalKey(), child:const MenuStudy()),
                          Container(
                    alignment: Alignment.center,
                    child: Text("待开发",style: TextStyle(color: Colors.white),),
                  ),
                  Container(
                    alignment: Alignment.center,
                    child: Text("待开发",style: TextStyle(color: Colors.white),),
                  ),
                  
                  

                        ],
                      ))
                    ],
                  )),
            ],
          )
        ],
      ),
    );
  }
}
