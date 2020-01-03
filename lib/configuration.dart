///
/// author : ciih
/// date : 2020-01-03 11:05
/// description : 
///
class Configs {
  ///debug开关,debug为true时运行测试环境
  static const APP_DEBUG = false;

  ///iOS 定位key
  static const AMapKey = "d712d41f19e76ca74b673f9d5637af8a";
  static const BaseUrl =
  APP_DEBUG ? "http://axjtest.ciih.net/" : "http://axjdx.ciih.net/";
  static const KF_EMERGENCY_WS_URL = Configs.APP_DEBUG?"ws://60.190.188.139:9508":"ws://220.191.225.209:7001";
  static const KF_APP_ID = "YW54aW5qdS0oKSo\=";
  ///iOS 推送key
  static const JPushKey = "a175ef122d6568c5bec7cd53";

  static const KFBaseUrl =
  APP_DEBUG ? "http://axjkftest.ciih.net" : "http://axjkf.ciih.net";

  static const AGORA_APP_ID = "c5ed80b0b3884fc488a2283ccce55017";

  static const AGORA_CHANNEL_POLICE = "AGORA_CHANNEL_POLICE";
}