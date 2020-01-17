import 'dart:convert';

import 'package:axj_app/model/bean/notice/notice.dart';
import 'package:axj_app/page/member_edit_page.dart';
import 'package:axj_app/page/member_manage_page.dart';
import 'package:axj_app/page/notice/notice_detail.dart';
import 'package:axj_app/page/vehicle_manage_page.dart';
import 'package:axj_app/redux/action/actions.dart';
import 'package:axj_app/main.dart';
import 'package:axj_app/page/dialog/auth_dialog_page.dart';
import 'package:axj_app/page/auth_page.dart';
import 'package:axj_app/page/home_page.dart';
import 'package:axj_app/page/login_page.dart';
import 'package:axj_app/page/modal/auth_modal.dart';
import 'package:axj_app/page/my_house_page.dart';
import 'package:axj_app/page/personal_settings_page.dart';
import 'package:axj_app/page/register_page.dart';
import 'package:axj_app/page/splash_page.dart';
import 'package:axj_app/redux/store/store.dart';
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
  static String authHint = "/auth_hint";
  static String authForm = "/auth_form";
  static String authFace = "/auth_face";
  static String myHouse = "/my_house";
  static String myMember = "/my_member";
  static String myVehicle = "/my_vehicle";
  static String editMember = "/edit_member";
  static String noticeDetail = "/notice/id";
  static String noticeDetail2 = "/notice/data";

  static String keyId = "id";
  static String keyData = "id";
  static String keyType = "type";

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
    router.define(authHint, handler: authHintHandler);
    router.define(myHouse, handler: myHouseHandler);
    router.define(myVehicle, handler: myCarHandler);
    router.define(authForm, handler: authHandler);
    router.define('$authFace/:$keyId', handler: authFaceHandler);
    router.define('$myMember/:$keyId', handler: myMemberHandler);
    router.define('$noticeDetail/:$keyId', handler: noticeDetailHandler);
    router.define('$noticeDetail2/:$keyData', handler: noticeDetailHandler2);
    router.define('$editMember/:$keyId/:$keyType', handler: editMemberHandler);
  }
}

class NotFoundPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('抱歉'),
      ),
      body: Center(
        child: Text('404 Not Found 路由未找到'),
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

final authHintHandler = new Handler(
  handlerFunc: (BuildContext context, Map<String, List<String>> params) {
    return AuthDialogPage();
  },
);
final myHouseHandler = new Handler(
  handlerFunc: (BuildContext context, Map<String, List<String>> params) {
    return MyHousePage();
  },
);
final myCarHandler = new Handler(
  handlerFunc: (BuildContext context, Map<String, List<String>> params) {
    return VehicleManagePage();
  },
);

final authHandler = new Handler(
  handlerFunc: (BuildContext context, Map<String, List<String>> params) {
    return AuthFormPage();
  },
);
final authFaceHandler = new Handler(
  handlerFunc: (BuildContext context, Map<String, List<String>> params) {
    return AuthFacePage(idCardNum: params[Routes.keyId].first);
  },
);
final myMemberHandler = new Handler(
  handlerFunc: (BuildContext context, Map<String, List<String>> params) {
    return MemberManagePage(houseId: params[Routes.keyId].first);
  },
);

final noticeDetailHandler = new Handler(
  handlerFunc: (BuildContext context, Map<String, List<String>> params) {
    return NoticeDetailPage(noticeId: params[Routes.keyId].first);
  },
);
final noticeDetailHandler2 = new Handler(
  handlerFunc: (BuildContext context, Map<String, List<String>> params) {
    Notice notice;
    try {
      var key = params[Routes.keyData].first;
      notice = dataCachedMap[key];
      dataCachedMap.remove(key);
    } catch (e) {
      notice = null;
    }
    return NoticeDetailPage(
      notice: notice,
    );
  },
);

final editMemberHandler = new Handler(
  handlerFunc: (BuildContext context, Map<String, List<String>> params) {
    var id = params[Routes.keyId].first;
    var type = params[Routes.keyType].first;
    return MemberEditPage(
      id: id,
      edit: type == '1',
    );
  },
);

final defaultTransitionType = TransitionType.material;
final defaultTransitionDuration = Duration(milliseconds: 2800);
final dataCachedMap = Map<String, dynamic>();

class AppRouter {
  static Future toHomeAndReplaceSelf(BuildContext context) {
    if (ModalRoute.of(context).settings.name == Routes.home) {
      return Future.value();
    }
    return Application.router.navigateTo(
      context,
      Routes.home,
      replace: true,
      transition: defaultTransitionType,
    );
  }

  static Future toPersonal(BuildContext context) {
    return Application.router.navigateTo(
      context,
      Routes.personalSettings,
      transition: defaultTransitionType,
    );
  }

  static Future toHome(BuildContext context, ActiveTab activeTab) {
    store.dispatch(TabSwitchAction(activeTab.index, context));
    return Application.router.navigateTo(
      context,
      Routes.home,
      replace: true,
      clearStack: true,
      transition: defaultTransitionType,
    );
  }

  static Future toLogin(BuildContext context) {
    return Application.router.navigateTo(
      context,
      Routes.login,
      transition: TransitionType.inFromBottom,
    );
  }

  static Future toRegister(BuildContext context) {
    return Application.router.navigateTo(
      context,
      Routes.register,
      transition: defaultTransitionType,
    );
  }

  static Future toAuthHint(BuildContext context) {
    return Navigator.of(context).push(AuthModal());
  }

  static Future toAuthForm(BuildContext context) {
    return Application.router.navigateTo(
      context,
      Routes.authForm,
      transition: defaultTransitionType,
    );
  }

  static Future toAuthFace(BuildContext context, String idCardNum) {
    return Application.router.navigateTo(
      context,
      '${Routes.authFace}/$idCardNum',
      transition: defaultTransitionType,
    );
  }

  static Future toVehicleManage(BuildContext context) {
    return Application.router.navigateTo(context, Routes.myVehicle,
        transition: defaultTransitionType);
  }

  ///@param id: houseId(familyId)
  static Future toMembersManage(BuildContext context, dynamic id) {
    return Application.router.navigateTo(
      context,
      '${Routes.myMember}/$id',
      transition: defaultTransitionType,
    );
  }

  ///@param id: houseId(familyId)
  static Future toNoticeDetail(BuildContext context, dynamic noticeId) {
    return Application.router.navigateTo(
      context,
      '${Routes.noticeDetail}/$noticeId',
      transition: TransitionType.material,
    );
  }

  static Future toNoticeDetailWithData(BuildContext context, Notice notice) {
    var path = '${Routes.noticeDetail2}/${notice.noticeId}';
    dataCachedMap[notice.noticeId.toString()] = notice;
    return Application.router.navigateTo(
      context,
      path,
      transition: defaultTransitionType,
      transitionDuration: defaultTransitionDuration,
    );
  }

  ///当编辑家庭成员时id传入memberId,否则传入houseId(familyId)
  static Future toMemberEdit(BuildContext context, dynamic id,
      {bool edit = true}) {
    return Application.router.navigateTo(
      context,
      '${Routes.editMember}/$id/${edit ? 1 : 0}',
      transition: defaultTransitionType,
      transitionDuration: defaultTransitionDuration,
    );
  }
}
