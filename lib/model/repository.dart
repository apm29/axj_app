import 'package:axj_app/model/api.dart';
import 'package:axj_app/model/bean/user_info.dart';
import 'package:axj_app/model/bean/user_info_wrapper.dart';

class Repository {
  static Future<BaseResp<UserInfoWrapper>> login(
      String userName, String password) async {
    return Api().get<UserInfoWrapper>(
      "/permission/login",
      queryMap: {"userName": userName, "password": password},
      processor: (s) {
        return UserInfoWrapper.fromJsonMap(s);
      },
    );
  }

  static Future<BaseResp> sendVerifyCode(String mobile) async {
    return Api().get(
      "/permission/user/getVerifyCode",
      queryMap: {"mobile": mobile, "type": 1},
      processor: (s) {
        return s;
      },
    );
  }

  static Future<BaseResp<UserInfoWrapper>> fastLogin(String mobile, String verifyCode) async {
    return Api().get(
      "/permission/fastLogin",
      queryMap: {"mobile": mobile, "verifyCode": verifyCode},
      processor: (s) {
        return UserInfoWrapper.fromJsonMap(s);
      },
    );
  }

  static Future<BaseResp<UserInfo>> getUserInfo() async {
    return Api().post(
      "/permission/user/getUserInfo",
      processor: (s) {
        print(s.runtimeType);
        return UserInfo.fromJsonMap(s);
      },
    );
  }
}
