import 'package:axj_app/model/api.dart';
import 'package:axj_app/model/bean/user_info_detail.dart';
import 'package:axj_app/model/cache.dart';
import 'package:axj_app/model/repository.dart';
import 'package:axj_app/redux/store/store.dart';

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

typedef CheckResult<T> = bool Function(T);

abstract class ResultTaskAction<T> {
  final AsyncResultTask<T> task;
  final BuildContext context;
  T result;

  // intercept action when return false
  final CheckResult<T> checker;

  ResultTaskAction(this.task, this.context, {this.checker});
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

abstract class NeedHouseInfoAction {
  final BuildContext context;
  final bool overrideHouse;

  NeedHouseInfoAction(this.context, {this.overrideHouse = false});
}

abstract class NeedRoleInfoAction {
  final BuildContext context;
  final bool overrideRole;
  final String roleCodeRequest;

  NeedRoleInfoAction(this.context,
      {this.overrideRole = false, this.roleCodeRequest});
}

class LoginAction implements AppAction, ResultTaskAction<bool> {
  final String username;
  final String password;
  final BuildContext context;
  bool result;
  AsyncResultTask<bool> task;
  CheckResult checker = (login) => login;

  LoginAction(this.username, this.password, this.context) {
    task = () async {
      return await loginAndInit(context, Repository.login(username, password));
    };
  }
}

Future<bool> loginAndInit(BuildContext context, Future<BaseResp> api) async {
  try {
    BaseResp resp = await api;
    Future.delayed(Duration(seconds: 2));
    if (resp.success) {
      Cache().setToken(resp.token);
      BaseResp<UserInfoDetail> userInfoResp = await Repository.getUserInfo();

      if (userInfoResp.success) {
        showToast("登录成功");
        var store = StoreProvider.of<AppState>(context, listen: false);
        store.state.userState.userInfo = userInfoResp.data;
        await store.state.settings.init();
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
}

class FastLoginAction implements AppAction, ResultTaskAction<bool> {
  final String mobile;
  final String verifyCode;
  final BuildContext context;
  bool result;
  AsyncResultTask<bool> task;
  CheckResult checker = (login) => login;

  FastLoginAction(this.mobile, this.verifyCode, this.context) {
    task = () async {
      return await loginAndInit(
          context, Repository.fastLogin(mobile, verifyCode));
    };
  }
}

class ChangeLocaleAction implements AppAction {
  final Locale locale;

  ChangeLocaleAction(this.locale);
}

class LogoutAction implements AppAction {
  final BuildContext context;

  LogoutAction(this.context);
}

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
  CheckResult checker = (v) => true;

  ResultTaskSimulationAction(this.task, this.context);

  @override
  int result;
}

typedef RouteNameGenerator = String Function();

class CheckAuthAndRouteAction
    implements
        AppAction,
        CheckLoginAction,
        CheckAuthAction,
        NeedHouseInfoAction {
  final BuildContext context;

  final bool intercept;
  final bool overrideHouse;
  final String routeName;

  final RouteNameGenerator routeGenerator;

  CheckAuthAndRouteAction(
    this.context, {
    this.intercept = true,
    this.overrideHouse = false,
    this.routeGenerator,
    this.routeName,
  }) : assert(routeName != null || routeGenerator != null);
}

class CheckLoginAndRouteAction implements AppAction, CheckLoginAction {
  final BuildContext context;

  final bool intercept;
  final String routeName;
  final RouteNameGenerator routeGenerator;

  CheckLoginAndRouteAction(
    this.context, {
    this.intercept = true,
    this.routeGenerator,
    this.routeName,
  }) : assert(routeName != null || routeGenerator != null);
}

class ChangeHouseAction
    implements AppAction, CheckLoginAction, NeedHouseInfoAction {
  final BuildContext context;

  final bool intercept;

  final bool overrideHouse;

  ChangeHouseAction(this.context,
      {this.intercept: true, this.overrideHouse: true});
}

class ChangeRoleAction
    implements AppAction, CheckLoginAction, NeedRoleInfoAction {
  final BuildContext context;

  final bool intercept;

  final bool overrideRole;

  final String roleCodeRequest;

  ChangeRoleAction(
    this.context, {
    this.intercept: true,
    this.overrideRole: true,
    this.roleCodeRequest,
  });
}


class RefreshAction{
  final String refreshToken;

  RefreshAction(this.refreshToken);
}

class HomeScrollAction implements AppAction{
  final bool hide;

  HomeScrollAction(this.hide);
}