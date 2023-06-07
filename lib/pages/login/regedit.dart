import 'dart:convert';

import 'package:bot_toast/bot_toast.dart';
import 'package:ceshi1/pages/login/controller/logincontroller.dart';
import 'package:ceshi1/pages/login/routers/login_page_id.dart';
import 'package:ceshi1/untils/getx_untils.dart';
import 'package:ceshi1/widgets/public/loginwidgets.dart';
import 'package:ceshi1/widgets/public/pub_bg.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../common/network/ApiServices.dart';
import '../../widgets/animation/fadeanimation.dart';

class Regedit extends StatefulWidget {
  const Regedit({super.key});

  @override
  State<Regedit> createState() => _RegeditState();
}

class _RegeditState extends State<Regedit> {
  //所属部门
  final LoginController loginController =
      Get.put<LoginController>(LoginController());
  bool isagree = false;
  bool morelogin = false;
  late TextEditingController username = TextEditingController();
  late TextEditingController pwd = TextEditingController();
  late TextEditingController repedpwd = TextEditingController();
  late TextEditingController user_nick = TextEditingController();
  late TextEditingController WorkPermitNum = TextEditingController();
  late TextEditingController id_card_number = TextEditingController();
  late int currentdepartment = 0;
  @override
  void initState() {
    // TODO: implement initState
    loadDepartment();
    super.initState();
  }

  loadDepartment() async {
    var reponse = await ApiService.getdepartment();
    var jsondata = json.decode(reponse.data);

    if (jsondata['code'] == 1) {
      jsondata['data'].map((e) {
        loginController.departmentList.add(e);
      }).toList();
      loginController.department.value = jsondata['data'][0]["DepartmentName"];
    } else {
      BotToast.showText(text: jsondata['msg']);
    }
  }

  ///提交注册
  regedit() async {
    var data = {
      "username": username.text,
      "pwd": pwd.text,
      "user_nick": user_nick.text,
      "WorkPermitNum": WorkPermitNum.text,
      "id_card_number": id_card_number.text,
      "Department": currentdepartment
    };
    var reponse = await ApiService.Regit(data);
    var jsondata = json.decode(reponse.data);
    print(jsondata);
    if (jsondata['code'] == 1) {
      BotToast.showText(
          text: "注册成功...",
          duration: Duration(milliseconds: 1000),
          onClose: () {
            Get.back();
          });
    } else {
      BotToast.showText(text: jsondata['msg']);
    }
  }

  //选择部门
  Widget slectdipartment() {
    return Container(
        width: ScreenUtil().setWidth(360),
        height: ScreenUtil().setHeight(60),
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(20)),
          gradient: LinearGradient(
            begin: Alignment.centerRight,
            end: Alignment.centerLeft,
            colors: [
              Color.fromRGBO(255, 255, 255, 0),
              Color.fromRGBO(255, 255, 255, 0.12)
            ],
          ),
        ),
        // jsondata['data'].asMap().keys.map(( index){
        //   var key,value;
        //   jsondata['data'][index].entries.forEach((element) {
        //     key = element.key;
        //     value = element.value;
        //   });

        // });

