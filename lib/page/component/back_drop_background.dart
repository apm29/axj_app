import 'dart:ui';

import 'package:flutter/material.dart';

class GaussBlurBackground extends StatelessWidget {
  final Widget child;
  final String assetPath;
  final double sigmaX;
  final double sigmaY;

  const GaussBlurBackground({
    Key key,
    this.child,
    this.assetPath: 'assets/images/city_night.png',
    this.sigmaX:5,
    this.sigmaY:5,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if(sigmaX==sigmaY&&sigmaX==0){
      return Stack(
        fit: StackFit.expand,
        children: <Widget>[
          Container(
            child: Image.asset(
              assetPath,
              fit: BoxFit.fill,
            ),
          ),
          child
        ],
      );
    }
    return Stack(
      fit: StackFit.expand,
      children: <Widget>[
        Container(
          child: Image.asset(
            assetPath,
            fit: BoxFit.fill,
          ),
        ),
        ClipRect(
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: sigmaX, sigmaY: sigmaY),
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
