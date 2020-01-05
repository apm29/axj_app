
class HouseInfo {

  int id;
  int houseId;
  String districtId;
  String building;
  String unit;
  String house;
  String addr;
  String phone;
  String idcard;
  String name;
  String userId;
  String passCode;
  int isOwner;


	HouseInfo({this.id, this.houseId, this.districtId, this.building, this.unit,
		this.house, this.addr, this.phone, this.idcard, this.name, this.userId,
		this.passCode, this.isOwner});

	HouseInfo.fromJsonMap(Map<String, dynamic> map):
		id = map["id"],
		houseId = map["houseId"],
		districtId = map["districtId"],
		building = map["building"],
		unit = map["unit"],
		house = map["house"],
		addr = map["addr"],
		phone = map["phone"],
		idcard = map["idcard"],
		name = map["name"],
		userId = map["userId"],
		passCode = map["passCode"],
		isOwner = map["isOwner"];

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['id'] = id;
		data['houseId'] = houseId;
		data['districtId'] = districtId;
		data['building'] = building;
		data['unit'] = unit;
		data['house'] = house;
		data['addr'] = addr;
		data['phone'] = phone;
		data['idcard'] = idcard;
		data['name'] = name;
		data['userId'] = userId;
		data['passCode'] = passCode;
		data['isOwner'] = isOwner;
		return data;
	}
}
