


import 'package:ceshi1/common/commpents/reader/reader_view.dart';

import 'package:flutter/material.dart';


import '../../common/commpents/reader/utils/utilstool.dart';



class Settings extends StatefulWidget {
  const Settings({super.key});

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  @override
  void initState() {
    // TODO: implement initState
    
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          ElevatedButton.icon(
              onPressed: () async {
                await copyDemoToSandBox(); //拷贝服务器目录到沙盒
                 
              },
              icon:  Icon(Icons.event),
              label:  Text("下载并移动文件到临时目录")),
              ElevatedButton.icon(
              onPressed: () async {
                await startserver(); //拷贝服务器目录到沙盒
              },
              icon:  Icon(Icons.star_rate_sharp),
              label:  Text("开启服务器")),
          ElevatedButton.icon(
              onPressed: () async {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ReaderViewPage()),
                );
              },
              icon: Icon(Icons.event),
              label: Text("跳转阅读页")),

              ElevatedButton.icon(
              onPressed: () async {
              
              },
              icon: Icon(Icons.event),
              label: Text("文字识别")),
        ],
      ),
    );
  }
}
