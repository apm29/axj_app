import 'package:axj_app/model/bean/house.dart';

///
///人脸认证/certification/userVerify 接口返回的结果信息
///
class UserVerifyInfo {
  List<House> rows;

  UserVerifyInfo({this.rows});

  UserVerifyInfo.fromJson(Map<String, dynamic> json) {
    if (json['rows'] != null) {
      rows = new List<House>();
      json['rows'].forEach((v) {
        rows.add( House.fromJsonMap(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.rows != null) {
      data['rows'] = this.rows.map((v) => v.toJson()).toList();
    }
    return data;
  }
}