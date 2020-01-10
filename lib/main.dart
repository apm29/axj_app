import 'dart:async';

import 'package:axj_app/configuration.dart';
import 'package:axj_app/redux/middleware/middlewares.dart';
import 'package:axj_app/model/cache.dart';
import 'package:axj_app/page/splash_page.dart';
import 'package:axj_app/route/route.dart';
import 'package:axj_app/redux/store/store.dart';
import 'package:axj_app/generated/i18n.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:oktoast/oktoast.dart';
import 'package:redux_dev_tools/redux_dev_tools.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // 初始化缓存
  await Cache().init();
  // 注册 fluro routes
  Application.init();
  //全局异常捕获
  FlutterError.onError = (FlutterErrorDetails details) {
    customerReport(detail: details);
  };
  runZoned(
    () => runApp(FlutterReduxApp()),
    onError: (Object obj, StackTrace stack) {
      customerReport(error: obj, stackTrace: stack);
    },
  );
}

customerReport(
    {FlutterErrorDetails detail, Object error, StackTrace stackTrace}) {
  if (detail != null) {
    print(detail);
  } else {
    print(error);
    print(stackTrace);
  }
}

report(line) {
  //debugPrint('FROM---------->$line');
}

final DevToolsStore<AppState> store = DevToolsStore<AppState>(
  appReduce,
  initialState: AppState(),
  middleware: createAppMiddleware(),
);

class FlutterReduxApp extends StatelessWidget {
  FlutterReduxApp({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StoreProvider(
      store: store,
      child: OKToast(
        child: StoreConnector<AppState, Locale>(
          converter: (store) => store.state.locale,
          distinct: true,
          builder: (ctx, locale) => MaterialApp(
            debugShowCheckedModeBanner: Configs.APP_DEBUG,
            localizationsDelegates: [
              // ... app-specific localization delegate[s] here
              S.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
              DefaultCupertinoLocalizations.delegate
            ],
            supportedLocales: S.delegate.supportedLocales,
            theme: ThemeData(
              // This is the theme of your application.
              //
              // Try running your application with "flutter run". You'll see the
              // application has a blue toolbar. Then, without quitting the app, try
              // changing the primarySwatch below to Theme.of(context).primaryColor and then invoke
              // "hot reload" (press "r" in the console where you ran "flutter run",
              // or simply save your changes to "hot reload" in a Flutter IDE).
              // Notice that the counter didn't reset back to zero; the application
              // is not restarted.
              platform: TargetPlatform.iOS,
              appBarTheme: AppBarTheme(
                brightness: Brightness.dark,
                color: Color(0xffffffff),
                iconTheme: IconThemeData(
                  color: Color(0xff1a7fd5),
                ),
                actionsIconTheme: IconThemeData(
                  color: Color(0xff1a7fd5),
                ),
                textTheme: TextTheme(),
              ),
              applyElevationOverlayColor: true,
              primaryColor: Color(0xffffffff),
              primaryColorBrightness: Brightness.light,
              primaryColorLight: Color(0xffdfe8f3),
              primaryColorDark: Color(0xfffdfdfd),
              accentColor: Color(0xff1a7fd5),
              accentColorBrightness: Brightness.dark,
              canvasColor: Color(0xfffdfdfd),
              scaffoldBackgroundColor: Color(0xfffdfdfd),
              iconTheme: IconThemeData(color: Color(0xff1a7fd5))
            ),
            darkTheme: ThemeData(
                brightness: Brightness.dark,
                platform: TargetPlatform.iOS,
                appBarTheme: AppBarTheme(
                  brightness: Brightness.dark,
                  color: Color(0xff111820),
                  iconTheme: IconThemeData(
                    color: Colors.white,
                  ),
                  actionsIconTheme: IconThemeData(
                    color: Colors.white,
                  ),
                  textTheme: TextTheme(),
                ),
                applyElevationOverlayColor: true,
                primaryColor: Color(0xff131d27),
                primaryColorBrightness: Brightness.dark,
                primaryColorLight: Color(0xff2f4254),
                primaryColorDark: Color(0xff111820),
                accentColor: Color(0xff1a7fd5),
                accentColorBrightness: Brightness.dark,
                canvasColor: Color(0xff111820),
                scaffoldBackgroundColor: Color(0xff111820)),
            onGenerateRoute: Application.router.generator,
            locale: locale,
            home: SplashPage(),
          ),
        ),
      ),
    );
  }
}
