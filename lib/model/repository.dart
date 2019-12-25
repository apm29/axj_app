import 'package:axj_app/model/api.dart';
import 'package:axj_app/model/bean/user_info_wrapper.dart';

class Repository {
  static Future<BaseResp<UserInfoWrapper>> login(
      String userName, String password) async {
    await Future.delayed(Duration(seconds: 3));
    return Api().get<UserInfoWrapper>(
      "/permission/login",
      queryMap: {"userName": userName, "password": password},
      processor: (s) {
        return UserInfoWrapper.fromJsonMap(s);
      },
    );
  }
}
