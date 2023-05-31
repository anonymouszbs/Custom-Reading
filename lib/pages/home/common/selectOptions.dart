
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SlectOptions extends StatefulWidget {
  ///数组
  final Function(String value) onChanged;
  final  options;
  ///选中项
  final dropdownValue;
  const SlectOptions({super.key,required this.options,required this.dropdownValue, required this.onChanged});

  @override
  State<SlectOptions> createState() => _SlectOptionsState();
}

class _SlectOptionsState extends State<SlectOptions> {
  var options,dropdownValue;
  @override
  void initState() {
     options = widget.options;
    dropdownValue = widget.dropdownValue;
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return   Container(
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
                items: options.map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Row(
                      children: [
                        Text(
                          value,
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: ScreenUtil().setSp(18)),
                        ),
                       SizedBox(width: ScreenUtil().setWidth(50),)
                       
                      ],
                    ),
                  );
                }).toList(),
                onChanged: (newValue) {
                  setState(() {
                    dropdownValue = newValue!;
                    widget.onChanged(newValue);
                  });
                },
              ),
            )
           ;
  }
}