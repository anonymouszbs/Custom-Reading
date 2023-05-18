import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../widgets/animation.dart';
import '../contants/theme.dart';

class MenuFont extends StatelessWidget {
  final void Function(int index) onButtonTap;
  const MenuFont({super.key, required this.onButtonTap});

  @override
  Widget build(BuildContext context) {
    final textSizeBList = [
      22,26,28,20,18,16,14,12
    ];
    return AnimationsPY(
        padding: EdgeInsets.only(top: ScreenUtil().screenHeight*0.5-50),
        frame: Obx(()=> Container(
            color: ReaderThemeC.current.theme.value.pannelBackgroundColor,
            width: MediaQuery.of(context).size.width,
            height: (ScreenUtil().screenHeight-110)*0.8,
            child:Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                padding: const EdgeInsets.only(left: 16, top: 16, bottom: 16),
                child: Text(
                  "文字与排版",
                  style: TextStyle(color: ReaderThemeC.current.theme.value.pannelTextColor, fontSize: 16, fontWeight: FontWeight.w600),
                ),
              ),
              Expanded(child:Container(
                 padding: const EdgeInsets.only(left: 16, top: 0, bottom: 16,right: 16),
                child:  Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: textSizeBList.map((e){
                  return ElevatedButton(child: Text("${e}PX"),onPressed: (){
                     onButtonTap(e);

                  },style: ElevatedButton.styleFrom(
                    backgroundColor: ReaderThemeC.current.theme.value.pannelTextColor
                  ),);
                }).toList(),
              ),
              )),
              Container(
                padding: const EdgeInsets.only(left: 16, top: 0, bottom: 16,right: 16),
                width: ScreenUtil().screenWidth,
                height:ScreenUtil().screenHeight* 0.30,
                child:Container(
                  padding: const EdgeInsets.only(left: 16, top: 0, bottom: 0,right: 16),
                  color: ReaderThemeC.current.theme.value.readerBackgroundColor,
                  child: Text("\t\t\t这是一段示例文字。This is an example sentence. This is another example sentence. 这是另一段示例文字。",style: TextStyle(color:ReaderThemeC.current.theme.value.readerTextColor,fontSize:ReaderThemeC.current.readerFontSize.value),maxLines: null,
                  textAlign: TextAlign.justify,) ,
                ),
              )
              ],
            )
            )
            ), tab: ReaduiType.LEFT,);
  }
}