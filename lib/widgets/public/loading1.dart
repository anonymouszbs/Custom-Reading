import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

enum LoaddingState{ERROR,LOADDING}

class Loading1 extends StatelessWidget {
  final LoaddingState state;
  const Loading1({super.key,  this.state = LoaddingState.LOADDING});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      width: ScreenUtil().screenWidth,
      height: ScreenUtil().screenHeight,
      child: state==LoaddingState.LOADDING? Image.asset("assets/img/loading1.webp",fit: BoxFit.cover,):Text("没有数据",style: TextStyle(color: Colors.white),),
    );
  }
}