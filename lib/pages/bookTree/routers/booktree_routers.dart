
import 'package:get/get.dart';

import '../../../widgets/animation/slideanimation.dart';
import '../booktreeSearch.dart';
import 'booktree_page_id.dart';


class BookTreePages{
  BookTreePages._();
  static final routers = {
    GetPage(name: BookTreePageId.booktree,page: ()=>const AnimationsTB(child:  BookTreePage())),
   
  };
}