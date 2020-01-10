import 'dart:async';

import 'package:axj_app/configuration.dart';
import 'package:axj_app/redux/middleware/middlewares.dart';
import 'package:axj_app/model/cache.dart';
import 'package:axj_app/page/splash_page.dart';
import 'package:axj_app/route/route.dart';
import 'package:axj_app/redux/store/store.dart';
import 'package:axj_app/generated/i18n.dart';
import 'package:axj_app/theme/theme.dart';
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
            theme: twitterLight,
            darkTheme: twitterDark,
            onGenerateRoute: Application.router.generator,
            locale: locale,
            home: SplashPage(),
          ),
        ),
      ),
    );
  }
}
