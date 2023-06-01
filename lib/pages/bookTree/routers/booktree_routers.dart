
import 'package:ceshi1/pages/bookTree/book_details.dart';
import 'package:get/get.dart';

import '../../../widgets/animation/slideanimation.dart';
import '../booktreeSearch.dart';
import 'booktree_page_id.dart';


class BookTreePages{
  BookTreePages._();
  static final routers = {
    GetPage(name: BookTreePageId.booktree,page: ()=>const AnimationsTB(child:  BookTreePage())),
    GetPage(name: BookTreePageId.bookdetails,page: ()=>const AnimationsTB(child:  BookDetailsPage())),
  };
}