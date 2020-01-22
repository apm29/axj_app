import 'package:flutter/material.dart';

///
/// author : ciih
/// date : 2020-01-21 09:25
/// description :
///
class AutoFadeInTransition extends StatefulWidget {
  final Widget child;

  const AutoFadeInTransition({Key key, this.child}) : super(key: key);

  @override
  _AutoFadeInTransitionState createState() => _AutoFadeInTransitionState();
}

class _AutoFadeInTransitionState extends State<AutoFadeInTransition>
    with SingleTickerProviderStateMixin {
  AnimationController controller;

  @override
  void initState() {
    controller =
        AnimationController(vsync: this, duration: Duration(milliseconds: 400));
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
    return FadeTransition(
      opacity: controller,
      child: widget.child,
    );
  }
}

class AutoFadeOutTransition extends StatelessWidget {
  final Widget child;
  final Animation animation;

  const AutoFadeOutTransition({Key key, this.child, this.animation}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: animation,
      child: child,
    );
  }
}


class AutoSizeInTransition extends StatefulWidget {
  final Widget child;

  const AutoSizeInTransition({Key key, this.child}) : super(key: key);

  @override
  _AutoSizeInTransitionState createState() => _AutoSizeInTransitionState();
}

class _AutoSizeInTransitionState extends State<AutoSizeInTransition>
    with SingleTickerProviderStateMixin {
  AnimationController controller;

  @override
  void initState() {
    controller =
        AnimationController(vsync: this, duration: Duration(milliseconds: 400));
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
    return SizeTransition(
      sizeFactor: controller,
      child: widget.child,
    );
  }
}

class AutoSlideInTransition extends StatefulWidget {
  final Widget child;

  const AutoSlideInTransition({Key key, this.child}) : super(key: key);

  @override
  _AutoSlideInTransitionState createState() => _AutoSlideInTransitionState();
}

class _AutoSlideInTransitionState extends State<AutoSlideInTransition>
    with SingleTickerProviderStateMixin {
  AnimationController controller;

  @override
  void initState() {
    controller =
        AnimationController(vsync: this, duration: Duration(milliseconds: 400));
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
    return SlideTransition(
      position: Tween<Offset>(
        end: Offset.zero,
        begin: const Offset(1.0, 0.0),
      ).animate(controller),
      child: widget.child,
    );
  }
}