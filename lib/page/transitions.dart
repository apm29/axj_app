import 'package:flutter/material.dart';
///
/// author : ciih
/// date : 2020-01-07 16:37
/// description :
///
class TingleTransition extends StatefulWidget {
  final Widget child;
  final int tingleCount;
  final double tingleThreshold;
  final int tingleTime;

  TingleTransition({
    @required this.child,
    this.tingleCount = 6,
    this.tingleThreshold = 10,
    this.tingleTime = 40,
  });

  @override
  _TingleTransitionState createState() => _TingleTransitionState(tingleCount);
}

class _TingleTransitionState extends State<TingleTransition>
    with TickerProviderStateMixin {
  AnimationController controller;


  _TingleTransitionState(this.count);

  int count = 0;

  @override
  void initState() {
    controller = AnimationController(
      vsync: this,
      duration: Duration(
        milliseconds: widget.tingleTime,
      ),
    );
    controller.addStatusListener((status) {
      if (count <= 0) {
        controller.reset();
        return;
      }
      if (status == AnimationStatus.completed) {
        controller.reverse().orCancel;
        count -= 1;
      } else if (status == AnimationStatus.dismissed) {
        controller.forward().orCancel;
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
      animation: controller,
      builder: (context, child) {
        return Stack(
          children: <Widget>[
            Positioned.fromRelativeRect(
              rect: RelativeRectTween(
                begin: RelativeRect.fromLTRB(0, 0, 0, 0),
                end: RelativeRect.fromLTRB(
                  widget.tingleThreshold,
                  widget.tingleThreshold,
                  -widget.tingleThreshold,
                  -widget.tingleThreshold,
                ),
              ).animate(controller).value,
              child: child,
            ),
          ],
        );
      },
      child: widget.child,
    );
  }
}
