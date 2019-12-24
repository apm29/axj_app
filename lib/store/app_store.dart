import 'package:redux/redux.dart';
import 'package:dio/dio.dart';

import '../model/repository.dart';

//数据类
class AppState {
  AppState({
    userState,
  }) : this.userState = userState ?? UserState();

  UserState userState;

  @override
  String toString() {
    return 'AppState{userState: $userState}';
  }
}

class UserState {
  String userInfo;
  bool login;

  UserState({userInfo, login})
      : this.login = login ?? false,
        this.userInfo = userInfo ?? "";

  @override
  String toString() {
    return 'UserState{userInfo: $userInfo}';
  }
}

abstract class AppAction {}

class LoginAction implements AppAction {
  final String username;
  final String password;

  LoginAction(this.username, this.password);
}

class LoginSuccessAction implements AppAction {
  final String userInfo;

  LoginSuccessAction(this.userInfo);
}

class LoginFailAction implements AppAction {
  final String errorMsg;

  LoginFailAction(this.errorMsg);
}

AppState appReduce(AppState state, action) {
  return state..userState = userStateReducer(state.userState, action);
}

final userStateReducer = combineReducers<UserState>(
  [
    TypedReducer<UserState, LoginAction>(userLoginReducer),
    TypedReducer<UserState, LoginSuccessAction>(userLoginSuccessReducer),
    TypedReducer<UserState, LoginFailAction>(userLoginFailReducer),
  ],
);

UserState userLoginReducer(UserState state, LoginAction action) {
  return state;
}

UserState userLoginSuccessReducer(UserState state, LoginSuccessAction action) {
  return state..userInfo = action.userInfo;
}

UserState userLoginFailReducer(UserState state, LoginFailAction action) {
  return state..userInfo = action.errorMsg;
}

List<Middleware<AppState>> createAppMiddleware() {
  return [TypedMiddleware<AppState, LoginAction>(loginFromRepo())];
}

Middleware<AppState> loginFromRepo() {
  return (Store<AppState> store, action, NextDispatcher next) {
    Repository.login(action.username, action.password).then(
      (resp) {
        store.dispatch(LoginSuccessAction(resp.data));
      },
    ).catchError((err) {
      return store.dispatch(LoginFailAction(getErrorMessage(err)));
    });
    next(action);
  };
}

String getErrorMessage(Object error) {
  if (error is DioError) {
    switch (error.type) {
      case DioErrorType.CONNECT_TIMEOUT:
        return "请求超时";
      case DioErrorType.SEND_TIMEOUT:
        return "发送超时";
      case DioErrorType.RECEIVE_TIMEOUT:
        return "接收超时";
      case DioErrorType.RESPONSE:
        return error.response.toString();
      case DioErrorType.CANCEL:
        return "请求取消";
      case DioErrorType.DEFAULT:
        return error.toString();
      default:
        throw Exception("未知错误");
    }
  } else {
    return error.toString();
  }
}
