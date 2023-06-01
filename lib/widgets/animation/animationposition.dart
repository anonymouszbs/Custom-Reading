import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';

import '../../pages/home/controller/leftbarcontroller.dart';


class AnimatedMoveToPosition extends StatefulWidget {
  final Widget moveWidget;
  final Offset startPosition;
  final Offset endPosition;
  final void Function() onRemove;
  const AnimatedMoveToPosition({
    required this.moveWidget,
    required this.startPosition,
    required this.endPosition,
    Key? key, required this.onRemove,
  }) : super(key: key);

  @override
  _AnimatedMoveToPositionState createState() => _AnimatedMoveToPositionState();
}

class _AnimatedMoveToPositionState extends State<AnimatedMoveToPosition> {
  bool _isMoved = false;

  @override
  void initState() {
    super.initState();
    _animateToPosition();
  }
 @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return 
       AnimatedPositioned(
          duration: const Duration(seconds: 1),
          curve: Curves.easeInOut,
          onEnd: () {
           
           widget.onRemove();
          },
          left: _isMoved==false?widget.startPosition.dx:widget.endPosition.dx,
          top:_isMoved==false?widget.startPosition.dy:widget.endPosition.dy ,
          child: widget.moveWidget,
     
      
    );
  }

  void _animateToPosition() async {
    await Future.delayed(Duration(milliseconds: 200));
    setState(() {
      _isMoved = true;
    });
  }
}
