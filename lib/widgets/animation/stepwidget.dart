




import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class StepWidget extends StatelessWidget {
  final progress;
  const StepWidget({super.key,required this.progress});

  
  @override
  Widget build(BuildContext context) {
    List array = [];
    int step = 0;
    if(double.tryParse(progress.toString())!<20){
      step = 1;
    }else if(double.tryParse(progress.toString())!<40){
      step = 2;
    }else if(double.tryParse(progress.toString())!<60){
      step = 3;
    }else if(double.tryParse(progress.toString())!<80){
      step = 4;
    }else if(double.tryParse(progress.toString())! ==100.00){
      step = 5;
    }

    for (var i = 1; i < 6; i++) {
         if(step>=i){
          array.add(true);
         }else{
          array.add(false);
         }
    }
    return SizedBox(
      width: ScreenUtil().setWidth(68),
      height:ScreenUtil().setHeight(16) ,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children:array.map((e){
          return SizedBox(
            width:ScreenUtil().setWidth(12) ,
            height: ScreenUtil().setHeight(16),
            child:e?Image.asset("assets/img/step_active.png") :Image.asset("assets/img/step.png") ,
          );
        }).toList() ,
      ),
    );
  }
}