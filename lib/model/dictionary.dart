import 'package:axj_app/model/api.dart';
import 'package:axj_app/model/bean/district_info.dart';
import 'package:axj_app/model/bean/house_info.dart';
import 'package:axj_app/model/cache.dart';
import 'package:axj_app/model/repository.dart';

class Dictionary {
  //所有小区字典
  List<DistrictInfo> districtDictionary = [];

  bool get authorized => null;

  @override
  String toString() {
    return 'Dictionary{districtDictionary: $districtDictionary}';
  }

  //字典初始化,在登录成功或者已登录进入App时初始化
  //需要缓存的token不为空
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
      myHouseMap.clear();
      for (DistrictInfo districtInfo in myDistrictList) {
        BaseResp<List<HouseInfo>> houseResp =
            await Repository.getMyHouseList(districtInfo.districtId);
        if (houseResp.success) {
          myHouseMap[districtInfo] = houseResp.data;
        }
      }
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
  Map<DistrictInfo, List<HouseInfo>> myHouseMap = {};

  //获取房子信息
  HouseInfo defaultHouseInfo(houseId) {
    if (myHouseMap.isEmpty) {
      throw NotInitializedException("房屋字典未初始化");
    }
    for (List list in myHouseMap.values) {
      HouseInfo houseInfo = list.firstWhere(
          (h) => h.houseId.toString() == houseId.toString(),
          orElse: () => null);
      if (houseInfo != null) {
        return houseInfo;
      }
    }
    //单个房子直接返回房子
    if (houseId == null &&
        myHouseMap.length == 1 &&
        myHouseMap.values.first.length == 1) {
      return myHouseMap.values.first.first;
    }
    return null;
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
