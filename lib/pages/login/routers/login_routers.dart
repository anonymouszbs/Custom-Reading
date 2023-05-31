

import 'package:ceshi1/pages/login/login.dart';
import 'package:ceshi1/pages/login/regedit.dart';
import 'package:get/get.dart';

import '../../../widgets/animation/slideanimation.dart';
import 'login_page_id.dart';


class LoginPages{
  LoginPages._();
  static final routers = {
    GetPage(name: LoginPageId.login,page: ()=>const AnimationsTB(child: Transp())),
    GetPage(name: LoginPageId.regedit,page: ()=>const AnimationsRL(child: Regedit())),
  };
}