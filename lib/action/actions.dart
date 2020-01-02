import 'package:axj_app/model/api.dart';
import 'package:axj_app/model/bean/user_info_detail.dart';
import 'package:axj_app/model/cache.dart';
import 'package:axj_app/model/repository.dart';
import 'package:axj_app/store/store.dart';

///
/// author : ciih
/// date : 2019-12-25 10:40
/// description :
///
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:oktoast/oktoast.dart';

abstract class AppAction {}

typedef AsyncResultTask<T> = Future<T> Function();
typedef AsyncVoidTask = Future<void> Function();

abstract class VoidTaskAction {
  final AsyncVoidTask task;
  final BuildContext context;

  VoidTaskAction(this.task, this.context);
}

abstract class ResultTaskAction<T> {
  final AsyncResultTask<T> task;
  final BuildContext context;
  T result;

  ResultTaskAction(this.task, this.context);
}

abstract class CheckAuthAction {
  final BuildContext context;

  //是否拦截action
  final bool intercept;

  CheckAuthAction(this.context, {this.intercept = false});
}

abstract class CheckLoginAction {
  final BuildContext context;

  //是否拦截action
  final bool intercept;

  CheckLoginAction(this.context, {this.intercept = false});
}

class LoginAction implements AppAction, ResultTaskAction<bool> {
  final String username;
  final String password;
  final BuildContext context;
  bool result;
  AsyncResultTask<bool> task;

  LoginAction(
      this.username, this.password, this.context, VoidCallback onSuccess) {
    task = () async {
      try {
        BaseResp resp = await Repository.login(username, password);
        Future.delayed(Duration(seconds: 2));
        if (resp.success) {
          Cache().setToken(resp.token);
          BaseResp<UserInfoDetail> userInfoResp =
              await Repository.getUserInfo();
          if (userInfoResp.success) {
            showToast("登录成功");
            StoreProvider.of<AppState>(context, listen: false)
                .state
                .userState
                .userInfo = userInfoResp.data;
            onSuccess();
            return true;
          } else {
            showToast("登录失败:${userInfoResp.text}");
          }
        } else {
          showToast("登录失败:${resp.text}");
        }
        return false;
      } catch (e) {
        print(e);
        showToast(getErrorMessage(e));
        return false;
      }
    };
  }
}

class FastLoginAction implements AppAction, ResultTaskAction<bool> {
  final String mobile;
  final String verifyCode;
  final BuildContext context;
  bool result;
  AsyncResultTask<bool> task;

  FastLoginAction(
      this.mobile, this.verifyCode, this.context, VoidCallback onSuccess) {
    task = () async {
      try {
        BaseResp resp = await Repository.fastLogin(mobile, verifyCode);
        Future.delayed(Duration(seconds: 2));
        if (resp.success) {
          Cache().setToken(resp.token);
          BaseResp<UserInfoDetail> userInfoResp =
              await Repository.getUserInfo();
          if (userInfoResp.success) {
            showToast("登录成功");
            StoreProvider.of<AppState>(context, listen: false)
                .state
                .userState
                .userInfo = userInfoResp.data;
            onSuccess();
            return true;
          } else {
            showToast("登录失败:${userInfoResp.text}");
          }
        } else {
          showToast("登录失败:${resp.text}");
        }
        return false;
      } catch (e) {
        print(e);
        showToast(getErrorMessage(e));
        return false;
      }
    };
  }
}

class ChangeLocaleAction implements AppAction {
  final Locale locale;

  ChangeLocaleAction(this.locale);
}

class LogoutAction implements AppAction {}


class AppInitAction implements AppAction {
  final BuildContext context;

  AppInitAction(this.context);
}

class TabSwitchAction implements AppAction {
  final int index;
  final BuildContext context;

  TabSwitchAction(this.index, this.context);

  @override
  String toString() {
    return 'TabSwitchAction{index: $index, context: $context}';
  }
}

class VoidTaskSimulationAction implements VoidTaskAction {
  AsyncVoidTask task;
  final BuildContext context;

  VoidTaskSimulationAction(this.task, this.context);
}

class ResultTaskSimulationAction implements ResultTaskAction<int> {
  AsyncResultTask<int> task;
  final BuildContext context;

  ResultTaskSimulationAction(this.task, this.context);

  @override
  int result;
}

class CheckAuthAndRouteAction
    implements CheckAuthAction, AppAction, CheckLoginAction {
  final BuildContext context;

  final bool intercept;

  final String routeName;

  CheckAuthAndRouteAction(this.context, this.routeName,
      {this.intercept = true});
}
