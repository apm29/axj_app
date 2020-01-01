import 'package:axj_app/model/api.dart';
import 'package:axj_app/model/bean/user_info_detail.dart';

class Repository {
  static Future<BaseResp> login(
      String userName, String password)  {
    return Api().get(
      "/permission/login",
      queryMap: {"userName": userName, "password": password},
      processor: (s) {
        return null;
      },
    );
  }

  static Future<BaseResp> sendVerifyCode(String mobile,{isRegister:false})  {
    return Api().post(
      "/permission/user/getVerifyCode",
      formData: {"mobile": mobile, "type": isRegister?0:1},
      processor: (s) {
        return null;
      },
    );
  }

  static Future<BaseResp> fastLogin(
      String mobile, String verifyCode)  {
    return Api().get(
      "/permission/fastLogin",
      queryMap: {"mobile": mobile, "verifyCode": verifyCode},
      processor: (s) {
        return null;
      },
    );
  }

  static Future<BaseResp<UserInfoDetail>> getUserInfo()  {
    return Api().post(
      "/permission/user/getUserInfo",
      processor: (s) {
        print(s.runtimeType);
        return UserInfoDetail.fromJsonMap(s);
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
