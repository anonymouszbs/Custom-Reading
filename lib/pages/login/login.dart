import 'dart:async';
import 'dart:convert';

import 'package:bot_toast/bot_toast.dart';
import 'package:ceshi1/common/network/ApiServices.dart';
import 'package:ceshi1/config/controller/bean/UserMoel.dart';
import 'package:ceshi1/config/controller/user_state_controller.dart';
import 'package:ceshi1/pages/home/routers/home_page_id.dart';
import 'package:ceshi1/pages/login/routers/login_page_id.dart';
import 'package:ceshi1/untils/getx_untils.dart';
import 'package:ceshi1/widgets/animation/fadeanimation.dart';

import 'package:ceshi1/widgets/animation/flipanimation.dart';
import 'package:ceshi1/widgets/public/loginwidgets.dart';
import 'package:ceshi1/widgets/public/pub_bg.dart';
import 'package:flutter/material.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';




class Transp extends StatefulWidget {
  const Transp({super.key});

  @override
  State<Transp> createState() => _TranspState();
}

class _TranspState extends State<Transp> with SingleTickerProviderStateMixin {
  
  bool isagree = false, taploginbutton = false;
  late AnimationController animationController;
  late TextEditingController username = TextEditingController(text: "admin125");
  late TextEditingController pwd = TextEditingController(text: "123456");
  late StreamSubscription<bool> keyboardSubscription;
  
@override
  void dispose() {
    // TODO: implement dispose
   
    super.dispose();
  }
  @override
  void initState() {
    animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 800),
    );
    // TODO: implement initState
    super.initState();
  }
  ///处理登录
  login()async{
    var data = {
      "username":username.text,
      "pwd":pwd.text
    };
    var reponse = await ApiService.Login(data);
    var jsondata = json.decode(reponse.data);

    if(jsondata['code']==1){
      UserStateController.current.loadSucess(UserMoel.fromJson(jsondata['data']));
      BotToast.showText(text: "登陆中...",duration: Duration(milliseconds: 1000),onClose: (){
        animationController.forward();
      });
    }else{
      BotToast.showText(text:jsondata['msg'] );
    }
    
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
            text: "账号登录\n",
            style: TextStyle(
                fontSize: ScreenUtil().setSp(34), fontWeight: FontWeight.bold)),
        TextSpan(
            text: "ACCOUNT LOGIN",
            style: TextStyle(
                fontSize: ScreenUtil().setSp(16), fontWeight: FontWeight.bold))
      ])),
    );
  }
   double speed = 1.00;
   String listentext = "Logo";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      children: [
        const Pub_Bg(),
         Positioned(
            bottom: ScreenUtil().setHeight( 200),
            left: ScreenUtil().setWidth(156),
            child: FlipDisappear(
                key: GlobalKey(),
                onDisappear: () {
                  setState(() {
                    taploginbutton = !taploginbutton;
                    
                  });
                  print(taploginbutton);
                  Timer.periodic(Duration(milliseconds: 200), (timer) {
                     if(speed==100.0){
                      timer.cancel();
                     }
                      setState(() {
                        if(speed<100.0){
                          speed++;
                        }
                        print(speed);
                      });
                       if(speed==10.0){
                        setState(() {
                          listentext = "账号安全检测...";
                        });}
                     else if(speed==50.0){
                        setState(() {
                          listentext = "账号检测完毕！设备安全检测中...";
                        });
                      }else if(speed==100.0){
                       setState(() {
                          listentext = "设备安全检测完毕！即将跳转";
                       });
                        
                        
                        Timer(Duration(seconds: 2), () { 

                          currentTo(name: HomePageId.home);
                        });
                      }
                      
                     });

                              },
                controller: animationController,
                child: LoginBg(
                    child: Column(
                  children: [
                    Container(
                      alignment: Alignment.topRight,
                      child: ElevatedButton.icon(
                        onPressed: () {},
                        icon: const Icon(Icons.settings),
                        label: const Text("设置"),
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.transparent,
                            shadowColor: Colors.transparent),
                      ),
                    ),
                    SizedBox(
                      height: ScreenUtil().setHeight(60),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        textDL(),
                        SizedBox(
                          width: ScreenUtil().setWidth(30),
                        ),
                        TextButton(
                            onPressed: () {
                              //注册
                              BotToast.showText(text: "跳转到注册");
                              currentToPage(LoginPageId.regedit);
                            },
                            child: const Text(
                              "没有账号？去注册",
                              style: TextStyle(color: Colors.grey),
                            )),
                      ],
                    ),
                    SizedBox(
                      height: ScreenUtil().setHeight(50),
                    ),
                    EditTextfield(
                        textcontroller: username,
                        hintext: "请输入用户账号",
                        icon: "assets/img/account.png"),
                    SizedBox(
                      height: ScreenUtil().setHeight(30),
                    ),
                    EditTextfield(
                        textcontroller: pwd,
                        hintext: "请输入用户密码",
                        icon: "assets/img/password.png"),
                    SizedBox(
                      height: ScreenUtil().setHeight(30),
                    ),
                    Container(
                      padding:
                          EdgeInsets.only(right: ScreenUtil().setWidth(20)),
                      alignment: Alignment.centerRight,
                      child: SizedBox(
                        width: ScreenUtil().setWidth(180),
                        height: ScreenUtil().setHeight(96),
                        child: Stack(
                          alignment: Alignment.centerLeft,
                          children: [
                            Image.asset(
                              "assets/img/btn_login.png",
                              fit: BoxFit.cover,
                              height: ScreenUtil().setHeight(96),
                            ),
                            Positioned(
                              left: ScreenUtil().setWidth(20),
                              child: Text(
                                "点击登录",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                    fontSize: ScreenUtil().setSp(22)),
                              ),
                            ),
                            Positioned.fill(
                                child: Material(
                              color: Colors.transparent,
                              child: InkWell(
                                splashColor: Colors.grey,
                                onTap: () {
                                  login();
                                //currentTo(name: HomePageId.home);
                               
                                },
                              ),
                            ))
                          ],
                        ),
                      ),
                    ),
                    Container(
                      width: ScreenUtil().setWidth(400),
                      //height: ScreenUtil().setHeight(60),
                      alignment: Alignment.topLeft,
                      child: ElevatedButton.icon(
                          style: ElevatedButton.styleFrom(
                              shadowColor: Colors.transparent,
                              backgroundColor: Colors.transparent),
                          onPressed: () {
                            setState(() {
                              isagree = !isagree;
                            });
                          },
                          icon: Icon(
                            isagree
                                ? Icons.check_circle_outlined
                                : Icons.circle_outlined,
                            color: Color(0xffFFC54F),
                          ),
                          label: Text(
                            "点击表示阅读并同意《用户协议》以及《用户隐私政策》",
                            style: TextStyle(
                                color: Colors.grey,
                                fontSize: ScreenUtil().setSp(20)),
                          )),
                    )
                  ],
                ))
                
                )),
        AnimatedPositioned(
          duration: const Duration(seconds: 1),
          curve: Curves.easeInOut,
          right: taploginbutton
              ? ScreenUtil().screenWidth / 2 -60
              : ScreenUtil().setWidth(243),
          bottom: taploginbutton
              ? ScreenUtil().screenHeight / 2
              : ScreenUtil().setHeight(424),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
             taploginbutton
              ?FadeInWidget(key: GlobalKey(), child: Image.asset("assets/img/safe_detection.webp",fit: BoxFit.contain,height: ScreenUtil().setSp(200),)):Icon(
                Icons.star,
                color: Color(0xffFFC54F),
                size: ScreenUtil().setSp(60),
              ),
               taploginbutton
              ?Text(
                listentext,
                style: TextStyle(
                    color: Colors.white,
                    fontSize: ScreenUtil().setSp(18),
                    fontWeight: FontWeight.bold,),textAlign: TextAlign.center,
              ):Text(
                "LOGO",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: ScreenUtil().setSp(56),
                    fontWeight: FontWeight.bold),
              )
            ],
          ),
        ),

       Positioned(bottom: 0,child: taploginbutton? SizedBox(
          width: ScreenUtil().screenWidth,
          child: Slider(value:speed ,max: 100.0, thumbColor:Colors.amber[200],onChanged: (v){}),
        ):Container()),

        taploginbutton? Positioned.fill(child: Container(
          color: Colors.transparent,
        )):Container()
      ],
    ));
  }
}
