
class Roles {

  String roleCode;
  String roleName;

	Roles.fromJsonMap(Map<String, dynamic> map): 
		roleCode = map["roleCode"],
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


}
