import 'package:axj_app/model/bean/basic/paged_data.dart';
import 'package:axj_app/model/bean/visitor/visitor_record.dart';

class PagedVisitorRecord implements PagedData<VisitorRecord> {

  int total;
  List<VisitorRecord> rows;

	PagedVisitorRecord.fromJsonMap(Map<String, dynamic> map): 
		total = map["total"],
		rows = List<VisitorRecord>.from(map["rows"].map((it) => VisitorRecord.fromJsonMap(it)));

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['total'] = total;
		data['rows'] = rows != null ? 
			this.rows.map((v) => v.toJson()).toList()
			: null;
		return data;
	}

	@override
	String toString() {
		return 'PagedVisitorRecord{total: $total, rows: $rows}';
	}


}
