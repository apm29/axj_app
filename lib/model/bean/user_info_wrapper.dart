import 'package:axj_app/model/bean/user_info.dart';

class UserInfoWrapper {

  UserInfo userInfo;

	UserInfoWrapper.fromJsonMap(Map<String, dynamic> map):
		userInfo = UserInfo.fromJsonMap(map["userInfo"]);

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['userInfo'] = userInfo == null ? null : userInfo.toJson();
		return data;
	}
}
