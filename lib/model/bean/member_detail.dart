import 'package:axj_app/model/bean/family_member.dart';

class MemberDetail {

  List<FamilyMember> familyMember;
  List<FamilyMember> tenant;

	MemberDetail.fromJsonMap(Map<String, dynamic> map): 
		familyMember = List<FamilyMember>.from(map["familyMember"].map((it) => FamilyMember.fromJsonMap(it))),
		tenant =  List<FamilyMember>.from(map["tenant"].map((it) => FamilyMember.fromJsonMap(it)));

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['familyMember'] = familyMember != null ? 
			this.familyMember.map((v) => v.toJson()).toList()
			: null;
		data['tenant'] =  tenant != null ?
		this.tenant.map((v) => v.toJson()).toList()
				: null;
		return data;
	}
}
