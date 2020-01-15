import 'dart:ui';
import 'package:axj_app/utils.dart';
import 'package:flutter/material.dart';

///
/// author : ciih
/// date : 2020-01-15 15:11
/// description :
///
class BottomFadeContainer extends StatelessWidget {
  final Text child;
  final Color maskColor;

  const BottomFadeContainer({Key key, this.child, this.maskColor})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraint) {
        Size size = calcTrueTextSize(child.style.fontSize, child.data);
        print(size);
        Gradient gradient = LinearGradient(
          colors: [
            child.style.color,
            Colors.transparent,
          ],
          stops: [
            0.5,1.0
          ],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        );
        Shader shader = gradient.createShader(
          Rect.fromLTWH(0, 0, size.width, 200)
        );
        return Text(
          child.data,
          style:
              child.style.copyWith(foreground: Paint()..shader = shader),
        );
      },
    );
  }
}
