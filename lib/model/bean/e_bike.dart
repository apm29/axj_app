
class EBike {

  int id;
  String userId;
  String plateDecode;
  String createTime;

	EBike.fromJsonMap(Map<String, dynamic> map): 
		id = map["id"],
		userId = map["userId"],
		plateDecode = map["plateDecode"],
		createTime = map["createTime"];

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['id'] = id;
		data['userId'] = userId;
		data['plateDecode'] = plateDecode;
		data['createTime'] = createTime;
		return data;
	}

	@override
	String toString() {
		return 'EBike{id: $id, userId: $userId, plateDecode: $plateDecode, createTime: $createTime}';
	}

	String get eBilePlate=>'$plateDecode';


}
