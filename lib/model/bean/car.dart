
class Car {

  int carId;
  int isVisitor;
  String licencePlate;
  String status;
  String userid;
  String username;
  String vehicleType;

	Car.fromJsonMap(Map<String, dynamic> map): 
		carId = map["carId"],
		isVisitor = map["isVisitor"],
		licencePlate = map["licencePlate"],
		status = map["status"],
		userid = map["userid"],
		username = map["username"],
		vehicleType = map["vehicleType"];

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['carId'] = carId;
		data['isVisitor'] = isVisitor;
		data['licencePlate'] = licencePlate;
		data['status'] = status;
		data['userid'] = userid;
		data['username'] = username;
		data['vehicleType'] = vehicleType;
		return data;
	}

	@override
	String toString() {
		return 'Car{carId: $carId, isVisitor: $isVisitor, licencePlate: $licencePlate, status: $status, userid: $userid, username: $username, vehicleType: $vehicleType}';
	}


}
