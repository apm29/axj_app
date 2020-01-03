import 'package:axj_app/model/api.dart';
import 'package:axj_app/model/bean/district_info.dart';
import 'package:axj_app/model/repository.dart';

class Dictionary {
  List<DistrictInfo> districtDictionary = [];

  @override
  String toString() {
    return 'Dictionary{districtDictionary: $districtDictionary}';
  }

  init() async {
    BaseResp<List<DistrictInfo>> resp = await Repository.getDistrictInfo();
    if (resp.success) {
      districtDictionary = resp.data;
    }
  }
}
