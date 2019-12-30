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
          ],
        ),
      ),
    );
  }
}
