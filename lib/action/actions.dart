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
  final BuildContext context;

  LoginAction(this.username, this.password, this.context);

}
class ChangeLocaleAction implements AppAction{
  final Locale locale;
  ChangeLocaleAction(this.locale);
}
class LogoutAction implements AppAction{}

class FastLoginAction implements AppAction, StartAction {
  final String mobile;
  final String verifyCode;

  FastLoginAction(this.mobile, this.verifyCode);
}

class LoginSuccessAction implements AppAction {
  final UserInfo userInfo;

  LoginSuccessAction(this.userInfo);

  @override
  String toString() {
    return 'LoginSuccessAction{userInfo: $userInfo}';
  }

}

class LoginFailAction implements AppAction {
  final String errorMsg;

  LoginFailAction(this.errorMsg);

  @override
  String toString() {
    return 'LoginFailAction{errorMsg: $errorMsg}';
  }

}

class AppInitAction implements AppAction {
  final BuildContext context;

  AppInitAction(this.context);
}

class TabSwitchAction implements AppAction{
  final int index;
  final BuildContext context;

  TabSwitchAction(this.index, this.context);

  @override
  String toString() {
    return 'TabSwitchAction{index: $index, context: $context}';
  }

}