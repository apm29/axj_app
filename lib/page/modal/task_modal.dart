import 'package:axj_app/redux/action/actions.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TaskModal<T> extends ModalRoute<T> {
  /// use [AsyncVoidTask] or [AsyncResultTask]
  final Function task;
  final minimumLoadingTime = 800;

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
      int start = DateTime.now().millisecondsSinceEpoch;
      T result = await task?.call();
      int end = DateTime.now().millisecondsSinceEpoch;
      if ((end - start) < minimumLoadingTime) {
        await Future.delayed(
            Duration(milliseconds: minimumLoadingTime - (end - start)));
      }
      navigator.pop(result);
    }();
    super.install(insertionPoint);
  }

  static Future runTask(BuildContext context,Function task){
    return Navigator.of(context).push(TaskModal(task));
  }
}
