import 'package:permission_handler/permission_handler.dart';

class Permissions {
  static Future<bool> has(PermissionGroup permissionGroup) async {
    var handler = PermissionHandler();
    PermissionStatus permissionStatus =
        await handler.checkPermissionStatus(permissionGroup);

    if (permissionStatus == PermissionStatus.granted) {
      return true;
    }
    Map<PermissionGroup, PermissionStatus> result =
        await handler.requestPermissions([permissionGroup]);
    if (result[permissionGroup] == PermissionStatus.granted) {
      return true;
    } else {
      return false;
    }
  }
}
