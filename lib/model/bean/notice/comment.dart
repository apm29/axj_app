import 'package:axj_app/model/bean/notice/comment_detail.dart';

class CommentData {
  List<Comment> all;
  List<Comment> my;

  CommentData.fromJsonMap(Map<String, dynamic> map) {
    all = map["ALL"] == null
        ? []
        : List<Comment>.from(map["ALL"].map((it) => Comment.fromJsonMap(it)));
    my = map["MY"] == null
        ? []
        : List<Comment>.from(map["MY"].map((it) => Comment.fromJsonMap(it)));
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ALL'] = all != null ? this.all.map((v) => v.toJson()).toList() : null;
    data['MY'] = my != null ? this.my.map((v) => v.toJson()).toList() : null;
    return data;
  }

  @override
  String toString() {
    return 'CommentData{all: $all, my: $my}';
  }
}

class CommentDataSummary{
  String noticeId;
  CommentData comment;

  CommentDataSummary.fromJsonMap(Map<String, dynamic> map) {
    noticeId = map["noticeId"].toString();
    comment = CommentData.fromJsonMap(map["comment"]);
  }
}
