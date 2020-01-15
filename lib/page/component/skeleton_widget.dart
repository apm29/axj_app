import 'package:flutter/material.dart';

enum SkeletonType { Card, List, Image, Paragraph }

class SkeletonWidget extends StatelessWidget {
  final SkeletonType skeletonType;
  final bool loading;

  const SkeletonWidget({Key key, this.skeletonType, this.loading = true})
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
        break;
    }
    return Container();
  }
}

class SkeletonCardWidget extends StatefulWidget {
  final bool loading;

  SkeletonCardWidget(this.loading);

  @override
  _SkeletonCardWidgetState createState() => _SkeletonCardWidgetState();
}

class _SkeletonCardWidgetState extends State<SkeletonCardWidget>
    with TickerProviderStateMixin {
  AnimationController controller;

  @override
  void initState() {
    controller = AnimationController(
        vsync: this, duration: Duration(milliseconds: 1100));
    super.initState();
    controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        controller.reset();
        () async {
          await Future.delayed(Duration(milliseconds: 400));
          controller.forward();
        }();
      }
    });
    controller.addListener(() {
      setState(() {});
    });
    if (widget.loading) {
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
    var tween = Tween(begin: -0.5, end: 1.5);
    var value = tween.animate(controller).value;
    return LayoutBuilder(
      builder: (context, constraint) {
        var cardHeight = constraint.maxWidth * 0.6;
        return Container(
          margin: EdgeInsets.symmetric(vertical: 6, horizontal: 12),
          height: cardHeight,
          child: Card(
            clipBehavior: Clip.antiAlias,
            child: Column(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Flexible(
                  flex: 3,
                  child: Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          Colors.grey[300],
                          (value<=-0.1||value>=1.1)?Colors.grey[300]:Colors.grey[200],
                          Colors.grey[300],
                        ],
                        stops: [0.0, value, 1.0],
                      ),
                    ),
                  ),
                ),
                Flexible(
                  flex: 1,
                  child: Container(
                    margin: EdgeInsets.only(
                      left: cardHeight / 4 * 0.3,
                      top: cardHeight / 4 * 0.3,
                      bottom: cardHeight / 4 * 0.3,
                    ),
                    width: cardHeight,
                    decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            Colors.grey[300],
                            (value<=-0.1||value>=1.1)?Colors.grey[300]:Colors.grey[200],
                            Colors.grey[300],
                          ],
                          stops: [0.0, value, 1.0],
                        ),
                        borderRadius: BorderRadius.all(Radius.circular(16))),
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