        child: Obx(
          () => DropdownButton<String>(
            underline: Container(),
            dropdownColor: Color.fromRGBO(255, 255, 255, 0.20), //下拉背景色
            value: loginController.department.value,
            items: loginController.departmentList
                .map<DropdownMenuItem<String>>((value) {
              return DropdownMenuItem<String>(
                  value: value['DepartmentName'].toString(),
                  child: GestureDetector(
                    onTap: () {
                      currentdepartment = value['id'];
                    },
                    child: Row(
                      children: [
                        SizedBox(
                          width: ScreenUtil().setWidth(20),
                        ),
                        Text(
                          value['DepartmentName'].toString(),
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: ScreenUtil().setSp(22)),
                        ),
                        SizedBox(
                          width: ScreenUtil().setWidth(150),
                        ),
                        Text("选择",
                            style: TextStyle(
                                color: Colors.grey,
                                fontSize: ScreenUtil().setSp(18)))
                      ],
                    ),
                  ));
            }).toList(),
            onChanged: (newValue) {
              loginController.department.value = newValue!;
            },
          ),
        ));
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
                fontSize: ScreenUtil().setSp(34), fontWeight: FontWeight.bold)),
        TextSpan(
            text: "REGISTER ACCOUNT",
            style: TextStyle(
                fontSize: ScreenUtil().setSp(14), fontWeight: FontWeight.bold))
      ])),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: Container(
          height: ScreenUtil().screenHeight,
          width: ScreenUtil().screenWidth,
          child: SingleChildScrollView(
              child: Stack(
            alignment: Alignment.center,
            children: [
              const Pub_Bg(),
              KeyboardVisibilityBuilder(
                builder: (p0, isKeyboardVisible) {
                  return Positioned(
                      bottom:
                          ScreenUtil().setHeight(isKeyboardVisible ? 350 : 170),
                      left: ScreenUtil().setWidth(156),
                      child: SingleChildScrollView(
                          child: LoginBg(
                              child: Column(
                        children: [
                          SizedBox(
                            height: ScreenUtil().setHeight(100),
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
                                    BotToast.showText(text: "跳转到登录");
                                    currentTo(name: LoginPageId.login);
                                  },
                                  child: const Text(
                                    "已有帐号？去登陆",
                                    style: TextStyle(color: Colors.grey),
                                  )),
                            ],
                          ),
                          SizedBox(
                            height: ScreenUtil().setHeight(40),
                          ),
                          EditTextfield(
                              textcontroller: username,
                              hintext: "请输入账号",
                              icon: "assets/img/account.png"),
                          SizedBox(
                            height: ScreenUtil().setHeight(40),
                          ),
                          EditTextfield(
                              textcontroller: pwd,
                              hintext: "请输入密码",
                              inputFormatters: [
                                FilteringTextInputFormatter.allow(
                                    RegExp(r'[0-9]'))
                              ],
                              icon: "assets/img/password.png"),
                          SizedBox(
                            height: ScreenUtil().setHeight(40),
                          ),
                          EditTextfield(
                              textcontroller: repedpwd,
                              hintext: "请确认登陆密码",
                              inputFormatters: [
                                FilteringTextInputFormatter.allow(
                                    RegExp(r'[0-9]'))
                              ],
                              icon: "assets/img/password.png"),
                          Container(
                            padding: EdgeInsets.only(
                                right: ScreenUtil().setWidth(50)),
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
                                      "下一步",
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
                                        // setState(() {
                                        //   morelogin = !morelogin;
                                        // });

                                        if (username.text == "") {
                                          BotToast.showText(text: "用户名不能为空");
                                        } else if (pwd.text != repedpwd.text) {
                                          BotToast.showText(text: "两次密码填写不一致");
                                        } else if (username.text != "" &&
                                            pwd.text == repedpwd.text) {
                                          setState(() {
                                            morelogin = !morelogin;
                                          });
                                        }
                                      },
                                    ),
                                  ))
                                ],
                              ),
                            ),
                          ),
                        ],
                      ))));
                },
              ),
              KeyboardVisibilityBuilder(builder: (p0, isKeyboardVisible) {
                ///注册其他选择页
                return morelogin
                    ? Positioned(
                        bottom: ScreenUtil()
                            .setHeight(isKeyboardVisible ? 250 : 196),
                        left: ScreenUtil().setWidth(698),
                        child: FadeInWidget(
                            key: GlobalKey(),
                            child: RegeditBg(
                                child: Column(
                              children: [
                                SizedBox(
                                  height: ScreenUtil().setHeight(100),
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
                                          BotToast.showText(text: "跳转到登录");
                                          currentTo(name: LoginPageId.login);
                                        },
                                        child: const Text(
                                          "已有帐号？去登陆",
                                          style: TextStyle(color: Colors.grey),
                                        )),
                                  ],
                                ),
                                SizedBox(
                                  height: ScreenUtil().setHeight(40),
                                ),
                                EditTextfield(
                                    textcontroller: user_nick,
                                    hintext: "请输入姓名",
                                    icon: "assets/img/account.png"),
                                SizedBox(
                                  height: ScreenUtil().setHeight(40),
                                ),
                                EditTextfield(
                                    textcontroller: id_card_number,
                                    inputFormatters: [
                                      FilteringTextInputFormatter.allow(
                                          RegExp(r'^[0-9xX]+$'))
                                    ],
                                    hintext: "请输入身份证号",
                                    icon: "assets/img/account.png"),
                                SizedBox(
                                  height: ScreenUtil().setHeight(40),
                                ),
                                EditTextfield(
                                    textcontroller: WorkPermitNum,
                                    hintext: "请输入工作证号",
                                    icon: "assets/img/account.png"),
                                SizedBox(
                                  height: ScreenUtil().setHeight(40),
                                ),
                                slectdipartment(),
                                //  EditTextfield(
                                // textcontroller: repedpassword, hintext: "请选择所属部门",icon: "assets/img/account.png"),
                                Container(
                                  padding: EdgeInsets.only(
                                      right: ScreenUtil().setWidth(50)),
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
                                            "确认注册",
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontWeight: FontWeight.bold,
                                                fontSize:
                                                    ScreenUtil().setSp(22)),
                                          ),
                                        ),
                                        Positioned.fill(
                                            child: Material(
                                          color: Colors.transparent,
                                          child: InkWell(
                                            splashColor: Colors.grey,
                                            onTap: () {
                                              regedit();
                                            },
                                          ),
                                        ))
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ))))
                    : Container();
              }),
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
                          BotToast.showText(text: "跳转到登录");

                          currentTo(name: LoginPageId.login);
                        },
                        child: Stack(
                          children: [Image.asset("assets/img/btn_back.png")],
                        ),
                      ),
                    ),
                  ))
            ],
          ))),
    );
  }
}
