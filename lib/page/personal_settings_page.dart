import 'package:axj_app/model/bean/role_info.dart';
import 'package:axj_app/page/component/gradient_background_widget.dart';
import 'package:axj_app/page/theme_test_page.dart';
import 'package:axj_app/redux/action/actions.dart';
import 'package:axj_app/generated/i18n.dart';
import 'package:axj_app/route/route.dart';
import 'package:axj_app/redux/store/store.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';

///
/// author : ciih
/// date : 2019-12-26 09:09
/// description :
///
class PersonalSettingsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(S.of(context).settingsPageTitle),
        actions: <Widget>[
          PopupMenuButton<Locale>(
            itemBuilder: (ctx) {
              return [
                PopupMenuItem(
                  child: Text('中文'),
                  value: Locale('zh', 'CN'),
                ),
                PopupMenuItem(
                  child: Text('English'),
                  value: Locale('en'),
                ),
              ];
            },
            onSelected: (locale) {
              StoreProvider.of<AppState>(context).dispatch(ChangeLocaleAction
                (locale));
            },
          ),
        ],
      ),
      body: Stack(
        children: <Widget>[
          GradientBackgroundWidget(),
          Center(
            child: ListView(
              children: <Widget>[
                RaisedButton(
                  onPressed: () {
                    AppRouter.toHome(context, ActiveTab.Mine);
                  },
                  child: Text(S.of(context).mineTab),
                ),
                RaisedButton(
                  onPressed: () {
                    AppRouter.toRegister(context);
                  },
                  child: Text(S.of(context).registerTitle),
                ),
                RaisedButton(
                  onPressed: () {
                    AppRouter.toHome(context, ActiveTab.Home);
                  },
                  child: Text(S.of(context).homeTab),
                ),
                RaisedButton(
                  onPressed: () {
                    StoreProvider.of<AppState>(context).dispatch(LogoutAction(context));
                  },
                  child: Text(S.of(context).logoutLabel),
                ),
                RaisedButton(
                  onPressed: () {
                    StoreProvider.of<AppState>(context).dispatch(ExplicitTaskAction(
                        StoreProvider.of<AppState>(context).state.settings.init, context));
                  },
                  child: Text(S.of(context).myHouseTitle),
                ),
                RaisedButton(
                  onPressed: () {
                    StoreProvider.of<AppState>(context).dispatch(ChangeHouseAction(context));
                  },
                  child: Text(S.of(context).changeHouseLabel),
                ),
                RaisedButton(
                  onPressed: () {
                    StoreProvider.of<AppState>(context).dispatch(ChangeRoleAction(context));
                  },
                  child: Text(S.of(context).changeRoleLabel),
                ),
                RaisedButton(
                  onPressed: () {
                    StoreProvider.of<AppState>(context).dispatch(ChangeRoleAction(
                      context,
                      roleCodeRequest: PoliceManCode,
                    ));
                  },
                  child: Text(S.of(context).changeRoleLabel),
                ),
                RaisedButton(
                  onPressed: () {
                    StoreProvider.of<AppState>(context).dispatch(ExplicitTaskAction(
                      () async {
                        await Future.delayed(Duration(seconds: 3));
                      },
                      context,
                    ));
                  },
                  child: Text('void task simulate'),
                ),
                RaisedButton(
                  onPressed: () {
                    StoreProvider.of<AppState>(context).dispatch(ResultTaskSimulationAction(
                      () async {
                        await Future.delayed(Duration(seconds: 3));
                        return 1;
                      },
                      context,
                    ));
                  },
                  child: StoreBuilder<AppState>(builder: (context, store) {
                    return Text('result task simulate:' +
                        '${store.state.simulationResult ?? ''}');
                  }),
                ),
                RaisedButton(
                  onPressed: () {
                    Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => ThemeTestPage()));
                  },
                  child: Text('Test'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
