import 'package:axj_app/action/actions.dart';
import 'package:axj_app/main.dart';
import 'package:axj_app/page/home_page.dart';
import 'package:axj_app/page/login_page.dart';
import 'package:axj_app/page/personal_settings_page.dart';
import 'package:axj_app/page/register_page.dart';
import 'package:axj_app/page/splash_page.dart';
import 'package:axj_app/store/store.dart';
import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';

///
/// author : ciih
/// date : 2019-12-25 16:00
/// description :
///
class Application {
  static Router router;

  static void init() {
    Router router = Router();
    Routes.configureRoutes(router);
    Application.router = router;
  }
}

class Routes {
  static String root = "/";
  static String home = "/home";
  static String login = "/login";
  static String personalSettings = "/personal_settings";
  static String register = "/register";

  static void configureRoutes(Router router) {
    router.notFoundHandler = new Handler(handlerFunc: (
      BuildContext context,
      Map<String, List<String>> params,
    ) {
      print("ROUTE WAS NOT FOUND !!!");
      return NotFoundPage();
    });

    /// 第一个参数是路由地址，第二个参数是页面跳转和传参，第三个参数是默认的转场动画，可以看上图
    /// 我这边先不设置默认的转场动画，转场动画在下面会讲，可以在另外一个地方设置（可以看NavigatorUtil类）
    router.define(root, handler: splashHandler);
    router.define(home, handler: homeHandler);
    router.define(login, handler: loginHandler);
    router.define(personalSettings, handler: personalSettingsHandler);
    router.define(register, handler: registerHandler);
  }
}

class NotFoundPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text('404 路由未找到'),
      ),
    );
  }
}

/// 跳转到首页Splash
final splashHandler = new Handler(
  handlerFunc: (BuildContext context, Map<String, List<String>> params) {
    return SplashPage();
  },
);

final homeHandler = new Handler(
  handlerFunc: (BuildContext context, Map<String, List<String>> params) {
    return HomePage();
  },
);

final personalSettingsHandler = new Handler(
  handlerFunc: (BuildContext context, Map<String, List<String>> params) {
    return PersonalSettingsPage();
  },
);

final loginHandler = new Handler(
  handlerFunc: (BuildContext context, Map<String, List<String>> params) {
    return LoginPage();
  },
);

final registerHandler = new Handler(
  handlerFunc: (BuildContext context, Map<String, List<String>> params) {
    return RegisterPage();
  },
);

class AppRouter {
  static Future toHomeAndReplaceSelf(BuildContext context) {
    return Application.router.navigateTo(context, Routes.home, replace: true);
  }

  static Future toPersonal(BuildContext context) {
    return Application.router.navigateTo(
      context,
      Routes.personalSettings,
      transition: TransitionType.inFromBottom,
    );
  }

  static Future toHome(BuildContext context, ActiveTab activeTab) {
    store.dispatch(TabSwitchAction(activeTab.index, context));
    return Application.router
        .navigateTo(context, Routes.home, replace: true, clearStack: true);
  }

  static Future toLogin(BuildContext context) {
    return Application.router.navigateTo(
      context,
      Routes.login,
      transition
          : TransitionType.inFromBottom,
    );
  }

  static Future toRegister(BuildContext context) {
    return Application.router.navigateTo(
      context,
      Routes.register,
      transition
          : TransitionType.cupertino,
    );
  }
}
