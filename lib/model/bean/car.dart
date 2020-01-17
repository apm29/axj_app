class Car {
  int carId;
  int isVisitor;
  String licencePlate;
  String status;
  String userid;
  String username;
  String vehicleType;
  String vehicleBrand;

  Car.fromJsonMap(Map<String, dynamic> map)
      : carId = map["carId"],
        isVisitor = map["isVisitor"],
        licencePlate = map["licencePlate"],
        status = map["status"],
        userid = map["userid"],
        username = map["username"],
        vehicleType = map["vehicleType"],
        vehicleBrand = map["vehicleBrand"];

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['carId'] = carId;
    data['isVisitor'] = isVisitor;
    data['licencePlate'] = licencePlate;
    data['status'] = status;
    data['userid'] = userid;
    data['username'] = username;
    data['vehicleType'] = vehicleType;
    data['vehicleBrand'] = vehicleBrand;
    return data;
  }

  String get statusLabel => '#$status';

  String get vehicleTypeLabel => ' #$vehicleType';

  String get visitorLabel => '#${isVisitor == 0 ? '本人' : '访客'}车辆';

  bool get hasImage => vehicleBrand!=null && vehicleBrand.isNotEmpty;

  @override
  String toString() {
    return 'Car{carId: $carId, isVisitor: $isVisitor, licencePlate: $licencePlate, status: $status, userid: $userid, username: $username, vehicleType: $vehicleType, vehicleBrand: $vehicleBrand}';
  }


}
