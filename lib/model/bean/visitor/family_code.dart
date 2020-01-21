
class FamilyCode {

  String passCode;
  String houseAddress;

	FamilyCode.fromJsonMap(Map<String, dynamic> map): 
		passCode = map["passCode"],
		houseAddress = map["houseAddress"];

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['passCode'] = passCode;
		data['houseAddress'] = houseAddress;
		return data;
	}

	@override
	String toString() {
		return 'FamilyCode{passCode: $passCode, houseAddress: $houseAddress}';
	}


}
