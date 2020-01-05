import 'dart:io';

import 'package:axj_app/model/api.dart';
import 'package:axj_app/model/bean/district_info.dart';
import 'package:axj_app/model/bean/family_member.dart';
import 'package:axj_app/model/bean/file_detail.dart';
import 'package:axj_app/model/bean/house_info.dart';
import 'package:axj_app/model/bean/member_detail.dart';
import 'package:axj_app/model/bean/roles.dart';
import 'package:axj_app/model/bean/user_info_detail.dart';
import 'package:axj_app/model/bean/user_verify_info.dart';
import 'package:dio/dio.dart';

class Repository {
  static Future<BaseResp> login(String userName, String password) {
    return Api().get(
      "/permission/login",
      queryMap: {"userName": userName, "password": password},
      processor: (s) {
        return null;
      },
    );
  }

  static Future<BaseResp> sendVerifyCode(String mobile, {isRegister: false}) {
    return Api().post(
      "/permission/user/getVerifyCode",
      formData: {"mobile": mobile, "type": isRegister ? 0 : 1},
      processor: (s) {
        return null;
      },
    );
  }

  static Future<BaseResp> fastLogin(String mobile, String verifyCode) {
    return Api().get(
      "/permission/fastLogin",
      queryMap: {"mobile": mobile, "verifyCode": verifyCode},
      processor: (s) {
        return null;
      },
    );
  }

  static Future<BaseResp<UserInfoDetail>> getUserInfo() {
    return Api().post(
      "/permission/user/getUserInfo",
      processor: (s) {
        return UserInfoDetail.fromJsonMap(s);
      },
    );
  }

  static Future<BaseResp> register(
      String mobile, String smsCode, String password, String userName) {
    return Api().post(
      "/permission/user/register",
      processor: (s) => null,
      formData: {
        "userName": userName,
        "mobile": mobile,
        "password": password,
        "code": smsCode,
      },
    );
  }

  //通过token获取当前用户的角色列表
  static Future<BaseResp<List<Roles>>> findUserRoles() {
    return Api().post(
      "/permission/UserRole/findUserRole",
      processor: (json) {
        if (json is List) {
          return json.map((j) {
            return Roles.fromJsonMap(j);
          }).toList();
        }
        return [];
      },
    );
  }

  static Future<BaseResp<FileDetail>> uploadFile(File file,
      {ProgressCallback onSendProgress}) async {
    var formData = FormData();
    formData.files.addAll([
      MapEntry(
        "file",
        MultipartFile.fromFileSync(file.path),
      ),
    ]);
    return Api().upload<FileDetail>(
      "/business/upload/uploadFile",
      formData: formData,
      processor: (s) => FileDetail.fromJsonMap(s),
      onSendProgress: onSendProgress,
    );
  }

  static Future<BaseResp<UserVerifyInfo>> verify(
      String imageUrl, String idCard, bool isAgain) async {
    return Api().post(
      "/permission/userCertification/verify",
      processor: (j) {
        return UserVerifyInfo.fromJson(j);
      },
      formData: {
        "photo": imageUrl,
        "idCard": idCard,
        "isAgain": isAgain ? 1 : 0,
      },
    );
  }

  static Future<BaseResp<List<DistrictInfo>>> getDistrictInfo() {
    return Api().post(
      "/business/district/findDistrictInfo",
      processor: (s) {
        if (s is List) {
          return s.map((json) => DistrictInfo.fromJsonMap(json)).toList();
        }
        return [];
      },
    );
  }

  static Future<BaseResp<List<DistrictInfo>>> getMyDistrictInfo() {
    return Api().post(
      "/business/district/findMyDistrictInfo",
      processor: (s) {
        if (s is List) {
          return s.map((json) => DistrictInfo.fromJsonMap(json)).toList();
        }
        return [];
      },
    );
  }

  static Future<BaseResp<List<HouseInfo>>> getMyHouseList(districtId) {
    return Api().post(
      "/business/houseInfo/getMyHouse",
      formData: {'districtId': districtId},
      processor: (s) {
        if (s is List) {
          return s.map((json) => HouseInfo.fromJsonMap(json)).toList();
        }
        return [];
      },
    );
  }

  static Future<BaseResp<MemberDetail>> getFamilyMembers(houseId) {
    return Api().post(
      "/business/member/getFamilyMember",
      formData: {'familyId': houseId},
      processor: (s) {
        return MemberDetail.fromJsonMap(s);
      },
    );
  }

  static Future<BaseResp> deleteFamilyMembers(memberId) {
    return Api().post(
      "/business/member/deleteMember",
      formData: {'memberId': memberId},
      processor: (s) {
        return null;
      },
    );
  }

  static Future<BaseResp<FamilyMember>> getFamilyMemberDetail(
      dynamic memberId) {
    return Api().post(
      "/business/member/getMemberInfo",
      formData: {'memberId': memberId.toString()},
      processor: (s) {
        return FamilyMember.fromJsonMap(s);
      },
    );
  }

  static Future<BaseResp> updateMemberInfo({
    dynamic memberId,
    String memberName,
    String memberPhone,
    String relationType,
    String idNo,
    String memberPicUrl,
    String isShare,
  }) {
    return Api().post(
      "/business/member/updateMember",
      formData: {
        'memberId': memberId.toString(),
        "memberName": memberName,
        "memberPhone": memberPhone,
        "relationType": relationType,
        "memberPicUrl": memberPicUrl,
        "idNo": idNo,
        "isShare": isShare,
      },
      processor: (s) {
        return null;
      },
    );
  }

  static Future<BaseResp> addMemberInfo({
    String memberName,
    String memberPhone,
    String relationType,
    String idNo,
    String memberPicUrl,
    String isShare,
  }) {
    return Api().post(
      "/business/member/addMember",
      formData: {
        "memberName": memberName,
        "memberPhone": memberPhone,
        "relationType": relationType,
        "memberPicUrl": memberPicUrl,
        "idNo": idNo,
        "isShare": isShare,
      },
      processor: (s) {
        return null;
      },
    );
  }
}
