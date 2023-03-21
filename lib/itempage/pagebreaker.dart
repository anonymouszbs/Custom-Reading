import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'dart:ui' as ui;
import '../DisplayConfig.dart';

class PageBreaker {
  TextSpan contentString;
  Size drawSize;
  List<String> image;
  //SelectableTextz selectableText;

  PageBreaker(this.contentString, this.drawSize, this.image);

  int getRegExpLength(txt) {
    final text = txt;
    final pattern = RegExp('☏');
    final matches = pattern.allMatches(text);
    final count = matches.length;
    return count;
  }

  splitPage() {
    //当前页面文字
    int imglength = 0;
    String currentText = "${contentString.text} ";
    String overText = '';
    List<YdPage> results = [];
    List imgtop = [];
    double qmaybeheight;
    while (currentText.isNotEmpty) {
      var maxlength = currentText.length;
      var minlength = 0;
      var maybelength = 0;

      while (true) {
        maybelength = ((maxlength - minlength) / 2).truncate() + minlength;

        var maybeText = currentText.substring(0, maybelength);

        var tempspan = TextSpan(text: maybeText, style: contentString.style);
        var contentPainter = TextPainter(
          text: tempspan,
          textDirection: TextDirection.ltr,
        );
        
        contentPainter.layout(maxWidth: drawSize.width);
        
        var maybeheight = contentPainter.height;

        qmaybeheight = maybeheight;

        if (maybeheight > drawSize.height) {
          maxlength = maybelength;
        } else {
          if (maybeText.contains('☏')) {
            break;
          }
          if (minlength == maybelength) {
            break;
          }
          minlength = maybelength;
        }
      }

      overText = currentText.substring(maybelength);

      currentText = currentText.substring(0, maybelength);
     
      YdPage temppage;

      if (currentText.contains("☏")) {
        print("好多次哦");
        List<String> img = [];
        img.add(image[imglength++]);
     
        currentText = currentText.replaceAll(RegExp('☏'), "");
        overText = currentText + overText;
        temppage = YdPage(" ", img);
        print(results.length);
      } else {
        temppage = YdPage(currentText, null);
      }

      results.add(temppage);
 if (currentText.trim().isEmpty) {
        break;
      }
      currentText = overText;
      
    }
    print(imgtop);
    return results;
  }
}

class YdPage {
  String? text;
  List<String>? image;
  YdPage(this.text, this.image);
}
