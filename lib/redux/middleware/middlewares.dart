import 'package:axj_app/model/api.dart';
import 'package:axj_app/model/bean/user_info_detail.dart';
import 'package:axj_app/page/modal/task_modal.dart';
import 'package:axj_app/route/route.dart';
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
    TypedMiddleware<AppState, CheckLoginAction>(checkLogin),
    TypedMiddleware<AppState, CheckAuthAction>(checkAuth),
    TypedMiddleware<AppState, VoidTaskAction>(checkVoidTask),
    TypedMiddleware<AppState, ResultTaskAction>(checkResultTask),
  ];
}


initApp(Store<AppState> store, action, NextDispatcher next) {
  () async {

    try{
      await store.state.dictionary.init();
    }catch(e){
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
    }else{
      next(action);
    }
  }();
}

checkAuth(Store<AppState> store, CheckAuthAction action, NextDispatcher next) {
  () async {
    if (store.state.userState.userInfo.authorized) {
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
    await Navigator.of(action.context).push(TaskModal(action.task));
    next(action);
  }();
}

checkResultTask(
    Store<AppState> store, ResultTaskAction action, NextDispatcher next) {
  () async {
    dynamic result =
        await Navigator.of(action.context).push(TaskModal(action.task));
    action.result = result;
    next(action);
  }();
}
