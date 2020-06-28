// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars

class S {
  S();
  
  static S current;
  
  static const AppLocalizationDelegate delegate =
    AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false) ? locale.languageCode : locale.toString();
    final localeName = Intl.canonicalizedLocale(name); 
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      S.current = S();
      
      return S.current;
    });
  } 

  static S of(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `Monster`
  String get appName {
    return Intl.message(
      'Monster',
      name: 'appName',
      desc: '',
      args: [],
    );
  }

  /// `Understated,Forbearance,massacre`
  String get motto {
    return Intl.message(
      'Understated,Forbearance,massacre',
      name: 'motto',
      desc: '',
      args: [],
    );
  }

  /// `Home`
  String get homeTab {
    return Intl.message(
      'Home',
      name: 'homeTab',
      desc: '',
      args: [],
    );
  }

  /// `Mine`
  String get mineTab {
    return Intl.message(
      'Mine',
      name: 'mineTab',
      desc: '',
      args: [],
    );
  }

  /// `SMS`
  String get smsLoginLabel {
    return Intl.message(
      'SMS',
      name: 'smsLoginLabel',
      desc: '',
      args: [],
    );
  }

  /// `Mobile`
  String get phoneLabel {
    return Intl.message(
      'Mobile',
      name: 'phoneLabel',
      desc: '',
      args: [],
    );
  }

  /// `phone number`
  String get phoneHint {
    return Intl.message(
      'phone number',
      name: 'phoneHint',
      desc: '',
      args: [],
    );
  }

  /// `Code`
  String get smsCodeLabel {
    return Intl.message(
      'Code',
      name: 'smsCodeLabel',
      desc: '',
      args: [],
    );
  }

  /// `SMS Code`
  String get smsCodeHint {
    return Intl.message(
      'SMS Code',
      name: 'smsCodeHint',
      desc: '',
      args: [],
    );
  }

  /// `Send Code`
  String get sendSmsCodeHint {
    return Intl.message(
      'Send Code',
      name: 'sendSmsCodeHint',
      desc: '',
      args: [],
    );
  }

  /// `Account`
  String get passwordLoginLabel {
    return Intl.message(
      'Account',
      name: 'passwordLoginLabel',
      desc: '',
      args: [],
    );
  }

  /// `username`
  String get userNameHint {
    return Intl.message(
      'username',
      name: 'userNameHint',
      desc: '',
      args: [],
    );
  }

  /// `password`
  String get passwordHint {
    return Intl.message(
      'password',
      name: 'passwordHint',
      desc: '',
      args: [],
    );
  }

  /// `repeat password`
  String get passwordRepeatHint {
    return Intl.message(
      'repeat password',
      name: 'passwordRepeatHint',
      desc: '',
      args: [],
    );
  }

  /// `Inconsistent passwords`
  String get passwordRepeatError {
    return Intl.message(
      'Inconsistent passwords',
      name: 'passwordRepeatError',
      desc: '',
      args: [],
    );
  }

  /// `Login`
  String get loginLabel {
    return Intl.message(
      'Login',
      name: 'loginLabel',
      desc: '',
      args: [],
    );
  }

  /// `Logout`
  String get logoutLabel {
    return Intl.message(
      'Logout',
      name: 'logoutLabel',
      desc: '',
      args: [],
    );
  }

  /// `Confirm Logout?`
  String get confirmLogoutHint {
    return Intl.message(
      'Confirm Logout?',
      name: 'confirmLogoutHint',
      desc: '',
      args: [],
    );
  }

  /// `Localization`
  String get localeMenuLabel {
    return Intl.message(
      'Localization',
      name: 'localeMenuLabel',
      desc: '',
      args: [],
    );
  }

  /// `$appName Service Protocol`
  String get serviceProtocolName {
    return Intl.message(
      '\$appName Service Protocol',
      name: 'serviceProtocolName',
      desc: '',
      args: [],
    );
  }

  /// `I agree with <<$serviceProtocolName>>`
  String get serviceProtocolText {
    return Intl.message(
      'I agree with <<\$serviceProtocolName>>',
      name: 'serviceProtocolText',
      desc: '',
      args: [],
    );
  }

  /// `No account,Click to Sign in`
  String get registerHint {
    return Intl.message(
      'No account,Click to Sign in',
      name: 'registerHint',
      desc: '',
      args: [],
    );
  }

  /// `Sign in`
  String get registerTitle {
    return Intl.message(
      'Sign in',
      name: 'registerTitle',
      desc: '',
      args: [],
    );
  }

  /// `Sign in now!`
  String get registerLabel {
    return Intl.message(
      'Sign in now!',
      name: 'registerLabel',
      desc: '',
      args: [],
    );
  }

  /// `Skip`
  String get skipLabel {
    return Intl.message(
      'Skip',
      name: 'skipLabel',
      desc: '',
      args: [],
    );
  }

  /// `Personal Settings`
  String get settingsPageTitle {
    return Intl.message(
      'Personal Settings',
      name: 'settingsPageTitle',
      desc: '',
      args: [],
    );
  }

  /// `edit your profile`
  String get editUserProfile {
    return Intl.message(
      'edit your profile',
      name: 'editUserProfile',
      desc: '',
      args: [],
    );
  }

  /// `Message`
  String get messageLabel {
    return Intl.message(
      'Message',
      name: 'messageLabel',
      desc: '',
      args: [],
    );
  }

  /// `Settings`
  String get settingLabel {
    return Intl.message(
      'Settings',
      name: 'settingLabel',
      desc: '',
      args: [],
    );
  }

  /// `a`
  String get a {
    return Intl.message(
      'a',
      name: 'a',
      desc: '',
      args: [],
    );
  }

  /// `Close Notification Service`
  String get closeNotificationHint {
    return Intl.message(
      'Close Notification Service',
      name: 'closeNotificationHint',
      desc: '',
      args: [],
    );
  }

  /// `Open Notification Service`
  String get openNotificationHint {
    return Intl.message(
      'Open Notification Service',
      name: 'openNotificationHint',
      desc: '',
      args: [],
    );
  }

  /// `You are not authenticated`
  String get notAuthTitle {
    return Intl.message(
      'You are not authenticated',
      name: 'notAuthTitle',
      desc: '',
      args: [],
    );
  }

  /// `Authenticate`
  String get toAuthHint {
    return Intl.message(
      'Authenticate',
      name: 'toAuthHint',
      desc: '',
      args: [],
    );
  }

  /// `Not now`
  String get notNowAuthLabel {
    return Intl.message(
      'Not now',
      name: 'notNowAuthLabel',
      desc: '',
      args: [],
    );
  }

  /// `Loading Camera Settings`
  String get loadingCameraHint {
    return Intl.message(
      'Loading Camera Settings',
      name: 'loadingCameraHint',
      desc: '',
      args: [],
    );
  }

  /// `Authenticate`
  String get authTitle {
    return Intl.message(
      'Authenticate',
      name: 'authTitle',
      desc: '',
      args: [],
    );
  }

  /// `Align your face within the frame,then tap the confirm button`
  String get authFaceHint {
    return Intl.message(
      'Align your face within the frame,then tap the confirm button',
      name: 'authFaceHint',
      desc: '',
      args: [],
    );
  }

  /// `Confirm Identity Info`
  String get idFormTitle {
    return Intl.message(
      'Confirm Identity Info',
      name: 'idFormTitle',
      desc: '',
      args: [],
    );
  }

  /// `Identity Card Number (11 digit)`
  String get idFormHint {
    return Intl.message(
      'Identity Card Number (11 digit)',
      name: 'idFormHint',
      desc: '',
      args: [],
    );
  }

  /// `Next Step`
  String get nextStepLabel {
    return Intl.message(
      'Next Step',
      name: 'nextStepLabel',
      desc: '',
      args: [],
    );
  }

  /// `Confirm`
  String get confirmLabel {
    return Intl.message(
      'Confirm',
      name: 'confirmLabel',
      desc: '',
      args: [],
    );
  }

  /// `Warning`
  String get warningLabel {
    return Intl.message(
      'Warning',
      name: 'warningLabel',
      desc: '',
      args: [],
    );
  }

  /// `Cancel`
  String get cancelLabel {
    return Intl.message(
      'Cancel',
      name: 'cancelLabel',
      desc: '',
      args: [],
    );
  }

  /// `Edit`
  String get editLabel {
    return Intl.message(
      'Edit',
      name: 'editLabel',
      desc: '',
      args: [],
    );
  }

  /// `Delete`
  String get deleteLabel {
    return Intl.message(
      'Delete',
      name: 'deleteLabel',
      desc: '',
      args: [],
    );
  }

  /// `Confirm to Delete $some ?`
  String get deleteHint {
    return Intl.message(
      'Confirm to Delete \$some ?',
      name: 'deleteHint',
      desc: '',
      args: [],
    );
  }

  /// `Add`
  String get addLabel {
    return Intl.message(
      'Add',
      name: 'addLabel',
      desc: '',
      args: [],
    );
  }

  /// `Delete Success`
  String get deleteSuccessHint {
    return Intl.message(
      'Delete Success',
      name: 'deleteSuccessHint',
      desc: '',
      args: [],
    );
  }

  /// `Houses`
  String get myHouseTitle {
    return Intl.message(
      'Houses',
      name: 'myHouseTitle',
      desc: '',
      args: [],
    );
  }

  /// `Change House`
  String get changeHouseLabel {
    return Intl.message(
      'Change House',
      name: 'changeHouseLabel',
      desc: '',
      args: [],
    );
  }

  /// `Change Role`
  String get changeRoleLabel {
    return Intl.message(
      'Change Role',
      name: 'changeRoleLabel',
      desc: '',
      args: [],
    );
  }

  /// `My Houses`
  String get myHouseActionTileTitle {
    return Intl.message(
      'My Houses',
      name: 'myHouseActionTileTitle',
      desc: '',
      args: [],
    );
  }

  /// `View Houses info`
  String get myHouseActionTileHint {
    return Intl.message(
      'View Houses info',
      name: 'myHouseActionTileHint',
      desc: '',
      args: [],
    );
  }

  /// `My Vehicles`
  String get myVehicleActionTileTitle {
    return Intl.message(
      'My Vehicles',
      name: 'myVehicleActionTileTitle',
      desc: '',
      args: [],
    );
  }

  /// `View Vehicles info`
  String get myVehicleActionTileHint {
    return Intl.message(
      'View Vehicles info',
      name: 'myVehicleActionTileHint',
      desc: '',
      args: [],
    );
  }

  /// `Family Members`
  String get familyMemberActionTileTitle {
    return Intl.message(
      'Family Members',
      name: 'familyMemberActionTileTitle',
      desc: '',
      args: [],
    );
  }

  /// `Member Manage`
  String get familyMemberManageTitle {
    return Intl.message(
      'Member Manage',
      name: 'familyMemberManageTitle',
      desc: '',
      args: [],
    );
  }

  /// `Family Members/Tenants info`
  String get familyMemberActionTileHint {
    return Intl.message(
      'Family Members/Tenants info',
      name: 'familyMemberActionTileHint',
      desc: '',
      args: [],
    );
  }

  /// `Add Member`
  String get addFamilyMemberLabel {
    return Intl.message(
      'Add Member',
      name: 'addFamilyMemberLabel',
      desc: '',
      args: [],
    );
  }

  /// `Application List`
  String get applyListLabel {
    return Intl.message(
      'Application List',
      name: 'applyListLabel',
      desc: '',
      args: [],
    );
  }

  /// `Vehicle Manage`
  String get vehicleManageTitle {
    return Intl.message(
      'Vehicle Manage',
      name: 'vehicleManageTitle',
      desc: '',
      args: [],
    );
  }

  /// `In the Garage`
  String get vehicleInLabel {
    return Intl.message(
      'In the Garage',
      name: 'vehicleInLabel',
      desc: '',
      args: [],
    );
  }

  /// `Car`
  String get vehicleTypeCarLabel {
    return Intl.message(
      'Car',
      name: 'vehicleTypeCarLabel',
      desc: '',
      args: [],
    );
  }

  /// `Truck`
  String get vehicleTypeTruckLabel {
    return Intl.message(
      'Truck',
      name: 'vehicleTypeTruckLabel',
      desc: '',
      args: [],
    );
  }

  /// `E-Bike Tag:`
  String get eBikeTagLabel {
    return Intl.message(
      'E-Bike Tag:',
      name: 'eBikeTagLabel',
      desc: '',
      args: [],
    );
  }

  /// `Tap to see access record`
  String get clickToSeeAccessRecord {
    return Intl.message(
      'Tap to see access record',
      name: 'clickToSeeAccessRecord',
      desc: '',
      args: [],
    );
  }

  /// `You are Not authorized to view $member 's Access Record`
  String get recordViewNoAuthorizationHint {
    return Intl.message(
      'You are Not authorized to view \$member \'s Access Record',
      name: 'recordViewNoAuthorizationHint',
      desc: '',
      args: [],
    );
  }

  /// `Image not available`
  String get imageNoAvailable {
    return Intl.message(
      'Image not available',
      name: 'imageNoAvailable',
      desc: '',
      args: [],
    );
  }

  /// `Add E-Bike`
  String get addEBikeLabel {
    return Intl.message(
      'Add E-Bike',
      name: 'addEBikeLabel',
      desc: '',
      args: [],
    );
  }

  /// `Add Car`
  String get addVehicleLabel {
    return Intl.message(
      'Add Car',
      name: 'addVehicleLabel',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
      Locale.fromSubtags(languageCode: 'zh', countryCode: 'CN'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    if (locale != null) {
      for (var supportedLocale in supportedLocales) {
        if (supportedLocale.languageCode == locale.languageCode) {
          return true;
        }
      }
    }
    return false;
  }
}