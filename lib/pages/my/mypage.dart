import 'package:bot_toast/bot_toast.dart';
import 'package:ceshi1/config/controller/user_state_controller.dart';
import 'package:ceshi1/widgets/public/pub_bg.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/utils.dart';

class Mypage extends StatefulWidget {
  const Mypage({super.key});

  @override
  State<Mypage> createState() => _MypageState();
}

class _MypageState extends State<Mypage> {
  Widget RegeditBg({child}) {
    return Container(
      alignment: Alignment.center,
      width: ScreenUtil().setWidth(1034),
      height: ScreenUtil().setHeight(655),
      decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage(
                "assets/img/bg_user_center.png",
              ),
              fit: BoxFit.fill)),
      child: child,
    );
  }

  Widget textDL() {
    return ShaderMask(
      blendMode: BlendMode.srcIn,
      shaderCallback: (Rect bounds) {
        return const LinearGradient(
          colors: [
            Color(0xFFFFFFFF),
            Color(0xFFA5A5A5),
          ],
          stops: [0.0, 1.0],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          tileMode: TileMode.clamp,
        ).createShader(bounds);
      },
      child: RichText(
          text: TextSpan(children: [
        TextSpan(
            text: "注册账号\n",
            style: TextStyle(
                fontSize: ScreenUtil().setSp(30), fontWeight: FontWeight.bold)),
        TextSpan(
            text: "REGISTER ACCOUNT",
            style: TextStyle(
                fontSize: ScreenUtil().setSp(12), fontWeight: FontWeight.bold))
      ])),
    );
  }

  Widget infoWidget(str1, str2) {
    return Container(
      width: ScreenUtil().setWidth(360),
      height: ScreenUtil().setHeight(40),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(8)),
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Color.fromRGBO(255, 255, 255, 0),
            Color.fromRGBO(255, 255, 255, 0.12)
          ],
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Text(
            str1,
            style: TextStyle(color: Colors.white.withOpacity(0.5)),
          ),
          SizedBox(
            width: 20,
          ),
          Text(
            str2,
            style: TextStyle(color: Colors.white),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Pub_Bg(),
          Positioned(
            top: ScreenUtil().setHeight(196),
            left: ScreenUtil().setWidth(156),
            child: RegeditBg(
                child: Stack(
              children: [
                Positioned(
                    top: ScreenUtil().setHeight(78),
                    left: ScreenUtil().setWidth(78),
                    child: Row(
                      children: [
                        Image.asset(
                          "assets/img/tab_arrow.png",
                          height: ScreenUtil().setHeight(25),
                        ),
                        SizedBox(width: ScreenUtil().setWidth(16)),
                        textDL()
                      ],
                    )),
                Positioned(
                    top: ScreenUtil().setHeight(180),
                    left: ScreenUtil().setWidth(78),
                    child: SizedBox(
                      height: ScreenUtil().setHeight(392),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          infoWidget(
                              "账号",
                              UserStateController.current.user.username
                                  .toString()),
                          infoWidget(
                              "工作证号",
                              UserStateController.current.user.workPermitNum
                                  .toString()),
                          infoWidget(
                              "身份证号",
                              UserStateController.current.user.idCardNumber
                                  .toString()),
                          infoWidget(
                              "所属部门",
                              UserStateController.current.user.department
                                  .toString()),
                          infoWidget(
                              "账号状态",
                              UserStateController.current.user.allowedLogin == 0
                                  ? "禁用"
                                  : "正常")
                        ],
                      ),
                    )),
                Positioned(
                    top: ScreenUtil().setHeight(220),
                    left: ScreenUtil().setWidth(550),
                    child: SizedBox(
                      height: ScreenUtil().setHeight(292),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                            InkWell(
                            onTap: (){
                                BotToast.showText(text: "修改密码");
                            },
                            child:Container(
                            alignment: Alignment.center,
                            width: ScreenUtil().setWidth(418),
                            height: ScreenUtil().setHeight(142),
                            decoration: const BoxDecoration(
                                image: DecorationImage(
                                    image: AssetImage(
                                        "assets/img/bg_password.png"))),
                            child: const Text("修改登录密码",style: TextStyle(color: Color(0xff71FFF2)),),
                          ))
                           ,
                          InkWell(
                            onTap: (){
                                BotToast.showText(text: "个人资料");
                            },
                            child: Container(
                            alignment: Alignment.center,
                            width: ScreenUtil().setWidth(418),
                            height: ScreenUtil().setHeight(142),
                            decoration: const BoxDecoration(
                                image: DecorationImage(
                                    image: AssetImage(
                                        "assets/img/bg_modify.png"))),
                            child: const Text("编辑个人资料",style: TextStyle(color: Color(0xffFFBB1A )),),
                          ),
                          )
                        ],
                      ),
                    )),
              ],
            )),
          ),
          Positioned(
              top: ScreenUtil().setHeight(144),
              left: ScreenUtil().setWidth(156),
              child: SizedBox(
                height: ScreenUtil().setHeight(45),
                width: ScreenUtil().setWidth(104),
                child: Material(
                  color: Colors.transparent,
                  child: InkWell(
                    splashColor: Colors.grey,
                    onTap: () {
                      Get.back();
                    },
                    child: Stack(
                      children: [Image.asset("assets/img/btn_back.png")],
                    ),
                  ),
                ),
              ))
        ],
      ),
    );
  }
}
