import 'package:axj_app/action/actions.dart';
import 'package:axj_app/generated/i18n.dart';
import 'package:axj_app/main.dart';
import 'package:axj_app/route/route.dart';
import 'package:axj_app/store/store.dart';
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
                  value: Locale('zh','CN'),
                ),
                PopupMenuItem(
                  child: Text('English'),
                  value: Locale('en'),
                ),
              ];
            },
            onSelected: (locale) {
              store.dispatch(ChangeLocaleAction(locale));
              AppRouter.toHome(context, ActiveTab.Home);
            },
          ),
        ],
      ),
      body: Center(
        child: Column(
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
                store.dispatch(LogoutAction());
                AppRouter.toHome(context, ActiveTab.Home);
              },
              child: Text(S.of(context).logoutLabel),
            ),
            RaisedButton(
              onPressed: () {
                store.dispatch(VoidTaskSimulationAction(
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
                store.dispatch(ResultTaskSimulationAction(
                  () async {
                    await Future.delayed(Duration(seconds: 3));
                    return 1;
                  },
                  context,
                ));
              },
              child: StoreBuilder<AppState>(
                builder: (context, store) {
                  return Text('result task simulate:'+'${store.state.simulationResult??''}');
                }
              ),
            ),
          ],
        ),
      ),
    );
  }
}
