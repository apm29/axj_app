import 'package:axj_app/model/cache.dart';
import 'package:flutter/material.dart';
import 'package:redux/redux.dart';
import 'package:dio/dio.dart';
import 'package:axj_app/model/bean/user_info.dart';
import 'package:axj_app/action/actions.dart';

//数据类
class AppState {
  AppState({userState, loading})
      : this.userState = userState ?? UserState(),
        this.loading = loading ?? false,
        this.homePageState = HomePageState(),
        this.locale = const Locale('en');

  UserState userState;

  HomePageState homePageState;

  bool loading;

  Locale locale;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          other is AppState &&
              runtimeType == other.runtimeType &&
              userState == other.userState &&
              homePageState == other.homePageState &&
              loading == other.loading &&
              locale == other.locale;

  @override
  int get hashCode =>
      userState.hashCode ^
      homePageState.hashCode ^
      loading.hashCode ^
      locale.hashCode;




}

enum ActiveTab { Home, Mine }

class HomePageState {
  final ActiveTab currentTab;

  HomePageState({ActiveTab currentTab})
      : this.currentTab = currentTab ?? ActiveTab.Home;

  @override
  String toString() {
    return 'HomePageState{currentTab: $currentTab}';
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
  print(action);
  return appStateReducer(state, action)
    ..userState = userStateReducer(state.userState, action)
    ..loading = loadingReducer(state.loading, action)
    ..locale = localeReducer(state.locale, action)
    ..homePageState = homePageReducer(state.homePageState, action);
}

final appStateReducer = combineReducers<AppState>(
  [
    TypedReducer<AppState, AppInitAction>((state, action) {
      return state;
    })
  ],
);

final localeReducer = combineReducers<Locale>([
  TypedReducer<Locale, ChangeLocaleAction>((state, action) {
    return action.locale;
  }),
]);

final homePageReducer = combineReducers<HomePageState>(
  [
    TypedReducer<HomePageState, TabSwitchAction>(
      (state, action) {
        var homePageState =
            HomePageState(currentTab: ActiveTab.values[action.index]);
        return homePageState;
      },
    ),
  ],
);

final userStateReducer = combineReducers<UserState>(
  [
    TypedReducer<UserState, LoginAction>(userLoginReducer),
    TypedReducer<UserState, LoginSuccessAction>(userLoginSuccessReducer),
    TypedReducer<UserState, LoginFailAction>(userLoginFailReducer),
    TypedReducer<UserState, LogoutAction>(userLogout),
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

UserState userLogout(UserState state, LogoutAction action) {
  Cache().setToken(null);
  return UserState();
}

UserState userLoginSuccessReducer(UserState state, LoginSuccessAction action) {
  print(action);
  return UserState(userInfo: action.userInfo, login: true, errorMsg: null);
}

UserState userLoginFailReducer(UserState state, LoginFailAction action) {
  return UserState(userInfo: null, login: false, errorMsg: action.errorMsg);
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
