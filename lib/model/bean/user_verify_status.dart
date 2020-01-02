class UserVerifyStatus {
  ///
  /// code 0 未认证
  /// code 1 有房认证中
  /// code 2 无房认证中
  /// code 3 有房认证成功
  /// code 4 无房认证成功
  /// code 5 有房认证失败
  /// code 6 无房认证失败
  ///
  int code;

  String getDesc() {
    switch (code) {
      case 0:
        return "未认证";
      case 1:
        return "名下有房,\n人脸认证中";
      case 2:
        return "名下无房,\n人脸认证中";
      case 3:
        return "名下有房,\n人脸认证成功";
      case 4:
        return "名下无房,\n人脸认证成功";
      case 5:
        return "名下有房,\n人脸认证失败";
      case 6:
        return "名下无房,\n人脸认证失败";
      default:
        return null;
    }
  }

  UserVerifyStatus({this.code});

  UserVerifyStatus.fromJsonMap(Map<String, dynamic> json) {
    code = json['code'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code'] = this.code;
    return data;
  }

  bool get hasHouse {
    return code == 1 || code == 3 || code == 5;
  }

  bool get isVerified {
    return code == 3 || code == 4;
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

  @override
  String toString() {
    return '{"code": $code  ${getDesc()}}';
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          other is UserVerifyStatus &&
              runtimeType == other.runtimeType &&
              code == other.code;

  @override
  int get hashCode => code.hashCode;
}