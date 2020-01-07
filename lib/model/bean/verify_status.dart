
class VerifyStatus {

  int code;

	VerifyStatus.fromJsonMap(Map<String, dynamic> map): 
		code = map["code"];

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['code'] = code;
		return data;
	}

	String get desc {
		switch (code) {
			case 0:
				return "未认证";
			case 1:
				return "名下有房,人脸认证中";
			case 2:
				return "名下无房,人脸认证中";
			case 3:
				return "名下有房,人脸认证成功";
			case 4:
				return "名下无房,人脸认证成功";
			case 5:
				return "人脸认证失败";
			case 6:
				return "人脸认证失败";
			default:
				return null;
		}
	}

	bool get hasHouse{
		return code == 1 || code == 3 || code == 5;
	}

	bool get isVerified {
		return code == 3 || code == 4;
	}

	bool get isInVerify {
		return code == 1 || code == 2;
	}

	String get verifyText{
		String text;
		switch (code) {
			case 0:
				text = "未认证";
				break;
			case 1:
				text = "认证中";
				break;
			case 2:
				text = "认证中";
				break;
			case 3:
				text = "已认证";
				break;
			case 4:
				text = "已认证";
				break;
			case 5:
				text = "认证失败";
				break;
			case 6:
				text = "认证失败";
				break;
			default:
				text = "未认证";
				break;
		}
		return text;
	}

}
