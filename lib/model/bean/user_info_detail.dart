import 'package:axj_app/model/bean/house.dart';
import 'package:axj_app/model/bean/roles.dart';
import 'package:axj_app/model/bean/menus.dart';

class UserInfoDetail {
  String userId;
  String userName;
  String mobile;
  int isCertification;
  String myName;
  String sex;
  String nickName;
  String avatar;
  String idCard;
  List<House> house;
  List<Roles> roles;
  List<Menus> menus;

  UserInfoDetail.fromJsonMap(Map<String, dynamic> map)
      : userId = map["userId"],
        userName = map["userName"],
        mobile = map["mobile"],
        isCertification = map["isCertification"],
        myName = map["myName"],
        sex = map["sex"],
        nickName = map["nickName"],
        avatar = map["avatar"],
        idCard = map["idCard"],
        house =
            List<House>.from(map["house"].map((it) => House.fromJsonMap(it))),
        roles =
            List<Roles>.from(map["roles"].map((it) => Roles.fromJsonMap(it))),
        menus =
            List<Menus>.from(map["menus"].map((it) => Menus.fromJsonMap(it)));

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
    data['house'] =
        house != null ? this.house.map((v) => v.toJson()).toList() : null;
    data['roles'] =
        roles != null ? this.roles.map((v) => v.toJson()).toList() : null;
    data['menus'] =
        menus != null ? this.menus.map((v) => v.toJson()).toList() : null;
    return data;
  }

  @override
  String toString() {
    return 'UserInfoDetail{userId: $userId, userName: $userName, mobile: $mobile, isCertification: $isCertification, myName: $myName, sex: $sex, nickName: $nickName, avatar: $avatar, idCard: $idCard, house: $house, roles: $roles, menus: $menus}';
  }

}
