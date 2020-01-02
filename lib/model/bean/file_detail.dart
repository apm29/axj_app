
class FileDetail {

  String filePath;

	FileDetail.fromJsonMap(Map<String, dynamic> map): 
		filePath = map["filePath"];

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['filePath'] = filePath;
		return data;
	}
}
