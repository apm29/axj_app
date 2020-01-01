
class House {

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

	House.fromJsonMap(Map<String, dynamic> map): 
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

	@override
	String toString() {
		return 'House{id: $id, houseId: $houseId, districtId: $districtId, building: $building, unit: $unit, house: $house, addr: $addr, phone: $phone, idcard: $idcard, name: $name, userId: $userId, passCode: $passCode, isOwner: $isOwner}';
	}


}
