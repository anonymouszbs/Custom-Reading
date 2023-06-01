import 'package:ceshi1/common/commpents/reader/routers.dart/reader_routers.dart';
import 'package:ceshi1/pages/bookTree/routers/booktree_routers.dart';
import 'package:ceshi1/pages/home/routers/home_routers.dart';
import 'package:ceshi1/pages/login/routers/login_routers.dart';
import 'package:ceshi1/pages/my/routers/my_routers.dart';
import 'package:get/get.dart';

class Routers {
  static List<GetPage> getAllRoutes(){
    return [
      ...ReaderPages.routers,
      ...HomePages.routers,
      ...LoginPages.routers,
      ...BookTreePages.routers,
      ...MyPages.routers,
    
    ];
  }
}