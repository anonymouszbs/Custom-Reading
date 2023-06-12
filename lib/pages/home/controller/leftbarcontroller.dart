

import 'package:flutter/material.dart';
import 'package:get/get.dart';




class LeftBarCtr extends GetxController{
static LeftBarCtr get current => Get.find<LeftBarCtr>();
  RxInt currentindex = 0.obs;

  RxInt subint = 0.obs;

  Rx<IconData> iconData = Icons.phonelink_erase_rounded.obs;
}