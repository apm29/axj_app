import 'package:flutter/material.dart';

///
/// author : ciih
/// date : 2019-12-26 10:15
/// description :
///
class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  Offset _offset;

  @override
  Widget build(BuildContext context) {
    _offset = Offset(MediaQuery.of(context).size.width - 100,
        MediaQuery.of(context).size.height * 0.7);
    return Transform.translate(
        offset: _offset,
        child: Draggable(
          child: RaisedButton(onPressed: (){},child: Text('1'),),
          feedback: RaisedButton(onPressed: (){},child: Text('1'),),
          childWhenDragging: Container(
            width: 0,
            height: 0,
          ),
          onDragEnd: (dragEndDetails) {
            setState(() {
              _offset = dragEndDetails.offset;
              print(" onDragEnd - dragEndDetails.offset:" +
                  dragEndDetails.offset.toString());
            });
          },
        ));
  }
}
