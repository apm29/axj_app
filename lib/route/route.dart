import 'package:axj_app/page/home_page.dart';
import 'package:axj_app/page/splash_page.dart';
import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';

///
/// author : ciih
/// date : 2019-12-25 16:00
/// description :
///
class Application {
  static Router router;
}

class Routes {
  static String root = "/";
  static String home = "/home";

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
var splashHandler = new Handler(handlerFunc: (
  BuildContext context,
  Map<String, List<String>> params,
) {
  return SplashPage();
});

var homeHandler = new Handler(handlerFunc: (
    BuildContext context,
    Map<String, List<String>> params,
    ) {
  return HomePage();
});
