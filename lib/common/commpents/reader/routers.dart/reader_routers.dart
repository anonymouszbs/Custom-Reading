import 'package:ceshi1/common/commpents/reader/reader_view.dart';
import 'package:ceshi1/common/commpents/reader/routers.dart/reader_page_id.dart';
import 'package:get/get.dart';


class ReaderPages{
  ReaderPages._();
  static final routers = {
    GetPage(name: ReaderPageId.reader,page: ()=>const ReaderViewPage()),
   
  };
}