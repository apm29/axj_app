import 'package:axj_app/model/bean/house_info.dart';
import 'package:axj_app/model/bean/user_info_detail.dart';
import 'package:axj_app/model/cache.dart';
import 'package:axj_app/model/dictionary.dart';
import 'package:axj_app/route/route.dart';
import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:redux/redux.dart';
import 'package:dio/dio.dart';
import 'package:axj_app/redux/action/actions.dart';

//数据类
class AppState {
  AppState({userState, loading})
      : this.userState = userState ?? UserState(),
        this.loading = loading ?? false,
        this.homePageState = HomePageState(),
        this.dictionary = Dictionary(),
        this.locale = Locale(Cache().locale ?? 'zh');

  UserState userState;

  HomePageState homePageState;

  Dictionary dictionary;

  //获取缓存的当前房屋信息,或者在房屋唯一时取唯一一个房屋
  //该方法在Dictionary初始化之后才能使用
  HouseInfo get currentHouse {
    return dictionary.defaultHouseInfo(Cache().currentHouseId);
  }

  //设置当前房屋
  set currentHouse(HouseInfo val) {
    Cache().setCurrentHouseId(val.houseId);
  }

  bool loading;

  Locale locale;

  int simulationResult = 0;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AppState &&
          runtimeType == other.runtimeType &&
          userState == other.userState &&
          homePageState == other.homePageState &&
          loading == other.loading &&
          locale == other.locale &&
          simulationResult == other.simulationResult;

  @override
  int get hashCode =>
      userState.hashCode ^
      homePageState.hashCode ^
      loading.hashCode ^
      locale.hashCode ^
      simulationResult.hashCode;

  @override
  String toString() {
    return 'AppState{userState: $userState, homePageState: $homePageState, dictionary: $dictionary, currentHouse: $currentHouse, loading: $loading, locale: $locale, simulationResult: $simulationResult}';
  }
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
  UserInfoDetail userInfo;
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
    }),
    TypedReducer<AppState, ResultTaskSimulationAction>((state, action) {
      return state..simulationResult += action.result;
    }),
    TypedReducer<AppState, CheckAuthAndRouteAction>((state, action) {
      Application.router.navigateTo(
          action.context, action.routeName ?? action.routeGenerator(),
          transition: TransitionType.cupertino);
      return state;
    }),
    TypedReducer<AppState, CheckLoginAndRouteAction>((state, action) {
      Application.router.navigateTo(
          action.context, action.routeName ?? action.routeGenerator(),
          transition: TransitionType.cupertino);
      return state;
    }),
    TypedReducer<AppState, LoginAction>((state, action) {
      Navigator.of(action.context).pop(true);
      return state;
    }),
    TypedReducer<AppState, FastLoginAction>((state, action) {
      Navigator.of(action.context).pop(true);
      return state;
    }),
  ],
);

final localeReducer = combineReducers<Locale>([
  TypedReducer<Locale, ChangeLocaleAction>((state, action) {
    Cache().setLocale(action.locale.languageCode);
    return action.locale;
  }),
]);

final homePageReducer = combineReducers<HomePageState>(
  [
    TypedReducer<HomePageState, TabSwitchAction>(
      (state, action) {
        return HomePageState(currentTab: ActiveTab.values[action.index]);
      },
    ),
  ],
);

final userStateReducer = combineReducers<UserState>(
  [
    TypedReducer<UserState, LoginAction>(userLoginReducer),
    TypedReducer<UserState, LogoutAction>(userLogout),
  ],
);

final loadingReducer = combineReducers<bool>(
  [],
);

UserState userLoginReducer(UserState state, LoginAction action) {
  print(action);
  return state..login = action.result;
}

UserState userLogout(UserState state, LogoutAction action) {
  Cache().clear();
  AppRouter.toHome(action.context, ActiveTab.Home);
  return UserState();
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
