import 'package:axj_app/store/store.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Cache {
  SharedPreferences _sharedPreferences;

  Cache._();

  static Cache _cacheInstance;

  factory Cache() {
    if (_cacheInstance == null) {
      _cacheInstance = Cache._();
    }
    return _cacheInstance;
  }

  final tokenKey = 'token';

  init() async {
    _sharedPreferences = await SharedPreferences.getInstance();
  }

  String get token => _sharedPreferences.get(tokenKey);

  void setToken(String token) {
    try {
      _sharedPreferences.setString(tokenKey, token);
    } catch (e) {
      print(getErrorMessage(e));
    }
  }
}
