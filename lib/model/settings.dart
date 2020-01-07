import 'package:axj_app/model/api.dart';
import 'package:axj_app/model/bean/district_info.dart';
import 'package:axj_app/model/bean/house_info.dart';
import 'package:axj_app/model/bean/role_info.dart';
import 'package:axj_app/model/bean/verify_status.dart';
import 'package:axj_app/model/cache.dart';
import 'package:axj_app/model/repository.dart';

class Settings {
  //所有小区字典
  List<DistrictInfo> districtDictionary = [];

  //根据接口信息确定
  bool get authorized => _verifyStatus?.isVerified ?? false;

  VerifyStatus _verifyStatus;

  List<RoleInfo> _userRoles = [];

  @override
  String toString() {
    return 'Settings{districtDictionary: $districtDictionary, unknownDistrict: $unknownDistrict, myDistrictList: $myDistrictList, myHouseMap: $_myHouseMap}';
  }

  ///字典初始化,在登录成功或者已登录进入App时初始化
  ///需要缓存的token不为空
  Future<void> init() async {
    var token = Cache().token;
    if (token == null || token.isEmpty) {
      throw NotInitializedException("字典初始化需要Token信息");
    }
    //获取小区字典
    BaseResp<List<DistrictInfo>> resp = await Repository.getDistrictInfo();
    if (resp.success) {
      districtDictionary = resp.data;
    }

    //获取我的小区
    BaseResp<List<DistrictInfo>> districtResp =
        await Repository.getMyDistrictInfo();
    if (districtResp.success) {
      myDistrictList = districtResp.data;
      _myHouseMap.clear();
      for (DistrictInfo districtInfo in myDistrictList) {
        BaseResp<List<HouseInfo>> houseResp =
            await Repository.getMyHouseList(districtInfo.districtId);
        if (houseResp.success) {
          _myHouseMap[districtInfo] = houseResp.data;
        }
      }
    }

    //获取认证信息
    BaseResp<VerifyStatus> verifyResp = await Repository.getVerifyStatus();
    if (verifyResp.success) {
      _verifyStatus = verifyResp.data;
    }

    //获取角色信息
    BaseResp<List<RoleInfo>> rolesResp = await Repository.findUserRoles();
    if (rolesResp.success) {
      _userRoles = rolesResp.data;
    }
  }

  //通过小区id获取小区信息
  DistrictInfo getDistrictInfo(String districtId) {
    return districtDictionary.firstWhere(
        (d) => d.districtId.toString() == districtId,
        orElse: () => unknownDistrict);
  }

  final DistrictInfo unknownDistrict =
      DistrictInfo(districtName: "Unknown", districtAddr: "Unknown");

  //我的小区
  List<DistrictInfo> myDistrictList = [];

  //我的小区-房屋映射
  Map<DistrictInfo, List<HouseInfo>> _myHouseMap = {};

  //获取房子信息
  HouseInfo get defaultHouseInfo {
    String houseId = Cache().currentHouseId;
    if (_myHouseMap.isEmpty) {
      throw NotInitializedException("房屋字典未初始化");
    }
    //单个房子直接返回房子
    if (houseId == null &&
        _myHouseMap.length == 1 &&
        _myHouseMap.values.first.length == 1) {
      return _myHouseMap.values.first.first;
    }
    for (List list in _myHouseMap.values) {
      HouseInfo houseInfo = list.firstWhere(
          (h) => h.houseId.toString() == houseId.toString(),
          orElse: () => null);
      if (houseInfo != null) {
        return houseInfo;
      }
    }
    return null;
  }

  RoleInfo get defaultUserRole {
    String houseId = Cache().currentRoleId;
    if (_userRoles.isEmpty) {
      throw NotInitializedException("角色信息未初始化");
    }
    //单个房子直接返回房子
    if (houseId == null && _userRoles.length == 1) {
      return _userRoles.first;
    }
    return _userRoles.firstWhere(
      (role) => role.roleCode == houseId,
      orElse: () => null,
    );
  }
}

class NotInitializedException implements Exception {
  NotInitializedException([this.message]);

  final String message;

  @override
  String toString() => 'NotInitializedException($message)';
}

class NotFoundException implements Exception {
  NotFoundException([this.message]);

  final String message;

  @override
  String toString() => 'NotFoundException($message)';
}
