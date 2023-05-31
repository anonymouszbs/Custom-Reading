
import 'package:ceshi1/pages/my/mypage.dart';
import 'package:get/get.dart';

import '../../../widgets/animation/slideanimation.dart';
import 'my_page_id.dart';


class MyPages{
  MyPages._();
  static final routers = {
    GetPage(name: MYPageId.index,page: ()=>const AnimationsTB(child: Mypage())),
  
  };
}