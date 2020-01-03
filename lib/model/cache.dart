import 'package:axj_app/redux/store/store.dart';
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
  final localeKey = 'locale';

  init() async {
    _sharedPreferences = await SharedPreferences.getInstance();
  }

  String get token => _sharedPreferences.get(tokenKey);

  String get locale => _sharedPreferences.get(localeKey);

  void setToken(String token) {
    try {
      _sharedPreferences.setString(tokenKey, token);
    } catch (e) {
      print(getErrorMessage(e));
    }
  }

  void setLocale(String locale) {
    try {
      _sharedPreferences.setString(localeKey, locale);
    } catch (e) {
      print(getErrorMessage(e));
    }
  }
}
