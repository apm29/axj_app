import 'package:flutter/material.dart';

enum SkeletonType { Card, List, Image, Paragraph }

class SkeletonWidget extends StatelessWidget {
  final SkeletonType skeletonType;
  final bool loading;

  const SkeletonWidget({Key key, this.skeletonType, this.loading = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    switch (skeletonType) {
      case SkeletonType.Card:
        return SkeletonCardWidget(loading);
      case SkeletonType.List:
        break;
      case SkeletonType.Image:
        break;
      case SkeletonType.Paragraph:
        return SkeletonParagraphWidget(loading);
        break;
    }
    return Container();
  }
}

class SkeletonParagraphWidget extends StatelessWidget {
  final bool loading;

  const SkeletonParagraphWidget(this.loading, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

class SkeletonCardWidget extends StatelessWidget {
  final bool loading;

  const SkeletonCardWidget(this.loading, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var cardHeight = MediaQuery.of(context).size.width * 0.6;
    return Container(
      margin: EdgeInsets.all(12),
      child: Card(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(16))),
        clipBehavior: Clip.antiAlias,
        child: Column(
          children: <Widget>[
            Container(
              height: cardHeight / 5 * 3.0,
              child: WavingHighLightWidget(loading),
            ),
            Container(
              height: 18,
              margin: EdgeInsets.only(
                  left: 16,
                  right: MediaQuery.of(context).size.width * 0.3,
                  top: 12,
                  bottom: 12),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(
                  Radius.circular(30),
                ),
              ),
              clipBehavior: Clip.antiAlias,
              child: WavingHighLightWidget(loading),
            ),
          ],
        ),
      ),
    );
  }
}

class WavingHighLightWidget extends StatefulWidget {
  final bool waving;

  WavingHighLightWidget(this.waving);

  @override
  _WavingHighLightWidgetState createState() => _WavingHighLightWidgetState();
}

class _WavingHighLightWidgetState extends State<WavingHighLightWidget>
    with TickerProviderStateMixin {
  AnimationController controller;

  @override
  void initState() {
    controller = AnimationController(
        vsync: this, duration: Duration(milliseconds: 1100));
    super.initState();
    controller.addStatusListener((status) {
      if (status == AnimationStatus.completed && widget.waving) {
        () async {
          await Future.delayed(Duration(milliseconds: 400));
          controller.reverse();
        }();
      } else if (status == AnimationStatus.dismissed && widget.waving) {
        () async {
          await Future.delayed(Duration(milliseconds: 400));
          controller.forward();
        }();
      }
    });
    controller.addListener(() {
      setState(() {});
    });
    if (widget.waving) {
      controller.forward();
    }
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (!widget.waving) {
      return Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Colors.grey[300],
              Colors.grey[400],
            ],
            stops: [0.0, 1.0],
          ),
        ),
      );
    }
    var tween = Tween(begin: 0.0, end: 1.0);
    var value = Curves.easeInOut.transform(tween.animate(controller).value);
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Colors.grey[300],
            Colors.grey[200],
            Colors.grey[300],
          ],
          stops: [0.0, value, 1.0],
        ),
      ),
    );
  }
}
