import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

enum ReaduiType { BOTTOM, TOP, LEFT, RIGHT, CENTER }

class AnimationsPY extends StatefulWidget {
  //平移动化
  final Widget frame;
  final ReaduiType tab;
  final EdgeInsetsGeometry padding;
  const AnimationsPY(
      {Key? key, required this.frame, required this.tab, required this.padding})
      : super(key: key);

  @override
  State<AnimationsPY> createState() => _AnimationsPYState();
}

class _AnimationsPYState extends State<AnimationsPY>
    with SingleTickerProviderStateMixin {
  late AnimationController animationController;
  @override
  void initState() {
    animationController = AnimationController(
        duration: const Duration(milliseconds: 300), vsync: this);
    animationController.forward();
    super.initState();
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    switch (widget.tab) {
      case ReaduiType.BOTTOM:
        return Container(
          alignment: Alignment.bottomCenter,
          child: SizeTransition(
              axis: Axis.vertical,
              sizeFactor: CurvedAnimation(
                  parent: animationController, curve: Curves.easeInToLinear),
              child: Material(
                child: widget.frame,
              )),
        );
      case ReaduiType.TOP:
        return Container(
            alignment: Alignment.topCenter,
            //padding: EdgeInsets.only(top:40),
            child: SizeTransition(
                axis: Axis.vertical,
                sizeFactor: CurvedAnimation(
                    parent: animationController, curve: Curves.easeInToLinear),
                child: Material(child: widget.frame)));
      case ReaduiType.RIGHT:
        return Container(
            alignment: Alignment.topRight,
            child: SizeTransition(
                axis: Axis.horizontal,
                sizeFactor: CurvedAnimation(
                    parent: animationController, curve: Curves.easeInBack),
                child: Material(
                    color: Colors.transparent,
                    child: Container(
                      decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(color: Colors.black.withOpacity(0.3))
                        ],
                      ),
                      width: 200,
                      height: ScreenUtil().screenHeight,
                      child: Center(
                        child: widget.frame,
                      ),
                    ))));
      case ReaduiType.LEFT:
        return Container(
          padding: const EdgeInsets.only(bottom: 50),
          alignment: Alignment.bottomCenter,
          child: SizeTransition(
            axis: Axis.vertical,
            sizeFactor: CurvedAnimation(
                parent: animationController, curve: Curves.easeInBack),
            child: Material(
              child: widget.frame,
            ),
          ),
        );
      default:
        return Container(
            alignment: Alignment.bottomCenter,
            padding: widget.padding,
            child: SizeTransition(
                axis: Axis.horizontal,
                sizeFactor: CurvedAnimation(
                    parent: animationController, curve: Curves.easeInBack),
                child: Material(
                  child: widget.frame,
                )));
    }
  }
}
