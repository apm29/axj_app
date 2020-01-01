
class Children {

  int menuId;
  String menuName;
  String url;
  int parentId;
  int sort;

	Children.fromJsonMap(Map<String, dynamic> map):
		menuId = map["menuId"],
		menuName = map["menuName"],
		url = map["url"],
		parentId = map["parentId"],
		sort = map["sort"];

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['menuId'] = menuId;
		data['menuName'] = menuName;
		data['url'] = url;
		data['parentId'] = parentId;
		data['sort'] = sort;
		return data;
	}

	@override
	String toString() {
		return 'Children{menuId: $menuId, menuName: $menuName, url: $url, parentId: $parentId, sort: $sort}';
	}



}
