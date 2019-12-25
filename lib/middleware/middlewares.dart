import 'package:redux/redux.dart';
import 'package:oktoast/oktoast.dart';
import 'package:flutter/material.dart';

import 'package:axj_app/store/app_store.dart';
import 'package:axj_app/action/actions.dart';
import 'package:axj_app/model/repository.dart';

///
/// author : ciih
/// date : 2019-12-25 10:42
/// description :
///
List<Middleware<AppState>> createAppMiddleware() {
  return [
    TypedMiddleware<AppState, LoginAction>(loginFromRepo()),
    TypedMiddleware<AppState, AppAction>(startLoading),
  ];
}

Middleware<AppState> loginFromRepo() {
  return (Store<AppState> store, action, NextDispatcher next) {
    Repository.login(action.username, action.password).then(
      (resp) {
        store.dispatch(LoginSuccessAction(resp.data.userInfo));
      },
    ).catchError((err) {
      return store.dispatch(LoginFailAction(getErrorMessage(err)));
    });
    next(action);
  };
}

startLoading(Store<AppState> store, action, NextDispatcher next) {
  if (action is StartAction) {
    showToastWidget(
      Center(
        child: CircularProgressIndicator(),
      ),
      dismissOtherToast: true,
    );
  }
  next(action);
}
