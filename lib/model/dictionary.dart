import 'package:axj_app/model/api.dart';
import 'package:axj_app/model/bean/district_info.dart';
import 'package:axj_app/model/bean/house_info.dart';
import 'package:axj_app/model/repository.dart';

class Settings {
  List<DistrictInfo> districtDictionary = [];

  bool get authorized => null;

  @override
  String toString() {
    return 'Dictionary{districtDictionary: $districtDictionary}';
  }

  Future<void> init() async {
    BaseResp<List<DistrictInfo>> resp = await Repository.getDistrictInfo();
    if (resp.success) {
      districtDictionary = resp.data;
    }

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

  DistrictInfo getDistrictInfo(String districtId) {
    return districtDictionary.firstWhere(
        (d) => d.districtId.toString() == districtId,
        orElse: () => unknownDistrict);
  }

  final DistrictInfo unknownDistrict =
      DistrictInfo(districtName: "Unknown", districtAddr: "Unknown");

  List<DistrictInfo> myDistrictList = [];

  Map<DistrictInfo, List<HouseInfo>> myHouseMap = {};

  HouseInfo defaultHouseInfo(houseId) {
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
