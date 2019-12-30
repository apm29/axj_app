import 'package:axj_app/action/actions.dart';
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
        title: Text('个人中心'),
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            RaisedButton(
              onPressed: () {
                AppRouter.toHome(context, ActiveTab.Mine);
              },
              child: Text('Mine'),
            ),
            RaisedButton(
              onPressed: () {
                AppRouter.toHome(context, ActiveTab.Home);
              },
              child: Text('Home'),
            ),
            RaisedButton(
              onPressed: () {
                store.dispatch(LogoutAction());
                AppRouter.toHome(context, ActiveTab.Home);
              },
              child: Text('Logout'),
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
                    'Localization',
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
