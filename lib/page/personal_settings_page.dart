import 'package:axj_app/action/actions.dart';
import 'package:axj_app/generated/i18n.dart';
import 'package:axj_app/main.dart';
import 'package:axj_app/route/route.dart';
import 'package:axj_app/store/store.dart';
import 'package:flutter/material.dart';

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
            PopupMenuButton<Locale>(
              itemBuilder: (ctx) {
                return [
                  PopupMenuItem(
                    child: Text('中文'),
                    value: Locale('zh'),
                  ),
                  PopupMenuItem(
                    child: Text('English'),
                    value: Locale('en'),
                  ),
                ];
              },
              child: Material(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    S.of(context).localeMenuLabel,
                    style: TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: 16
                    ),
                  ),
                ),
                type: MaterialType.button,
                color: Colors.grey[300],
                elevation: 2,
              ),
              onSelected: (locale) {
                store.dispatch(ChangeLocaleAction(locale));
                AppRouter.toHome(context, ActiveTab.Home);
              },
            ),
          ],
        ),
      ),
    );
  }
}
