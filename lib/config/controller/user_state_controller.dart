import 'package:bot_toast/bot_toast.dart';
import 'package:ceshi1/pages/login/routers/login_page_id.dart';
import 'package:get/get.dart';

import '../../common/App/common_sp_util.dart';
import '../../untils/getx_untils.dart';
import 'bean/UserMoel.dart';


class UserStateController extends GetxController{
  static UserStateController get current => Get.find<UserStateController>();

  final Rx<UserMoel> _currentUser = UserMoel().obs;
  UserMoel get user=> _currentUser.value;

  static bool get isLogin => current.user.username!=null;

  //登录完成
  loadSucess(UserMoel model)async{

    CommonSpUtil.saveUserToken(token: model.username??"");

    CommonSpUtil.saveUserInfo(info: model.toJson());

   // await DatabaseHelper().insertUserModel(model); //d保存登录信息 先注释掉
    _currentUser.value = model;
  }
  //退出登录
  void exitLoginSucess(){
    CommonSpUtil.saveUserToken(token: "");
    _currentUser.value = UserMoel();
    BotToast.showText(text: "退出成功",onClose: (){
       currentToPage(LoginPageId.login);
    });
  }
  
}
