import 'dart:ui';

import 'package:flutter/material.dart';

class GaussBlurBackground extends StatelessWidget {
  final Widget child;

  const GaussBlurBackground({Key key, this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: <Widget>[
        Container(
          child: Image.asset('assets/images/city_night.png',fit: BoxFit.fill,),
        ),
        ClipRect(
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
            child: Container(
              //color: Color(0x77151023),
              color: Colors.white.withAlpha(0x77),
            ),
          ),
        ),
        child ?? Container(),
      ],
    );
  }
}
