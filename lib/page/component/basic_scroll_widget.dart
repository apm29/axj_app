import 'package:axj_app/model/api.dart';
import 'package:axj_app/page/component/future_task_widget.dart';
import 'package:axj_app/redux/action/actions.dart';
import 'package:flutter/material.dart';

///
/// author : ciih
/// date : 2020-01-10 12:03
/// description :
///
class BasicScrollWidget extends StatefulWidget {
  final AsyncResultTask<List<BaseResp>> task;
  final ModelBuilder<List<BaseResp>> modelBuilder;

  BasicScrollWidget({this.task, this.modelBuilder});

  @override
  _BasicScrollWidgetState createState() => _BasicScrollWidgetState();
}

class _BasicScrollWidgetState extends State<BasicScrollWidget> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
