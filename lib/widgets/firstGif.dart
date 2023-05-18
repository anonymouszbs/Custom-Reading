import 'dart:typed_data';

import 'package:flutter/material.dart';

import '../untils/utils_tool.dart';

class FirstGif extends StatefulWidget {
  final path;
  const FirstGif({super.key, this.path});

  @override
  State<FirstGif> createState() => _FirstGifState();
}

class _FirstGifState extends State<FirstGif> {
  late ByteData image;
  late bool isok = false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadimg();
  }

  loadimg() async {
    image = await UtilsToll.loadAssetImage(widget.path);
    isok = true;
    setState(() {
      
    });
  }

  @override
  Widget build(BuildContext context) {
    return isok?Image.memory( image.buffer.asUint8List(),fit: BoxFit.cover):Container();
  }
}
