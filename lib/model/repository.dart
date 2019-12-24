import 'api.dart';

class Repository {
  static Future<BaseResp<String>> login(String userName, String password) async {
    return Api().post<String>(
      "/permission/login",
      formData: {"userName": "yjw", "password": "123456"},
      processor: (s) {
        return s;
      },
      showProgress: true,
      loadingText: "正在登陆..",
    );
  }
}
