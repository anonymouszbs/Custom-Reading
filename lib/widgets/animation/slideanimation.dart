import 'package:flutter/material.dart';


class AnimationsRL extends StatefulWidget {
  final child;

  //平移动化

   const AnimationsRL(
      {Key? key,
      required this.child,
      })
      : super(key: key);

  @override
  State<AnimationsRL> createState() => _AnimationsRLState();
}

class _AnimationsRLState extends State<AnimationsRL>
    with SingleTickerProviderStateMixin {
      late AnimationController animationController;
  @override
  void initState() {
   animationController = AnimationController(
        duration: const Duration(milliseconds: 600), vsync: this);
    animationController.forward();
    super.initState();
  }

  @override
  void dispose() {
    animationController.forward();
   animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
   return Container(
          alignment: Alignment.bottomCenter,
          child: SizeTransition(
              axis: Axis.vertical,
              sizeFactor: CurvedAnimation(
                  parent: animationController,
                  curve: Curves.easeInToLinear),
              child: Material(
                  child:widget.child)),
        );
    }
  
}
class AnimationsTB extends StatefulWidget {
  final child;

  //平移动化

   const AnimationsTB(
      {Key? key,
      required this.child,
      })
      : super(key: key);

  @override
  State<AnimationsTB> createState() => _AnimationsTBState();
}

class _AnimationsTBState extends State<AnimationsTB>
    with SingleTickerProviderStateMixin {
      late AnimationController animationController;
  @override
  void initState() {
   animationController = AnimationController(
        duration: const Duration(milliseconds: 600), vsync: this);
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
   return Container(
          alignment: Alignment.topCenter,
          child: SizeTransition(
              axis: Axis.vertical,
              sizeFactor: CurvedAnimation(
                  parent: animationController,
                  curve: Curves.easeInToLinear),
              child: Material(
                  child:widget.child)),
        );
    }
  
}