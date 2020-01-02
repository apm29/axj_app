class Roles {
  ///物业人员 1
  ///有房认证用户 2
  ///民警 3
  ///无房认证用户 4
  ///家庭成员 5
  ///无认证用户 6
  String roleCode;
  String roleName;

  Roles.fromJsonMap(Map<String, dynamic> map)
      : roleCode = map["roleCode"],
        roleName = map["roleName"];

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['roleCode'] = roleCode;
    data['roleName'] = roleName;
    return data;
  }

  @override
  String toString() {
    return 'Roles{roleCode: $roleCode, roleName: $roleName}';
  }

  bool get hasHouse => roleCode == "2" || roleCode == "5";
}
