import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MenuLeftBar extends StatefulWidget {
  final void Function(int index) onTap;
  const MenuLeftBar({super.key, required this.onTap});
  @override
  State<MenuLeftBar> createState() => _MenuLeftBarState();
}

class _MenuLeftBarState extends State<MenuLeftBar>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  List menulist = [
    {"探索发现":"tab_find"},
    {"学习档案":"tab_study"},
    {"荣誉室":"tab_honor"},
    {"在线考试":"tab_exam"}
  ];

  int currentindex = 0;
  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
   
  @override
  Widget build(BuildContext context) {
    return  Column(
      children: menulist.asMap().keys.map(( index){
        var key,value;
        menulist[index].entries.forEach((element) { 
          key = element.key;
          value = element.value;
        });
        
        return Container(
          padding: EdgeInsets.only(top: ScreenUtil().setHeight(50)),
          child: GestureDetector(
          onTap: (){
            widget.onTap(index);
            setState(() {
              currentindex = index;
            });
          },
          child: Row(
          children: [
            index==currentindex? SizedBox(width: 20,height: 20,child: Image.asset("assets/img/tab_arrow.png",fit: BoxFit.cover,),):Container(width: 20,),
            index==currentindex? Image.asset("assets/img/$value.png"):Image.asset("assets/img/${value}_normal.png"),
            Text(key,style: TextStyle(color: index==currentindex? Color(0xffFFCF61):Color(0xff666666),fontSize: ScreenUtil().setSp(24)),),
            
          ],
        ),
        ),
        );
      }).toList(),
    );
  }
}