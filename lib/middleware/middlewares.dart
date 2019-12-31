import 'package:axj_app/model/api.dart';
import 'package:axj_app/model/bean/user_info.dart';
import 'package:axj_app/model/cache.dart';
import 'package:axj_app/route/route.dart';
import 'package:redux/redux.dart';
import 'package:oktoast/oktoast.dart';
import 'package:flutter/material.dart';

import 'package:axj_app/store/store.dart';
import 'package:axj_app/action/actions.dart';
import 'package:axj_app/model/repository.dart';

///
/// author : ciih
/// date : 2019-12-25 10:42
/// description :
///
List<Middleware<AppState>> createAppMiddleware() {
  return [
    TypedMiddleware<AppState, LoginAction>(loginWithUserName),
    TypedMiddleware<AppState, FastLoginAction>(loginWithSms),
    TypedMiddleware<AppState, AppInitAction>(initApp),
    TypedMiddleware<AppState, TabSwitchAction>(checkLogin),
  ];
}

loginWithUserName(
    Store<AppState> store, LoginAction action, NextDispatcher next) {
  () async {
    try {
      BaseResp resp = await Repository.login(action.username, action.password);
      Navigator.of(action.context).pop(true);
      Cache().setToken(resp.token);
      if (resp.success) {
        BaseResp<UserInfo> userInfoResp = await Repository.getUserInfo();
        if (userInfoResp.success) {
          showToast("登录成功");
          store.dispatch(LoginSuccessAction(userInfoResp.data));
          if(!action.silent) {
            Navigator.of(action.context).pop(true);
          }
          return;
        }
      }
      store.dispatch(LoginFailAction(resp.text));
    } catch (e) {
      store.dispatch(LoginFailAction(getErrorMessage(e)));
    }
  }();
}

loginWithSms(
    Store<AppState> store, FastLoginAction action, NextDispatcher next) {
  () async {
    try {
      BaseResp resp =
          await Repository.fastLogin(action.mobile, action.verifyCode);
      Cache().setToken(resp.token);
      if (resp.success) {
        BaseResp<UserInfo> userInfoResp = await Repository.getUserInfo();
        if (userInfoResp.success) {
          showToast("登录成功");
          store.dispatch(LoginSuccessAction(userInfoResp.data));
          if(!action.silent) {
            Navigator.of(action.context).pop(true);
          }
          return;
        }
      }
      store.dispatch(LoginFailAction(resp.text));
    } catch (e) {
      store.dispatch(LoginFailAction(getErrorMessage(e)));
    }
  }();
}

initApp(Store<AppState> store, action, NextDispatcher next) {
  () async {
    try {
      int start = DateTime.now().millisecondsSinceEpoch;
      BaseResp resp = await Repository.getUserInfo();
      if (resp.success) {
        store.dispatch(LoginSuccessAction(resp.data));
      } else {
        store.dispatch(LoginFailAction(resp.text));
      }
      int now = DateTime.now().millisecondsSinceEpoch;
      if (now - start < 2000) {
        await Future.delayed(Duration(milliseconds: 2000 - (now - start)));
      }
    } catch (e) {
      store.dispatch(LoginFailAction(getErrorMessage(e)));
    } finally {
      AppRouter.toHomeAndReplaceSelf(action.context);
    }
  }();
}

checkLogin(Store<AppState> store, TabSwitchAction action, NextDispatcher next) {
  if (action.index == (ActiveTab.Mine.index) && !store.state.userState.login) {
    AppRouter.toLogin(action.context).then((loginSuccess) {
      if (loginSuccess) {
        store.dispatch(action);
      }
    });
  } else {
    next(action);
  }
}
