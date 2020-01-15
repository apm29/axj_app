import 'package:axj_app/generated/i18n.dart';
import 'package:axj_app/model/api.dart';
import 'package:axj_app/model/bean/house_info.dart';
import 'package:axj_app/model/bean/role_info.dart';
import 'package:axj_app/model/bean/user_info_detail.dart';
import 'package:axj_app/page/modal/house_choose_modal.dart';
import 'package:axj_app/page/modal/role_choose_modal.dart';
import 'package:axj_app/page/modal/task_modal.dart';
import 'package:axj_app/route/route.dart';
import 'package:flutter/cupertino.dart';
import 'package:redux/redux.dart';
import 'package:flutter/material.dart';

import 'package:axj_app/redux/store/store.dart';
import 'package:axj_app/redux/action/actions.dart';
import 'package:axj_app/model/repository.dart';

///
/// author : ciih
/// date : 2019-12-25 10:42
/// description :
///
List<Middleware<AppState>> createAppMiddleware() {
  return [
    TypedMiddleware<AppState, AppInitAction>(initApp),
    TypedMiddleware<AppState, LogoutAction>(confirmLogout),
    TypedMiddleware<AppState, CheckLoginAction>(checkLogin),
    TypedMiddleware<AppState, CheckAuthAction>(checkAuth),
    TypedMiddleware<AppState, VoidTaskAction>(checkVoidTask),
    TypedMiddleware<AppState, ResultTaskAction>(checkResultTask),
    TypedMiddleware<AppState, NeedHouseInfoAction>(checkHouseInfo),
    TypedMiddleware<AppState, NeedRoleInfoAction>(checkRoleInfo),
  ];
}

initApp(Store<AppState> store, action, NextDispatcher next) {
  () async {
    try {
      await store.state.settings.init();
    } catch (e) {
      print(e);
    }

    try {
      BaseResp<UserInfoDetail> resp = await Repository.getUserInfo();
      if (resp.success) {
        store.state.userState.login = true;
        store.state.userState.userInfo = resp.data;
      } else {
        store.state.userState.login = false;
      }
    } catch (e) {
      store.state.userState.login = false;
    }
    next(action);
  }();
}

confirmLogout(Store<AppState> store, LogoutAction action, NextDispatcher next) {
  () async {
    bool result = await showDialog<bool>(
      context: action.context,
      builder: (c) => CupertinoAlertDialog(
        title: Text(S.of(c).logoutLabel),
        content: Text(S.of(c).confirmLogoutHint),
        actions: <Widget>[
          CupertinoButton(
            child: Text(S.of(c).confirmLabel),
            onPressed: () {
              Navigator.of(c).pop(true);
            },
          ),
          CupertinoButton(
            child: Text(S.of(c).cancelLabel),
            onPressed: () {
              Navigator.of(c).pop(false);
            },
          ),
        ],
      ),
    );
    if (result == true) next(action);
  }();
}

checkLogin(
    Store<AppState> store, CheckLoginAction action, NextDispatcher next) {
  () async {
    if (!store.state.userState.login) {
      if (action.intercept) {
        var loginResult = await AppRouter.toLogin(action.context);
        if (loginResult == true) {
          next(action);
        }
      } else {
        await AppRouter.toLogin(action.context);
        next(action);
      }
    } else {
      next(action);
    }
  }();
}

checkAuth(Store<AppState> store, CheckAuthAction action, NextDispatcher next) {
  () async {
    if (store.state.authorized) {
      next(action);
    } else {
      if (!action.intercept) {
        await AppRouter.toAuthHint(action.context);
        next(action);
      } else {
        bool authResult = await AppRouter.toAuthHint(action.context);
        if (authResult == true) {
          next(action);
        }
      }
    }
  }();
}

checkVoidTask(
    Store<AppState> store, VoidTaskAction action, NextDispatcher next) {
  () async {
    if(action.showMask) {
      await Navigator.of(action.context).push(TaskModal(action.task));
    }else{
      await action.task();
    }
    next(action);
  }();
}

checkResultTask(
    Store<AppState> store, ResultTaskAction action, NextDispatcher next) {
  () async {
    dynamic result =
        await Navigator.of(action.context).push(TaskModal(action.task));
    if (action.checker(result)) {
      action.result = result;
      next(action);
    }
  }();
}

checkHouseInfo(
    Store<AppState> store, NeedHouseInfoAction action, NextDispatcher next) {
  () async {
    if (store.state.userState.login &&
        (action.overrideHouse || store.state.currentHouse == null)) {
      var navigatorState = Navigator.of(action.context);
      HouseInfo result = await navigatorState.push(HouseChooseModal());
      if (result != null) store.state.currentHouse = result;
    }
    next(action);
  }();
}

checkRoleInfo(
    Store<AppState> store, NeedRoleInfoAction action, NextDispatcher next) {
  () async {
    if (store.state.userState.login &&
        (action.overrideRole || store.state.currentRole == null)) {
      var navigatorState = Navigator.of(action.context);
      if(action.roleCodeRequest!=null){
        bool hasRole = store.state.settings.hasRole(action.roleCodeRequest);
        if(!hasRole){
          await navigatorState.push(RoleNotAvailableModal());
          return;
        }
      }


      RoleInfo result = await navigatorState.push(RoleChooseModal());
      if (result != null) store.state.currentRole = result;
    }
    next(action);
  }();
}
