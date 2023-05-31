import 'dart:async';

import 'package:flutter/material.dart';

class FlipDisappear extends StatefulWidget {
  final Widget child;
  final VoidCallback onDisappear;
  final  AnimationController controller;
  const FlipDisappear({
    required Key key,
    required this.child,
    required this.onDisappear,
    required this.controller,
  }) : super(key: key);

  @override
  _FlipDisappearState createState() => _FlipDisappearState();
}

class _FlipDisappearState extends State<FlipDisappear>
    with SingleTickerProviderStateMixin {

  late Animation<double> _animation;

  @override
  void initState() {
      
    _animation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: widget.controller,
      curve: Curves.easeInOutQuad,
    ))
      ..addListener(() {
        setState(() {});
      })
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          widget.onDisappear.call();
          widget.controller.dispose();
          
        }
      });
    super.initState();
 
  }

  @override
  void dispose() {
    //widget.controller.dispose();
    super.dispose();
  }

  forward(){
     widget.controller.forward();
    Timer(Duration(milliseconds: 1), () { 
       widget.controller.dispose();
      super.dispose();
    });
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        final value = _animation.value;
        final angleX = value * -90;
        final angleY = value * 360;
        return Opacity(
          opacity: 1 - value,
          child: Transform(
            alignment: Alignment.center,
            transform: Matrix4.identity()
              ..setEntry(3, 2, 0.001)
              ..rotateX(angleX * (3.1415927 / 360))
              ..rotateY(angleY * (3.1415927 / 360)),
            child: widget.child,
          ),
        );
      },
    );
  }
}
