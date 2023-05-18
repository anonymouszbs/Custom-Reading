import 'package:ceshi1/common/commpents/reader/contants/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../widgets/animation.dart';

// ignore: must_be_immutable
class MenuToc extends StatelessWidget {
  final List chapters;
  final void Function(int index,String type) onItemTap;
  MenuToc({super.key, required this.chapters, required this.onItemTap});

  @override
  Widget build(BuildContext context) {

    return AnimationsPY(
        padding: EdgeInsets.only(top: ScreenUtil().screenHeight*0.3-50),
        frame: Container(
            
            color: ReaderThemeC.current.theme.value.pannelBackgroundColor,
            width: MediaQuery.of(context).size.width,
            height: (ScreenUtil().screenHeight-110)*0.8,
            child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.only(left: 16, top: 16, bottom: 16),
                child: Text(
                  "目录",
                  style: TextStyle(color: ReaderThemeC.current.theme.value.pannelTextColor, fontSize: 16, fontWeight: FontWeight.w600),
                ),
              ),
              Expanded(
                  child: MediaQuery.removePadding(
                      removeTop: true,
                      removeBottom: true,
                      context: context,
                      child: ListView.separated(
                          physics: const ClampingScrollPhysics(),
                          controller: ReaderThemeC.current.scrollController,
                          cacheExtent: 46,
                          itemBuilder: (context, index) {
                            if (index == 0) {
                              return const SizedBox(
                                height: 1,
                              );
                            } else {
                              final chapter = chapters[index - 1];
                              return InkWell(
                                onTap: () {
                                  ReaderThemeC.current.currentindex.value = index - 1;
                                  onItemTap(index - 1, chapter['href']);
                                },
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                                  child: Obx(() =>  Text(
                                    chapter['label'],
                                    style:  TextStyle(
                                        color: ReaderThemeC.current.currentindex.value==(index - 1)
                                            ? ReaderThemeC.current.theme.value.primaryColor
                                            : ReaderThemeC.current.theme.value.pannelTextColor,
                                        fontSize: 13),
                                  ),
                                ),
                              ));
                            }
                          },
                          separatorBuilder: (BuildContext context, int index) {
                            return Divider(
                              indent: 16,
                              endIndent: 16,
                              height: 0,
                              thickness: 0.4,
                              color: ReaderThemeC.current.theme.value.dividerColor,
                            );
                          },
                          itemCount: chapters.length + 1)))
            ],
          )),tab: ReaduiType.LEFT,);
  }
}