
class DistrictInfo {

  int districtId;
  String districtName;
  String districtInfo;
  String districtAddr;
  String districtPic;
  int companyId;
  int orderNo;


	DistrictInfo({this.districtId, this.districtName, this.districtInfo,
			this.districtAddr, this.districtPic, this.companyId, this.orderNo});

	DistrictInfo.fromJsonMap(Map<String, dynamic> map):
		districtId = map["districtId"],
		districtName = map["districtName"],
		districtInfo = map["districtInfo"],
		districtAddr = map["districtAddr"],
		districtPic = map["districtPic"],
		companyId = map["companyId"],
		orderNo = map["orderNo"];

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['districtId'] = districtId;
		data['districtName'] = districtName;
		data['districtInfo'] = districtInfo;
		data['districtAddr'] = districtAddr;
		data['districtPic'] = districtPic;
		data['companyId'] = companyId;
		data['orderNo'] = orderNo;
		return data;
	}

	@override
	String toString() {
		return 'DistrictInfo{districtId: $districtId, districtName: $districtName, districtInfo: $districtInfo, districtAddr: $districtAddr, districtPic: $districtPic, companyId: $companyId, orderNo: $orderNo}';
	}

	@override
	bool operator ==(Object other) =>
			identical(this, other) ||
					other is DistrictInfo &&
							runtimeType == other.runtimeType &&
							districtId == other.districtId &&
							districtName == other.districtName &&
							districtInfo == other.districtInfo &&
							districtAddr == other.districtAddr &&
							districtPic == other.districtPic &&
							companyId == other.companyId &&
							orderNo == other.orderNo;

	@override
	int get hashCode =>
			districtId.hashCode ^
			districtName.hashCode ^
			districtInfo.hashCode ^
			districtAddr.hashCode ^
			districtPic.hashCode ^
			companyId.hashCode ^
			orderNo.hashCode;





}
