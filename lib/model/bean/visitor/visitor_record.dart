
class VisitorRecord {

  int id;
  String personid;
  String checktype;
  int familyid;
  int districtid;
  String occurtime;
  int actiontype;
  String inserttime;
  String updatetime;
  String doorno;
  int persontype;
  Object personname;
  String imageurl;

	VisitorRecord.fromJsonMap(Map<String, dynamic> map):
		id = map["id"],
		personid = map["personid"],
		checktype = map["checktype"],
		familyid = map["familyid"],
		districtid = map["districtid"],
		occurtime = map["occurtime"],
		actiontype = map["actiontype"],
		inserttime = map["inserttime"],
		updatetime = map["updatetime"],
		doorno = map["doorno"],
		persontype = map["persontype"],
		personname = map["personname"],
		imageurl = map["imageurl"];

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['id'] = id;
		data['personid'] = personid;
		data['checktype'] = checktype;
		data['familyid'] = familyid;
		data['districtid'] = districtid;
		data['occurtime'] = occurtime;
		data['actiontype'] = actiontype;
		data['inserttime'] = inserttime;
		data['updatetime'] = updatetime;
		data['doorno'] = doorno;
		data['persontype'] = persontype;
		data['personname'] = personname;
		data['imageurl'] = imageurl;
		return data;
	}

	@override
	String toString() {
		return 'VisitorRecord{id: $id, personid: $personid, checktype: $checktype, familyid: $familyid, districtid: $districtid, occurtime: $occurtime, actiontype: $actiontype, inserttime: $inserttime, updatetime: $updatetime, doorno: $doorno, persontype: $persontype, personname: $personname, imageurl: $imageurl}';
	}

	String  get actionString=>actiontype==2?'进':'出';

}
