
class UserInfo {

  String userId;
  String userName;
  String mobile;
  int isCertification;
  String myName;
  String sex;
  String nickName;
  String avatar;
  String idCard;

	UserInfo.fromJsonMap(Map<String, dynamic> map): 
		userId = map["userId"],
		userName = map["userName"],
		mobile = map["mobile"],
		isCertification = map["isCertification"],
		myName = map["myName"],
		sex = map["sex"],
		nickName = map["nickName"],
		avatar = map["avatar"],
		idCard = map["idCard"];

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['userId'] = userId;
		data['userName'] = userName;
		data['mobile'] = mobile;
		data['isCertification'] = isCertification;
		data['myName'] = myName;
		data['sex'] = sex;
		data['nickName'] = nickName;
		data['avatar'] = avatar;
		data['idCard'] = idCard;
		return data;
	}

	@override
	String toString() {
		return 'UserInfo{userId: $userId, userName: $userName, mobile: $mobile, isCertification: $isCertification, myName: $myName, sex: $sex, nickName: $nickName, avatar: $avatar, idCard: $idCard}';
	}


}
