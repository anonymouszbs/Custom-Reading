
import 'package:ceshi1/pages/home/routers/home_page_id.dart';
import 'package:ceshi1/pages/home/setting.dart';
import 'package:get/get.dart';


class HomePages{
  HomePages._();
  static final routers = {
    GetPage(name: HomePageId.home,page: ()=>const Settings()),
   
  };
}