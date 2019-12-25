import 'package:axj_app/middleware/middlewares.dart';
import 'package:axj_app/model/cache.dart';
import 'package:axj_app/page/splash_page.dart';
import 'package:axj_app/route/route.dart';
import 'package:axj_app/store/store.dart';
import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:oktoast/oktoast.dart';
import 'package:redux_dev_tools/redux_dev_tools.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // 初始化缓存
  await Cache().init();
  // 注册 fluro routes
  Router router = Router();
  Routes.configureRoutes(router);
  Application.router = router;

  runApp(FlutterReduxApp());
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
        child: MaterialApp(
          title: 'Flutter Demo',
          theme: ThemeData(
            // This is the theme of your application.
            //
            // Try running your application with "flutter run". You'll see the
            // application has a blue toolbar. Then, without quitting the app, try
            // changing the primarySwatch below to Colors.green and then invoke
            // "hot reload" (press "r" in the console where you ran "flutter run",
            // or simply save your changes to "hot reload" in a Flutter IDE).
            // Notice that the counter didn't reset back to zero; the application
            // is not restarted.
            primarySwatch: Colors.blue,
          ),
          onGenerateRoute: Application.router.generator,
          home: SplashPage(),
        ),
      ),
    );
  }
}

