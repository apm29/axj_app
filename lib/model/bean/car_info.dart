import 'package:axj_app/model/bean/car.dart';

class CarInfo {

  List<Car> rows;
  int total;
  int totalIn;

	CarInfo.fromJsonMap(Map<String, dynamic> map): 
		rows = List<Car>.from(map["rows"].map((it) => Car.fromJsonMap(it))),
		total = map["total"],
		totalIn = map["totalIn"];

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['rows'] = rows != null ? 
			this.rows.map((v) => v.toJson()).toList()
			: null;
		data['total'] = total;
		data['totalIn'] = totalIn;
		return data;
	}

	@override
	String toString() {
		return 'CarInfo{rows: $rows, total: $total, totalIn: $totalIn}';
	}


}
