import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

class Permissions {
  static Future<bool> has(
      PermissionGroup permissionGroup, BuildContext context) async {
    var handler = PermissionHandler();
    PermissionStatus permissionStatus =
        await handler.checkPermissionStatus(permissionGroup);

    if (permissionStatus == PermissionStatus.granted) {
      return true;
    }
    Map<PermissionGroup, PermissionStatus> result =
        await handler.requestPermissions([permissionGroup]);
    var status = result[permissionGroup];
    if (status == PermissionStatus.granted) {
      return true;
    } else {
      if (status == PermissionStatus.denied || await handler.shouldShowRequestPermissionRationale(permissionGroup)) {
        bool opened =
            await showDialog(context: context, child: PermissionDeniedDialog());
        if (opened) {
          await Future.delayed(Duration(seconds: 2));
          var status2 = await handler.checkPermissionStatus(permissionGroup);
          return (status2) ==
              PermissionStatus.granted;
        }
      }
      return false;
    }
  }
}

class PermissionDeniedDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CupertinoAlertDialog(
      title: Text("权限被拒"),
      content: Text("请到设置中心开启App运行的必要权限"),
      actions: <Widget>[
        CupertinoButton(
          child: Text("取消"),
          onPressed: () {
            Navigator.of(context).pop(false);
          },
        ),
        CupertinoButton(
          child: Text("好的"),
          onPressed: () {
            () async {
              bool opened = await PermissionHandler().openAppSettings();
              Navigator.of(context).pop(opened);
            }();
          },
        ),
      ],
    );
  }
}
