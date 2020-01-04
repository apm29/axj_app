import 'package:axj_app/generated/i18n.dart';
import 'package:axj_app/route/route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AuthDialogPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CupertinoAlertDialog(
      title: Text(S.of(context).notAuthTitle),
      actions: <Widget>[
        CupertinoButton(
            child: Text(S.of(context).notNowAuthLabel),
            onPressed: () {
              Navigator.of(context).pop(false);
            }),
        CupertinoButton(
            child: Text(S.of(context).toAuthHint),
            onPressed: () {
              () async {
                var navigatorState = Navigator.of(context);
                var authResult = await AppRouter.toAuthForm(context);
                navigatorState.pop(authResult);
              }();
            }),
      ],
    );
  }
}
