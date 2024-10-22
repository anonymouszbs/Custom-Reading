
//请求book所有逻辑 不管是分类 分页 还是其他乱七八糟的
import 'package:ceshi1/common/network/ApiServices.dart';
import 'package:ceshi1/config/controller/user_state_controller.dart';
import 'package:dio/dio.dart';

class FindBookApi{

  static Map<String, dynamic> options = {
    'headers': {'Content-Type': 'application/json'},
  };
  // 基础 URL
  static const String baseUrl = '${ApiService.baseUrl}find_ietm_resource_total';
  //获取首页数据分类列表
  
  static Future<Response> geTopBookDataList(dynamic data) async {
    var postdata = data;
    postdata ["UserID"]  = UserStateController.current.user.id.toString();

    return await ApiService.post(baseUrl, data: postdata, options: Options(headers: options));
  }

  static const String downloadUrl = '${ApiService.baseUrl}download';

  static Future<Response> geTdownloadRes(dynamic data) async {
    var postdata = data;
    postdata ["UserID"]  = UserStateController.current.user.id.toString();
    postdata ["username"] = UserStateController.current.user.username.toString();
    postdata ["pwd"] = UserStateController.current.user.pwd.toString();
    print(downloadUrl);
    print(postdata);
    return await ApiService.post(downloadUrl, data: postdata, options: Options(headers: options));
  }
}