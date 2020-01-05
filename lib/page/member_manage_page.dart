import 'package:axj_app/generated/i18n.dart';
import 'package:axj_app/model/api.dart';
import 'package:axj_app/model/bean/enum_config.dart';
import 'package:axj_app/model/bean/family_member.dart';
import 'package:axj_app/model/bean/member_detail.dart';
import 'package:axj_app/model/repository.dart';
import 'package:axj_app/page/component/future_task_widget.dart';
import 'package:axj_app/page/component/speed_dial.dart';
import 'package:axj_app/page/modal/task_modal.dart';
import 'package:axj_app/route/route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:oktoast/oktoast.dart';

class MemberManagePage extends StatefulWidget {
  final houseId;

  const MemberManagePage({Key key, this.houseId}) : super(key: key);

  @override
  _MemberManagePageState createState() => _MemberManagePageState();
}

class _MemberManagePageState extends State<MemberManagePage> {
  Future<BaseResp<MemberDetail>> future;

  @override
  void initState() {
    loadMemberData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("成员管理"),
      ),
      body: BaseRespTaskBuilder<MemberDetail>(
        future: future,
        modelBuilder: (context, list) {
          return ListView.builder(
            itemBuilder: (context, index) {
              List allData = [...list.familyMember, ...list.tenant];
              var familyMember = allData[index];
              return ListTile(
                leading: CircleAvatar(
                  backgroundImage: NetworkImage(familyMember.memberpicurl),
                  radius: 30,
                ),
                onTap: () => _onExamine(familyMember),
                isThreeLine: true,
                title: Text(familyMember.membername),
                subtitle: Text(familyMember.presentStatue +
                    "\r\n" +
                    familyMember.relationtype),
                trailing: PopupMenuButton<ActionEnum>(
                  itemBuilder: (context) {
                    return [
                      PopupMenuItem(
                        enabled: familyMember.editable,
                        child: Row(
                          children: <Widget>[
                            Icon(
                              Icons.edit,
                            ),
                            Text('编辑'),
                          ],
                        ),
                        value: ActionEnum.Edit,
                      ),
                      PopupMenuItem(
                        enabled: familyMember.deletable,
                        child: Row(
                          children: <Widget>[
                            Icon(
                              Icons.delete,
                            ),
                            Text('删除'),
                          ],
                        ),
                        value: ActionEnum.Delete,
                      ),
                    ];
                  },
                  onSelected: (v) {
                    switch (v) {
                      case ActionEnum.Edit:
                        _doEditMember(context, familyMember);
                        break;
                      case ActionEnum.Delete:
                        _doDeleteMember(context, familyMember);
                        break;
                      case ActionEnum.Examine:
                        break;
                    }
                  },
                  icon: Icon(Icons.more_vert),
                ),
              );
            },
            itemCount: list.familyMember.length + list.tenant.length,
          );
        },
      ),
      floatingActionButton: SpeedDial(
        icons: const [
          Icons.group_add,
          Icons.list
        ],
        labels: [
          "手动录入",
          "申请列表"
        ],
        onPressList: [
          (){
            AppRouter.toMemberEdit(context,widget.houseId,edit: false);
          },
          (){},
        ],
      ),
    );
  }

  void _doDeleteMember(BuildContext context, FamilyMember familyMember) async {
    await showDialog(
      context: context,
      builder: (context) {
        return CupertinoAlertDialog(
          title: Text("警告"),
          content: Text("确定要删除${familyMember.membername}?"),
          actions: <Widget>[
            CupertinoDialogAction(
              onPressed: () {
                Navigator.of(context).pop(false);
              },
              child: Text(S.of(context).cancelLabel),
            ),
            CupertinoDialogAction(
              onPressed: () {
                () async {
                  BaseResp result = await Navigator.of(context).push(
                    TaskModal<BaseResp>(
                      () async => await Repository.deleteFamilyMembers(
                          familyMember.memberid),
                    ),
                  );
                  if (result.success) {
                    showToast(S.of(context).deleteLabel);
                    Navigator.of(context).pop(true);
                    setState(() {
                      loadMemberData();
                    });
                  } else {
                    showToast(result.text);
                  }
                }();
              },
              child: Text(S.of(context).confirmLabel),
            )
          ],
        );
      },
    );
  }

  void loadMemberData() {
    future = Repository.getFamilyMembers(widget.houseId);
  }

  _onExamine(FamilyMember familyMember) {
    if (familyMember.examinable) {
    } else {
      showToast("你没有权限查看${familyMember.membername}的出入记录");
    }
  }

  void _doEditMember(BuildContext context, FamilyMember familyMember) async {
    bool result = await AppRouter.toMemberEdit(context, familyMember.memberid);
    if (result == true) {
      setState(() {
        loadMemberData();
      });
    }
  }
}
