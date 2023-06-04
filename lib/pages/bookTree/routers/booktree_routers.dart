
import 'package:ceshi1/pages/bookTree/book_details.dart';
import 'package:ceshi1/pages/bookTree/document/document.dart';
import 'package:get/get.dart';

import '../../../widgets/animation/slideanimation.dart';
import '../booktreeSearch.dart';
import '../video/video.dart';
import 'booktree_page_id.dart';


class BookTreePages{
  BookTreePages._();
  static final routers = {
    GetPage(name: BookTreePageId.booktree,page: ()=>const AnimationsTB(child:  BookTreePage())),
    GetPage(name: BookTreePageId.bookdetails,page: ()=>const AnimationsTB(child:   BookDetailsPage())),
    GetPage(name: BookTreePageId.video,page: ()=> const VideoPlayScreen()),
    GetPage(name: BookTreePageId.documentpdf,page: ()=>const DocumentPdf())
  };
}