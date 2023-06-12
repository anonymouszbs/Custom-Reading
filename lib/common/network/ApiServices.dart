import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:bot_toast/bot_toast.dart';
import 'package:ceshi1/config/controller/user_state_controller.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class ApiService {
  static DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();

  static final Dio _dio = Dio();

  // 基础 URL
  static const String AppUrl = "http://42.192.3.15:89/";

  static const String baseUrl = '$AppUrl/index.php/ykt/android/';
  //登录
  static const String loginUrl = 'login';
  //注册

  static const String regitUrl = 'regit';

  //获取顶级分类
  static const String yktlbtoplevelUrl = 'ykt_lb_toplevel';
  //获取二级分类接口
  static const String yktlbsecondarylevel = 'ykt_lb_secondarylevel';
  //部门

  static const String yktdepartmentUrl = 'ykt_department';
  //教材目录
  static const String yktcontenttreeUrl = 'ykt_content_tree';

  //一些基础的操作api
  static const String addbookshelfUrl = 'add_book_shelf';

  ///获取计划表

  static const String getbookplanshelfUrl = 'get_book_plan_shelf';

  //违规外联记录
   static const String yktuserauditillegal = 'ykt_user_audit_illegal';
  // 其他参数
  static Map<String, dynamic> options = {
    'headers': {'Content-Type': 'application/json'},
  };

  // GET 请求
  static Future<Response> get(String path) async {
    return await _dio.get('$baseUrl$path', options: Options(headers: options));
  }

  // POST 请求
  static Future<Response> post(path,
      {dynamic data, required Options options}) async {
    AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
    final host = await InternetAddress.lookup('localhost',
        type: InternetAddressType.IPv4);


    var DiveceID = androidInfo.id;
    var DeveceName = androidInfo.brand;
    var TerminalIP = "127.0.0.1";
    var userid = UserStateController.current.user.id ?? "";
  print(data);
  print('$path?DiveceID=$DiveceID&DeveceName=$DeveceName&TerminalIP=$TerminalIP&userid=$userid');
    // print(jdata.toString());
    return await _dio.post('$path?DiveceID=$DiveceID&DeveceName=$DeveceName&TerminalIP=$TerminalIP&userid=$userid', data: data, options: options);
  }

  //登录
  static Future<Response> Login(dynamic data) async {
    return await post('$baseUrl$loginUrl',
        data: data, options: Options(headers: options));
  }

  //注册
  static Future<Response> Regit(dynamic data) async {
    return await post('$baseUrl$regitUrl',
        data: data, options: Options(headers: options));
  }

  //获取首页顶级分类
  static Future<Response> getTopLevel(dynamic data) async {
    return await post('$baseUrl$yktlbtoplevelUrl',
        data: data, options: Options(headers: options));
  }

  ///获取二级分类
  static Future<Response> getSeconDaryLevel(dynamic data) async {
    return await post('$baseUrl$yktlbsecondarylevel',
        data: data, options: Options(headers: options));
  }

  ///获取所有教材目录列表
  static Future<Response> getContentTree(dynamic data) async {
    return await post('$baseUrl$yktcontenttreeUrl',
        data: data, options: Options(headers: options));
  }

  ///ykt_content_tree
  static Future<Response> getdepartment() async {
    return await post('$baseUrl$yktdepartmentUrl',
        options: Options(headers: options));
  }

  //获取计划表 24|25 学习任务|个人书架
  static getBookPlanShelf({required ResourceState}) async {
    var data = {
      "UserID": UserStateController.current.user.id,
      "ResourceState": ResourceState,
    };
    print(data);
    var reponse = await post('$baseUrl$getbookplanshelfUrl',
        data: data, options: Options(headers: options));
    var jsondata = json.decode(reponse.data);
    if (jsondata["code"] == 1) {
      BotToast.showCustomNotification(toastBuilder: (po) {
        return Container(
          alignment: Alignment.center,
          width: 200,
          height: 30,
          color: Colors.white.withOpacity(0.3),
          child: Text(
            jsondata["msg"],
            style: TextStyle(color: Colors.yellow[900]),
          ),
        );
      });
      return jsondata;
    } else {
      BotToast.showCustomNotification(toastBuilder: (po) {
        return Container(
          alignment: Alignment.center,
          width: 200,
          height: 30,
          color: Colors.white.withOpacity(0.3),
          child: Text(
            jsondata["msg"],
            style: TextStyle(color: Colors.yellow[900]),
          ),
        );
      });
    }
  }

  ///添加书籍到书架
  static addBookShelf({required UserID, required IETM_ID}) async {
    var data = {
      "UserID": UserStateController.current.user.id,
      "IETM_ID": IETM_ID,
    };
    var reponse = await post('$baseUrl$addbookshelfUrl',
        data: data, options: Options(headers: options));
    var jsondata = json.decode(reponse.data);
    if (jsondata["code"] == 1) {
      BotToast.showCustomNotification(toastBuilder: (po) {
        return Container(
          alignment: Alignment.center,
          width: 200,
          height: 30,
          color: Colors.white.withOpacity(0.3),
          child: Text(
            jsondata["msg"],
            style: TextStyle(color: Colors.yellow[900]),
          ),
        );
      });
    } else {
      BotToast.showCustomNotification(toastBuilder: (po) {
        return Container(
          alignment: Alignment.center,
          width: 200,
          height: 30,
          color: Colors.white.withOpacity(0.3),
          child: Text(
            jsondata["msg"],
            style: TextStyle(color: Colors.yellow[900]),
          ),
        );
      });
    }
  }
  ///违规外联记录
  static Future<Response> listenUserauditillegal(dynamic data) async {
    return await post('$baseUrl$yktuserauditillegal',
        data: data, options: Options(headers: options));
  }

 
}

