import 'package:axj_app/model/bean/children.dart';

class Menus {

  int menuId;
  String menuName;
  String url;
  int parentId;
  int sort;
  List<Children> chilren;

	Menus.fromJsonMap(Map<String, dynamic> map): 
		menuId = map["menuId"],
		menuName = map["menuName"],
		url = map["url"],
		parentId = map["parentId"],
		sort = map["sort"],
		chilren = List<Children>.from(map["chilren"].map((it) => Children.fromJsonMap(it)));

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['menuId'] = menuId;
		data['menuName'] = menuName;
		data['url'] = url;
		data['parentId'] = parentId;
		data['sort'] = sort;
		data['chilren'] = chilren != null ? 
			this.chilren.map((v) => v.toJson()).toList()
			: null;
		return data;
	}

	@override
	String toString() {
		return 'Menus{menuId: $menuId, menuName: $menuName, url: $url, parentId: $parentId, sort: $sort, chilren: $chilren}';
	}


}
