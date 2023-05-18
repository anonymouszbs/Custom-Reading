import 'package:ceshi1/common/commpents/reader/routers.dart/reader_routers.dart';
import 'package:ceshi1/pages/home/routers/home_routers.dart';
import 'package:get/get.dart';

class Routers {
  static List<GetPage> getAllRoutes(){
    return [
      ...ReaderPages.routers,
      ...HomePages.routers
    ];
  }
}