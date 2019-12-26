///
/// author : ciih
/// date : 2019-12-25 10:40
/// description :
///
import 'package:axj_app/model/bean/user_info.dart';
import 'package:flutter/material.dart';

abstract class AppAction {}

abstract class StartAction {}

class LoginAction implements AppAction, StartAction {
  final String username;
  final String password;

  LoginAction(this.username, this.password);
}

class LoginSuccessAction implements AppAction {
  final UserInfo userInfo;

  LoginSuccessAction(this.userInfo);
}

class LoginFailAction implements AppAction {
  final String errorMsg;

  LoginFailAction(this.errorMsg);
}

class AppInitAction implements AppAction {
  final BuildContext context;

  AppInitAction(this.context);
}

class TabSwitchAction implements AppAction{
  final int index;
  final BuildContext context;

  TabSwitchAction(this.index, this.context);
}