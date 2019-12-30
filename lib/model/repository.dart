import 'package:axj_app/model/api.dart';
import 'package:axj_app/model/bean/user_info.dart';
import 'package:axj_app/model/bean/user_info_wrapper.dart';

class Repository {
  static Future<BaseResp<UserInfoWrapper>> login(
      String userName, String password)  {
    return Api().get<UserInfoWrapper>(
      "/permission/login",
      queryMap: {"userName": userName, "password": password},
      processor: (s) {
        return UserInfoWrapper.fromJsonMap(s);
      },
    );
  }

  static Future<BaseResp> sendVerifyCode(String mobile)  {
    return Api().get(
      "/permission/user/getVerifyCode",
      queryMap: {"mobile": mobile, "type": 1},
      processor: (s) {
        return s;
      },
    );
  }

  static Future<BaseResp<UserInfoWrapper>> fastLogin(
      String mobile, String verifyCode)  {
    return Api().get(
      "/permission/fastLogin",
      queryMap: {"mobile": mobile, "verifyCode": verifyCode},
      processor: (s) {
        return UserInfoWrapper.fromJsonMap(s);
      },
    );
  }

  static Future<BaseResp<UserInfo>> getUserInfo()  {
    return Api().post(
      "/permission/user/getUserInfo",
      processor: (s) {
        print(s.runtimeType);
        return UserInfo.fromJsonMap(s);
      },
    );
  }

  static Future<BaseResp> register(
      String mobile, String smsCode, String password, String userName)  {
    return Api().post(
      "/permission/user/register",
      processor: (s) => null,
      formData: {
        "userName": userName,
        "mobile": mobile,
        "password": password,
        "code": smsCode,
      },
    );
  }
}
