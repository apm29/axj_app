
class VisitRecord {

  String visitorName;
  String visitorAvatar;
  String enterTime;

	VisitRecord.fromJsonMap(Map<String, dynamic> map): 
		visitorName = map["visitorName"],
		visitorAvatar = map["visitorAvatar"],
		enterTime = map["enterTime"];

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['visitorName'] = visitorName;
		data['visitorAvatar'] = visitorAvatar;
		data['enterTime'] = enterTime;
		return data;
	}
}
