import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

// ignore_for_file: non_constant_identifier_names
// ignore_for_file: camel_case_types
// ignore_for_file: prefer_single_quotes

// This file is automatically generated. DO NOT EDIT, all your changes would be lost.
class S implements WidgetsLocalizations {
  const S();

  static S current;

  static const GeneratedLocalizationsDelegate delegate =
    GeneratedLocalizationsDelegate();

  static S of(BuildContext context) => Localizations.of<S>(context, S);

  @override
  TextDirection get textDirection => TextDirection.ltr;

  String get appName => "Monster";
  String get authFaceHint => "Align your face within the frame,then tap the confirm button";
  String get authTitle => "Authenticate";
  String get closeNotificationHint => "Close Notification Service";
  String get confirmLabel => "Confirm";
  String get editUserProfile => "edit your profile";
  String get homeTab => "Home";
  String get idFormHint => "Identity Card Number (11 digit)";
  String get idFormTitle => "Confirm Identity Info";
  String get loadingCameraHint => "Loading Camera Settings";
  String get localeMenuLabel => "Localization";
  String get loginLabel => "Login";
  String get logoutLabel => "Logout";
  String get messageLabel => "Message";
  String get mineTab => "Mine";
  String get motto => "Understated,Forbearance,massacre";
  String get nextStepLabel => "Next Step";
  String get notAuthTitle => "You are not authenticated";
  String get notNowAuthLabel => "Not now";
  String get openNotificationHint => "Open Notification Service";
  String get passwordHint => "password";
  String get passwordLoginLabel => "Account";
  String get passwordRepeatError => "Inconsistent passwords";
  String get passwordRepeatHint => "repeat password";
  String get phoneHint => "phone number";
  String get phoneLabel => "Mobile";
  String get registerHint => "No account,Click to Sign in";
  String get registerLabel => "Sign in now!";
  String get registerTitle => "Sign in";
  String get sendSmsCodeHint => "Send Code";
  String get settingLabel => "Settings";
  String get settingsPageTitle => "Personal Settings";
  String get skipLabel => "Skip";
  String get smsCodeHint => "SMS Code";
  String get smsCodeLabel => "Code";
  String get smsLoginLabel => "SMS";
  String get toAuthHint => "Authenticate";
  String get userNameHint => "username";
  String serviceProtocolName(String appName) => "$appName Service Protocol";
  String serviceProtocolText(String serviceProtocolName) => "I agree with <<$serviceProtocolName>>";
}

class $en extends S {
  const $en();
}

class $zh_CN extends S {
  const $zh_CN();

  @override
  TextDirection get textDirection => TextDirection.ltr;

  @override
  String get registerLabel => "立即注册";
  @override
  String get passwordHint => "密码";
  @override
  String get notNowAuthLabel => "暂不认证";
  @override
  String get smsLoginLabel => "短信登录";
  @override
  String get loginLabel => "登录";
  @override
  String get loadingCameraHint => "正在加载相机..";
  @override
  String get logoutLabel => "登出";
  @override
  String get toAuthHint => "前往认证";
  @override
  String get closeNotificationHint => "关闭推送通知";
  @override
  String get idFormHint => "11位中国身份证号码";
  @override
  String get phoneLabel => "手机号";
  @override
  String get localeMenuLabel => "国际化";
  @override
  String get authFaceHint => "将您的脸对准屏幕正中心,然后轻点确认按钮";
  @override
  String get notAuthTitle => " 您还未实名认证";
  @override
  String get homeTab => "主页";
  @override
  String get smsCodeHint => "6位验证码";
  @override
  String get editUserProfile => "编辑个人资料";
  @override
  String get sendSmsCodeHint => "发送验证码";
  @override
  String get authTitle => "身份认证";
  @override
  String get appName => "卡牌助手";
  @override
  String get passwordRepeatError => "密码不一致";
  @override
  String get messageLabel => "消息";
  @override
  String get phoneHint => "11位手机号";
  @override
  String get skipLabel => "跳过";
  @override
  String get passwordLoginLabel => "密码登录";
  @override
  String get registerTitle => "注册";
  @override
  String get nextStepLabel => "下一步";
  @override
  String get mineTab => "我的";
  @override
  String get openNotificationHint => "打开推送通知";
  @override
  String get userNameHint => "用户名";
  @override
  String get smsCodeLabel => "验证码";
  @override
  String get passwordRepeatHint => "重复密码";
  @override
  String get idFormTitle => "确认身份信息";
  @override
  String get motto => "智慧生活,安心陪伴";
  @override
  String get confirmLabel => "确认";
  @override
  String get registerHint => "没有账户? 点击注册";
  @override
  String get settingsPageTitle => "个人设置";
  @override
  String get settingLabel => "设置";
  @override
  String serviceProtocolName(String appName) => "${appName}用户服务协议";
  @override
  String serviceProtocolText(String serviceProtocolName) => "登录即视为同意<<$serviceProtocolName>>";
}

class GeneratedLocalizationsDelegate extends LocalizationsDelegate<S> {
  const GeneratedLocalizationsDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale("en", ""),
      Locale("zh", "CN"),
    ];
  }

  LocaleListResolutionCallback listResolution({Locale fallback, bool withCountry = true}) {
    return (List<Locale> locales, Iterable<Locale> supported) {
      if (locales == null || locales.isEmpty) {
        return fallback ?? supported.first;
      } else {
        return _resolve(locales.first, fallback, supported, withCountry);
      }
    };
  }

  LocaleResolutionCallback resolution({Locale fallback, bool withCountry = true}) {
    return (Locale locale, Iterable<Locale> supported) {
      return _resolve(locale, fallback, supported, withCountry);
    };
  }

  @override
  Future<S> load(Locale locale) {
    final String lang = getLang(locale);
    if (lang != null) {
      switch (lang) {
        case "en":
          S.current = const $en();
          return SynchronousFuture<S>(S.current);
        case "zh_CN":
          S.current = const $zh_CN();
          return SynchronousFuture<S>(S.current);
        default:
          // NO-OP.
      }
    }
    S.current = const S();
    return SynchronousFuture<S>(S.current);
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale, true);

  @override
  bool shouldReload(GeneratedLocalizationsDelegate old) => false;

  ///
  /// Internal method to resolve a locale from a list of locales.
  ///
  Locale _resolve(Locale locale, Locale fallback, Iterable<Locale> supported, bool withCountry) {
    if (locale == null || !_isSupported(locale, withCountry)) {
      return fallback ?? supported.first;
    }

    final Locale languageLocale = Locale(locale.languageCode, "");
    if (supported.contains(locale)) {
      return locale;
    } else if (supported.contains(languageLocale)) {
      return languageLocale;
    } else {
      final Locale fallbackLocale = fallback ?? supported.first;
      return fallbackLocale;
    }
  }

  ///
  /// Returns true if the specified locale is supported, false otherwise.
  ///
  bool _isSupported(Locale locale, bool withCountry) {
    if (locale != null) {
      for (Locale supportedLocale in supportedLocales) {
        // Language must always match both locales.
        if (supportedLocale.languageCode != locale.languageCode) {
          continue;
        }

        // If country code matches, return this locale.
        if (supportedLocale.countryCode == locale.countryCode) {
          return true;
        }

        // If no country requirement is requested, check if this locale has no country.
        if (true != withCountry && (supportedLocale.countryCode == null || supportedLocale.countryCode.isEmpty)) {
          return true;
        }
      }
    }
    return false;
  }
}

String getLang(Locale l) => l == null
  ? null
  : l.countryCode != null && l.countryCode.isEmpty
    ? l.languageCode
    : l.toString();
