
import 'dart:convert';

import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../common/network/ApiServices.dart';
import '../../../config/controller/user_state_controller.dart';

class SelectDimension2 extends StatefulWidget {
  final Function(int dimension2) ondimension2;
  const SelectDimension2({super.key,required this.ondimension2});

  @override
  State<SelectDimension2> createState() => _SelectDimension2State();
}

class _SelectDimension2State extends State<SelectDimension2> {
  var options = [];String dropdownValue="";
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getScondaryLevel();
  }
  getScondaryLevel() async {
    var data = {
      "username": UserStateController.current.user.username,
      "pwd": UserStateController.current.user.pwd
    };
    var reponse = await ApiService.getSeconDaryLevel(data);
    var jsondata = json.decode(reponse.data);

    if (jsondata['code'] == 1) {
      dropdownValue =  jsondata['data'][0]["lbmc"].toString();
      options = jsondata['data'];
      setState(() {
        
        print(dropdownValue);
       
      });
    } else {
      BotToast.showText(text: "获取二级分类错误");
    }
  }
  @override
  Widget build(BuildContext context) {
    return options.isEmpty?Container():  Container(
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(5)),
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Color.fromRGBO(255, 255, 255, 0),
                    Color.fromRGBO(255, 255, 255, 0.12)
                  ],
                ),
              ),
              child: DropdownButton<String>(
                underline: Container(),
                dropdownColor: Colors.black26, //下拉背景色
                value: dropdownValue,
                items: options.asMap().keys.map<DropdownMenuItem<String>>(( index) {
                  return DropdownMenuItem<String>(
                    value: options[index]["lbmc"].toString(),
                    child: Row(
                      children: [
                        Text(
                          options[index]["lbmc"],
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: ScreenUtil().setSp(18)),
                        ),
                       SizedBox(width: ScreenUtil().setWidth(50),)
                       
                      ],
                    )
                    
                  );
                }).toList(),
                onChanged: (newValue) {
                  setState(() {
                    dropdownValue = newValue!;
                  });
                  final Map<String, dynamic>? result = options.where((element) => element['lbmc'] == newValue).first;
                  int id = result!['id'];
                  widget.ondimension2(id);
                },
              ),
            )
           ;
  }
}