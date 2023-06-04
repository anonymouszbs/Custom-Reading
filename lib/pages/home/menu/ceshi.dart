import 'dart:io';

import 'package:ceshi1/public/public_class_bean.dart';
import 'package:ceshi1/public/public_function.dart';
import 'package:ceshi1/untils/sp_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sticky_and_expandable_list/sticky_and_expandable_list.dart';

import '../../../common/commpents/reader/routers.dart/reader_page_id.dart';
import '../../../common/network/download.dart';
import '../../../config/dataconfig/normal_string_config.dart';
import '../../../untils/getx_untils.dart';
import '../../../untils/utils_tool.dart';
import '../widgets/mock.dart';

class ExampleCustomSectionAnimation extends StatefulWidget {
  @override
  _ExampleCustomSectionAnimationState createState() =>
      _ExampleCustomSectionAnimationState();
}

class _ExampleCustomSectionAnimationState
    extends State<ExampleCustomSectionAnimation> {
  var sectionList = MockData.getExampleSections(3, 3);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: ExpandableListView(
        builder: SliverExpandableChildDelegate<String, ExampleSection>(
          sectionList: sectionList,
          itemBuilder: (context, sectionIndex, itemIndex, index) {
            String item = sectionList[sectionIndex].items[itemIndex];
            String note = sectionList[sectionIndex].note[itemIndex];
            String cfg = sectionList[sectionIndex].cfg[itemIndex];
            return InkWell(
              focusColor: Colors.black,
              onTap: () {
                print(SpUtil.getKeys());
                var id = sectionList[sectionIndex].id.toString();
                  print(id);
                BookInfoMap bookInfoMap = getBookInfoidMap(id: id);

                SourceMap sourceMap = getsourceidMap(id: id);

       print(cfg);
                
  // var filename = File(sourceMap)
  //                   .path
  //                   .split('/')
  //                   .last;
  //               UtilsToll().copyFiles(
  //                   sourcePath: bookDownloadList[index]["FilePath"],
  //                   destinationPath: DonwloadSource.current.sourcePath);
                currentToPage(ReaderPageId.reader,
                    arguments: [sourceMap.filepath, {"id":id,"posi":cfg}]);



                // List<Map<dynamic, dynamic>> bookDownloadList = [];
                // bookDownloadList = getBookDownloadList(id: id);

                // print(bookDownloadList);
                // var filename = File(bookDownloadList[index]["FilePath"])
                //     .path
                //     .split('/')
                //     .last;
                // UtilsToll().copyFiles(
                //     sourcePath: bookDownloadList[index]["FilePath"],
                //     destinationPath: DonwloadSource.current.sourcePath);
                // currentToPage(ReaderPageId.reader,
                //     arguments: [filename, bookDownloadList[index]]);
              },
              child: ListTile(
                leading: SizedBox(
                  width: 30.w,
                  height: 30.w,
                  child: CircleAvatar(
                    backgroundColor: Colors.tealAccent,
                    child: Text(
                      "$index",
                      style: TextStyle(color: Colors.black),
                    ),
                  ),
                ),
                title: Text(
                  "划线段落：" + item,
                  style: TextStyle(color: Colors.white),
                  maxLines: 2,
                ),
                trailing: SizedBox(
                  width: 300.w,
                  child: Text(
                    note == "空_" ? "" : "笔记：" + note,
                    style: TextStyle(color: Colors.white),
                    maxLines: 1,
                  ),
                ),
              ),
            );
          },
          sectionBuilder: (context, containerInfo) => _SectionWidget(
            section: sectionList[containerInfo.sectionIndex],
            containerInfo: containerInfo,
            onStateChanged: () {
              //notify ExpandableListView that expand state has changed.
              WidgetsBinding.instance.addPostFrameCallback((_) {
                if (mounted) {
                  setState(() {});
                }
              });
            },
          ),
        ),
      ),
    );
  }
}

class _SectionWidget extends StatefulWidget {
  final ExampleSection section;
  final ExpandableSectionContainerInfo containerInfo;
  final VoidCallback onStateChanged;

  _SectionWidget(
      {required this.section,
      required this.containerInfo,
      required this.onStateChanged});

  @override
  __SectionWidgetState createState() => __SectionWidgetState();
}

class __SectionWidgetState extends State<_SectionWidget>
    with SingleTickerProviderStateMixin {
  static final Animatable<double> _halfTween =
      Tween<double>(begin: 0.0, end: 0.5);
  late AnimationController _controller;

  late Animation _iconTurns;

  late Animation<double> _heightFactor;

  @override
  void initState() {
    super.initState();
    _controller =
        AnimationController(vsync: this, duration: Duration(milliseconds: 300));
    _iconTurns =
        _controller.drive(_halfTween.chain(CurveTween(curve: Curves.easeIn)));
    _heightFactor = _controller.drive(CurveTween(curve: Curves.easeIn));

    if (widget.section.isSectionExpanded()) {
      _controller.value = 1;
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    widget.containerInfo
      ..header = _buildHeader(context)
      ..content = _buildContent(context);
    return ExpandableSectionContainer(
      info: widget.containerInfo,
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Container(
      //color: Color.fromRGBO(255, 222, 146, 0.8),
      height: 80.h,
      child: ListTile(
        title: Text(
          widget.section.header,
          style: TextStyle(color: Color.fromRGBO(255, 222, 146, 0.8)),
        ),
        trailing: RotationTransition(
          turns: _iconTurns as Animation<double>,
          child: const Icon(
            Icons.expand_more,
            color: Colors.white70,
          ),
        ),
        onTap: _onTap,
      ),
    );
  }

  void _onTap() {
    widget.section.setSectionExpanded(!widget.section.isSectionExpanded());
    if (widget.section.isSectionExpanded()) {
      widget.onStateChanged();
      _controller.forward();
    } else {
      _controller.reverse().then((_) {
        widget.onStateChanged();
      });
    }
  }

  Widget _buildContent(BuildContext context) {
    return SizeTransition(
      sizeFactor: _heightFactor,
      child: SliverExpandableChildDelegate.buildDefaultContent(
          context, widget.containerInfo),
    );
  }
}
