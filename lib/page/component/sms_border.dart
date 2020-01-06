import 'dart:io';
import 'dart:ui';

import 'package:flutter/material.dart';

///
/// author : ciih
/// date : 2019-12-30 14:35
/// description : 
///
abstract class AbsInputBorder extends UnderlineInputBorder {
  final double textSize;
  final double letterSpace;
  final int textLength;

  final double startOffset;

  double calcTrueTextSize() {
    // 测量单个数字实际长度
    var paragraph = ParagraphBuilder(ParagraphStyle(fontSize: textSize))
      ..addText("8");
    var p = paragraph.build()
      ..layout(ParagraphConstraints(width: double.infinity));
    return p.minIntrinsicWidth;
  }

  AbsInputBorder({
    this.textSize = 0.0,
    this.letterSpace = 0.0,
    this.textLength,
    BorderSide borderSide = const BorderSide(),
  })  : startOffset = letterSpace * 0.5,
        super(borderSide: borderSide) {
    calcTrueTextSize();
  }
}

class CustomRectInputBorder extends AbsInputBorder {
  CustomRectInputBorder({
    double textSize = 0.0,
    @required double letterSpace,
    @required int textLength,
    BorderSide borderSide = const BorderSide(),
  }) : super(
      textSize: textSize,
      letterSpace: letterSpace,
      textLength: textLength,
      borderSide: borderSide);

  @override
  void paint(
      Canvas canvas,
      Rect rect, {
        double gapStart,
        double gapExtent = 0.0,
        double gapPercentage = 0.0,
        TextDirection textDirection,
      }) {
    double textTrueWidth = calcTrueTextSize();
    double offsetX = textTrueWidth * 0.5;

    double offsetY = textTrueWidth * 0.5;
    double curStartX = rect.left + startOffset - offsetX;
    if (!Platform.isIOS) {
      for (int i = 0; i < textLength; i++) {
        Rect r = Rect.fromLTWH(curStartX, rect.top + offsetY,
            textTrueWidth + offsetX * 2, rect.height - offsetY * 2);
        canvas.drawRRect(RRect.fromRectAndRadius(r, Radius.circular(6)),
            borderSide.toPaint());
        curStartX += (textTrueWidth + letterSpace);
      }
    } else {
      curStartX = 3;
      double width = rect.width / 6;
      for (int i = 0; i < textLength; i++) {
        Rect r =
        Rect.fromLTWH(curStartX, rect.top + 4, width - 6, rect.height - 8);
        canvas.drawRRect(RRect.fromRectAndRadius(r, Radius.circular(6)),
            borderSide.toPaint());
        curStartX += (width);
      }
    }
  }
}