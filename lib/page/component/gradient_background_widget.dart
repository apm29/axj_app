import 'dart:math';

import 'package:flutter/animation.dart';
import 'package:flutter/material.dart';

///
/// author : ciih
/// date : 2020-01-14 09:13
/// description :
///
class GradientBackgroundWidget extends StatefulWidget {
  @override
  _GradientBackgroundWidgetState createState() =>
      _GradientBackgroundWidgetState();
}

class _GradientBackgroundWidgetState extends State<GradientBackgroundWidget>
    with TickerProviderStateMixin {
  AnimationController colorController;
  var colorTween1 = ColorTween(
    begin: Color(0xffA83279),
    end: Colors.blue.shade600,
  );
  var colorTween2 = ColorTween(
    begin: Colors.lightBlue.shade900,
    end: Color(0xffD383f2),
  );

  Animation get colorAnimation =>
      CurvedAnimation(parent: colorController, curve: Curves.easeInOut);

  @override
  void initState() {
    colorController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 8800),
    );

    colorController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        colorController.reverse();
      } else if (status == AnimationStatus.dismissed) {
        colorController.forward();
      }
    });
    colorController.forward();
    super.initState();
  }

  @override
  void dispose() {
    colorController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: colorAnimation,
      builder: (context, child) => Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              colorTween1.evaluate(colorController),
              colorTween2.evaluate(colorController),
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        constraints: BoxConstraints.expand(),
        child: Stack(
          children: <Widget>[
            SizedBox.expand(
              child: Align(
                alignment: Alignment.bottomCenter,
                child: WaveAnimationWidget(),
              ),
            ),
            SizedBox.expand(
              child: Align(
                alignment: Alignment.bottomCenter,
                child: WaveAnimationWidget(
                  offset: pi/4,
                  duration: Duration(seconds: 8),
                  height: 120,
                ),
              ),
            ),
            SizedBox.expand(
              child: Align(
                alignment: Alignment.bottomCenter,
                child: WaveAnimationWidget(
                  offset: pi*2/3,
                  duration: Duration(seconds: 10),
                  height: 160,
                ),
              ),
            ),
            SizedBox.expand(
              child: Align(
                alignment: Alignment.bottomCenter,
                child: WaveAnimationWidget(
                  offset: pi/2,
                  duration: Duration(seconds: 12),
                  height: 160,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class WaveAnimationWidget extends StatefulWidget {
  final double height;
  final Duration duration;
  final double offset;

  const WaveAnimationWidget({
    Key key,
    this.height: 100,
    this.duration: const Duration(seconds: 6),
    this.offset: 0,
  }) : super(key: key);

  @override
  _WaveAnimationWidgetState createState() => _WaveAnimationWidgetState();
}

class _WaveAnimationWidgetState extends State<WaveAnimationWidget>
    with TickerProviderStateMixin {
  AnimationController controller;

  @override
  void initState() {
    controller = AnimationController(vsync: this, duration: widget.duration);
    controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        controller.reset();
        controller.forward();
      } else if (status == AnimationStatus.dismissed) {
        controller.forward();
      }
    });
    controller.forward();
    super.initState();
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      builder: (context, child) {
        return LayoutBuilder(
          builder: (context, constraint) => SizedBox(
            width: constraint.maxWidth,
            height: widget.height,
            child: CustomPaint(
              foregroundPainter: CurvePainter(
                Tween(begin: 0.0, end: 2 * pi).evaluate(controller) +
                    widget.offset,
              ),
            ),
          ),
        );
      },
      animation: controller,
    );
  }
}

class CurvePainter extends CustomPainter {
  final double value;

  CurvePainter(this.value);

  @override
  void paint(Canvas canvas, Size size) {
    final white = Paint()..color = Colors.white.withAlpha(60);
    final path = Path();

    final y1 = sin(value);
    final y2 = sin(value + pi / 2);
    final y3 = sin(value + pi);

    final startPointY = size.height * (0.5 + 0.4 * y1);
    final controlPointY = size.height * (0.5 + 0.4 * y2);
    final endPointY = size.height * (0.5 + 0.4 * y3);

    path.moveTo(size.width * 0, startPointY);
    path.quadraticBezierTo(
        size.width * 0.5, controlPointY, size.width, endPointY);
    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);
    path.close();
    canvas.drawPath(path, white);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
