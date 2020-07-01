import 'dart:math';

import 'package:flutter/material.dart';

class SpeedDial extends StatefulWidget {
  final List<IconData> icons;
  final List<VoidCallback> onPressList;
  final List<String> labels;

  const SpeedDial({Key key, this.icons, this.onPressList, this.labels})
      : super(key: key);

  @override
  _SpeedDialState createState() => _SpeedDialState(icons);
}

class _SpeedDialState extends State<SpeedDial> with TickerProviderStateMixin {
  AnimationController _controller;
  final List<IconData> icons;

  _SpeedDialState(this.icons);

  @override
  void initState() {
    _controller = new AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 220),
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Color backgroundColor = Theme.of(context).cardColor;
    Color foregroundColor = Theme.of(context).accentColor;
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.end,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: List.generate(icons.length, (int index) {
        Widget child = Container(
          height: 70.0,
          width: 160.0,
          alignment: FractionalOffset.topCenter,
          child: ScaleTransition(
            scale: CurvedAnimation(
              parent: _controller,
              curve: Interval(0.0, 1.0 - index / icons.length / 2.0,
                  curve: Curves.easeOut),
            ),
            child: FloatingActionButton.extended(
              heroTag: null,
              materialTapTargetSize: MaterialTapTargetSize.padded,
              backgroundColor: backgroundColor,
              onPressed: widget.onPressList[index],
              label: Row(
                children: <Widget>[
                  Icon(icons[index], color: foregroundColor),
                  Text(widget.labels[index],style: Theme.of(context).textTheme.subtitle2,),
                ],
              ),
            ),
          ),
        );
        return child;
      }).toList()
        ..add(
          FloatingActionButton(
            child: AnimatedBuilder(
              animation: _controller,
              builder: (BuildContext context, Widget child) {
                return Transform(
                  transform: Matrix4.rotationZ(_controller.value * 0.5 * pi),
                  alignment: FractionalOffset.center,
                  child:
                      Icon(_controller.isDismissed ? Icons.menu : Icons.close),
                );
              },
            ),
            onPressed: () {
              if (_controller.isDismissed) {
                _controller.forward();
              } else {
                _controller.reverse();
              }
            },
          ),
        ),
    );
  }
}
