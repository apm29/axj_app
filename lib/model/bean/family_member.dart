class FamilyMember {


  int memberid;
  String userid;
  String membername;
  String memberpicurl;
  String memberphone;
  int memberstatus;
  String relationtype;
  String createtime;
  int familyid;
  String inserttime;
  String updatetime;
  int communityid;
  String idno;
  int isOwner;
  int isAuth;
  Object addUid;
  int isShare;
  int edit;
  int del;
  int examine;

  String get presentStatue => memberstatus == 1 ? "外出" : "在家";

  bool get editable => edit == 1;

  bool get deletable => del == 1;

  bool get examinable => examine == 1;

  bool get share => isShare == 1;

  FamilyMember.fromJsonMap(Map<String, dynamic> map)
      : memberid = map["memberid"],
        userid = map["userid"],
        membername = map["membername"],
        memberpicurl = map["memberpicurl"],
        memberphone = map["memberphone"],
        memberstatus = map["memberstatus"],
        relationtype = map["relationtype"],
        createtime = map["createtime"],
        familyid = map["familyid"],
        inserttime = map["inserttime"],
        updatetime = map["updatetime"],
        communityid = map["communityid"],
        idno = map["idno"],
        isOwner = map["isOwner"],
        isAuth = map["isAuth"],
        addUid = map["addUid"],
        isShare = map["isShare"],
        edit = map["edit"],
        del = map["del"],
        examine = map["examine"];

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['memberid'] = memberid;
    data['userid'] = userid;
    data['membername'] = membername;
    data['memberpicurl'] = memberpicurl;
    data['memberphone'] = memberphone;
    data['memberstatus'] = memberstatus;
    data['relationtype'] = relationtype;
    data['createtime'] = createtime;
    data['familyid'] = familyid;
    data['inserttime'] = inserttime;
    data['updatetime'] = updatetime;
    data['communityid'] = communityid;
    data['idno'] = idno;
    data['isOwner'] = isOwner;
    data['isAuth'] = isAuth;
    data['addUid'] = addUid;
    data['isShare'] = isShare;
    data['edit'] = edit;
    data['del'] = del;
    data['examine'] = examine;
    return data;
  }

  FamilyMember({this.memberid, this.userid, this.membername, this.memberpicurl,
    this.memberphone, this.memberstatus, this.relationtype, this.createtime,
    this.familyid, this.inserttime, this.updatetime, this.communityid,
    this.idno, this.isOwner, this.isAuth, this.addUid, this.isShare,
    this.edit, this.del, this.examine});
}
