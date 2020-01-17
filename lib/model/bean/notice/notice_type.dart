
class NoticeType {

  int typeId;
  int typeUid;
  String typeName;

	NoticeType.fromJsonMap(Map<String, dynamic> map): 
		typeId = map["typeId"],
		typeUid = map["typeUid"],
		typeName = map["typeName"];

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['typeId'] = typeId;
		data['typeUid'] = typeUid;
		data['typeName'] = typeName;
		return data;
	}
}
