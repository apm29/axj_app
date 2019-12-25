import 'api.dart';
import 'bean/user_info_warpper.dart';

class Repository {
  static Future<BaseResp<UserInfoWrapper>> login(String userName, String password) async {
    await Future.delayed(Duration(seconds: 3));
    return Api().get<UserInfoWrapper>(
      "/permission/login",
      queryMap: {"userName": userName, "password": password},
      processor: (s) {
        return UserInfoWrapper.fromJsonMap(s);
      },
      showProgress: true,
      loadingText: "正在登陆..",
    );
  }
}
