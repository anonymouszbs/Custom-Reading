import 'package:flutter/material.dart';

class CirculAnmation extends StatefulWidget {
  final child;
  final cease;
  const CirculAnmation({super.key, this.child, this.cease});

  @override
  State<CirculAnmation> createState() => _CirculAnmationState();
}

class _CirculAnmationState extends State<CirculAnmation>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    )..repeat();
    _animation = Tween(begin: 0.0, end: 1.0).animate(_controller);
   
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
     if (widget.cease == false) {
      _controller.stop();
      // _controller.stop();
       _controller.reset();
    } else {
      _controller.repeat();
    }
    return RotationTransition(
      turns: _animation,
      child: widget.child,
    );
  }
}
