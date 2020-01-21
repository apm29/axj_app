
class Comment {

  String nickName;
  String time;
  String userName;
  String content;

	Comment.fromJsonMap(Map<String, dynamic> map):
		nickName = map["nickName"],
		time = map["time"],
		userName = map["userName"],
		content = map["content"];

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['nickName'] = nickName;
		data['time'] = time;
		data['userName'] = userName;
		data['content'] = content;
		return data;
	}
}
