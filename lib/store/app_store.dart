import 'package:redux/redux.dart';
import 'package:dio/dio.dart';
import 'package:axj_app/model/bean/user_info.dart';
import 'package:axj_app/action/actions.dart';

//数据类
class AppState {
  AppState({userState, loading})
      : this.userState = userState ?? UserState(),
        this.loading = loading ?? false;

  UserState userState;
  bool loading;

  @override
  String toString() {
    return 'AppState{userState: $userState}';
  }
}

class UserState {
  UserInfo userInfo;
  bool login;
  String errorMsg;

  UserState({userInfo, login, errorMsg})
      : this.login = login ?? false,
        this.userInfo = userInfo ?? null,
        this.errorMsg = errorMsg ?? "";

  @override
  String toString() {
    return 'UserState{userInfo: $userInfo, login: $login, errorMsg: $errorMsg}';
  }
}


AppState appReduce(AppState state, action) {
  return state
    ..userState = userStateReducer(state.userState, action)
    ..loading = loadingReducer(state.loading, action);
}

final userStateReducer = combineReducers<UserState>(
  [
    TypedReducer<UserState, LoginAction>(userLoginReducer),
    TypedReducer<UserState, LoginSuccessAction>(userLoginSuccessReducer),
    TypedReducer<UserState, LoginFailAction>(userLoginFailReducer),
  ],
);

final loadingReducer = combineReducers<bool>(
  [
    TypedReducer<bool, LoginAction>(appLoadingReducer),
    TypedReducer<bool, LoginSuccessAction>(appLoadingReducer),
    TypedReducer<bool, LoginFailAction>(appLoadingReducer),
  ],
);

bool appLoadingReducer(bool init, action) {
  return (action is StartAction);
}

UserState userLoginReducer(UserState state, LoginAction action) {
  return state;
}

UserState userLoginSuccessReducer(UserState state, LoginSuccessAction action) {
  return state
    ..userInfo = action.userInfo
    ..login = true;
}

UserState userLoginFailReducer(UserState state, LoginFailAction action) {
  return state
    ..login = false
    ..errorMsg = action.errorMsg;
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
