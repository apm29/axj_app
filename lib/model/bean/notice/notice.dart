import 'package:axj_app/model/bean/notice/notice_type.dart';
import 'package:intl/intl.dart';

class Notice {
  int noticeId;
  String noticeTitle;
  String noticeContent;
  List<String> noticeBanner;
  int noticeType;
  String noticeScope;
  int districtId;
  String userId;
  int companyId;
  String userName;
  Object nickName;
  String companyName;
  String createTime;
  Object orderNo;
  int likeNum;
  int commentNum;
  Object shareNum;
  int isLike;

  List<NoticeType> types;

  Notice.fromJsonMap(Map<String, dynamic> map)
      : noticeId = map["noticeId"],
        noticeTitle = map["noticeTitle"],
        noticeContent = map["noticeContent"],
        noticeBanner = List<String>.from(map["noticeBanner"]),
        noticeType = map["noticeType"],
        noticeScope = map["noticeScope"],
        districtId = map["districtId"],
        userId = map["userId"],
        companyId = map["companyId"],
        userName = map["userName"],
        nickName = map["nickName"],
        companyName = map["companyName"],
        createTime = map["createTime"],
        orderNo = map["orderNo"],
        likeNum = map["likeNum"],
        commentNum = map["commentNum"],
        shareNum = map["shareNum"],
        isLike = map["isLike"];

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['noticeId'] = noticeId;
    data['noticeTitle'] = noticeTitle;
    data['noticeContent'] = noticeContent;
    data['noticeBanner'] = noticeBanner;
    data['noticeType'] = noticeType;
    data['noticeScope'] = noticeScope;
    data['districtId'] = districtId;
    data['userId'] = userId;
    data['companyId'] = companyId;
    data['userName'] = userName;
    data['nickName'] = nickName;
    data['companyName'] = companyName;
    data['createTime'] = createTime;
    data['orderNo'] = orderNo;
    data['likeNum'] = likeNum;
    data['commentNum'] = commentNum;
    data['shareNum'] = shareNum;
    data['isLike'] = isLike;
    return data;
  }

  int get summaryCount => hasImage ? 60 : 100;

  String get contentSummary =>
      (noticeContent.length > summaryCount
          ? noticeContent.substring(0, summaryCount)
          : noticeContent) +
      '...';

  bool get hasImage =>
      noticeBanner.isNotEmpty && noticeBanner.any((src) => src.isNotEmpty);

  String get firstImage => noticeBanner.firstWhere((src) => src.isNotEmpty);

  DateFormat get dateFormat => DateFormat("yyyy年MM月dd日 HH:mm:ss");

  String get formattedCreatedTime =>
      dateFormat.format(DateTime.tryParse(createTime).toLocal());

  @override
  String toString() {
    return 'Notice{noticeId: $noticeId, noticeTitle: $noticeTitle, noticeContent: $noticeContent, noticeBanner: $noticeBanner, noticeType: $noticeType, noticeScope: $noticeScope, districtId: $districtId, userId: $userId, companyId: $companyId, userName: $userName, nickName: $nickName, companyName: $companyName, createTime: $createTime, orderNo: $orderNo, likeNum: $likeNum, commentNum: $commentNum, shareNum: $shareNum, isLike: $isLike, types: $types}';
  }

  String get hashTags=>'\t#'+types.firstWhere((t)=>t.typeId==noticeType)
      .typeName;
}
