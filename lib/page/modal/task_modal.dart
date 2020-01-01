import 'package:axj_app/action/actions.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TaskModal extends ModalRoute {

  /// use [AsyncVoidTask] or [AsyncResultTask]
  final Function task;

  TaskModal(this.task);

  @override
  Color get barrierColor => const Color(0x66333333);

  @override
  bool get barrierDismissible => false;

  @override
  String get barrierLabel => "Running task";

  @override
  Widget buildPage(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation) {
    return Material(
      type: MaterialType.transparency,
      child: CupertinoActivityIndicator(),
    );
  }

  @override
  bool get maintainState => false;

  @override
  bool get opaque => false;

  @override
  Duration get transitionDuration => const Duration(milliseconds: 250);

  @override
  void install(OverlayEntry insertionPoint) {
    ()async{
      var result = await task();
      navigator.pop(result);
    }();
    super.install(insertionPoint);
  }

}
