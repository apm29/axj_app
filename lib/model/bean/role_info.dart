///getUserInfo返回的只有roleCode和roleName
///findUserRole返回的只有roleCode/id/userId
class RoleInfo {
  ///物业人员 1
  ///有房认证用户 2
  ///民警 3
  ///无房认证用户 4
  ///家庭成员 5
  ///无认证用户 6
  String roleCode;
  String _roleName;

  RoleInfo.fromJsonMap(Map<String, dynamic> map)
      : roleCode = map["roleCode"],
        _roleName = map["roleName"],
        id = map["id"],
        userId = map["userId"];

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['roleCode'] = roleCode;
    data['roleName'] = _roleName;
    data['id'] = id;
    data['userId'] = userId;
    return data;
  }

  @override
  String toString() {
    return 'RoleInfo{roleCode: $roleCode, roleName: $roleName, id: $id, userId: $userId}';
  }

  bool get hasHouse => roleCode == "2" || roleCode == "5";

  ///[Repository]findUserRole方法新增的2个字段
  int id;
  String userId;

  String get roleName {
    return _roleName ?? roleNameByDict;
  }

  String get roleNameByDict {
    switch (roleCode) {
      case "1":
        return "物业人员";
      case "3":
        return "民警";
      default:
        return "普通用户";
    }
  }
}
