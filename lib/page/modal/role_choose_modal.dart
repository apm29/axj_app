import 'package:axj_app/model/bean/role_info.dart';
import 'package:axj_app/page/dialog/role_choose_dialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class RoleChooseModal extends ModalRoute<RoleInfo> {
  @override
  Color get barrierColor => const Color(0x66333333);

  @override
  bool get barrierDismissible => false;

  @override
  String get barrierLabel => "Choose Role";

  @override
  Widget buildPage(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation) {
    return Material(
      type: MaterialType.transparency,
      child: RoleChooseDialog(),
    );
  }

  @override
  bool get maintainState => false;

  @override
  bool get opaque => false;

  @override
  Duration get transitionDuration => const Duration(milliseconds: 250);

  @override
  Widget buildTransitions(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation, Widget child) {
    return FadeTransition(
      opacity: Tween<double>(begin: 0.0, end: 1.0).animate(animation),
      child: SlideTransition(
        position: Tween<Offset>(
          begin: const Offset(0.0, 1.0),
          end: Offset.zero,
        ).animate(animation),
        child: child, // child is the value returned by pageBuilder
      ),
    );
  }
}

class RoleNotAvailableModal extends ModalRoute{
  @override
  Color get barrierColor => const Color(0x66333333);

  @override
  bool get barrierDismissible => false;

  @override
  String get barrierLabel => "Role Not Available";

  @override
  Widget buildPage(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation) {
    return Material(
      type: MaterialType.transparency,
      child: RoleNotAvailableDialog(),
    );
  }

  @override
  bool get maintainState => false;

  @override
  bool get opaque => false;

  @override
  Duration get transitionDuration => const Duration(milliseconds: 250);

  @override
  Widget buildTransitions(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation, Widget child) {
    return SlideTransition(
      position: Tween<Offset>(
        begin: const Offset(0.0, 1.0),
        end: Offset.zero,
      ).animate(CurvedAnimation(parent: animation, curve: Curves.ease)),
      child: child, // child is the value returned by pageBuilder
    );
  }
}
