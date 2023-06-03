import 'package:flutter/material.dart';
import 'package:get/get.dart';

/// 跳转到指定界面
currentToPage(
  String name, {
  Map<String, String>? parameters,
  dynamic arguments,
  Function(Map info)? onChange,
  bool preventDuplicates = true,
}) {
  if (name == "") {
    return;
  }
  return Get.toNamed(name,
      parameters: parameters,
      arguments: arguments,
      preventDuplicates: preventDuplicates);
}
/// 重定向入口页
currentTo({
  required String name,
  Map<String, String>? parameters,
  dynamic arguments,
}) {
  Get.offAllNamed(
    name,
    parameters: parameters,
    arguments: arguments,
  );
}

void currentGoback(BuildContext context, {Map? info}) {
  //CommentTools.keydissmiss(context);
  Get.back(result: info);
}

/// 获取界面传值 parameters
Map<String, String?> currentGetParams() {
  return Get.parameters;
}

dynamic currentGetArguments() {
  return Get.arguments;
}