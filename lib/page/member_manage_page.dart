import 'package:axj_app/generated/i18n.dart';
import 'package:axj_app/model/api.dart';
import 'package:axj_app/model/bean/enum_config.dart';
import 'package:axj_app/model/bean/family_member.dart';
import 'package:axj_app/model/repository.dart';
import 'package:axj_app/page/component/future_task_widget.dart';
import 'package:axj_app/page/component/speed_dial.dart';
import 'package:axj_app/page/modal/task_modal.dart';
import 'package:axj_app/route/route.dart';
import 'package:axj_app/utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MemberManagePage extends StatefulWidget {
  final houseId;

  const MemberManagePage({Key key, this.houseId}) : super(key: key);

  @override
  _MemberManagePageState createState() => _MemberManagePageState();
}

class _MemberManagePageState extends State<MemberManagePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(S.of(context).familyMemberManageTitle),
      ),
      body: TaskBuilder(
        task: () async => [await Repository.getFamilyMembers(widget.houseId)],
        modelBuilder: (context, list) {
          return ListView.builder(
            itemBuilder: (context, index) {
              List allData = [
                ...list[0].data.familyMember,
                ...list[0].data.tenant
              ];
              var familyMember = allData[index];
              return buildListTile(familyMember, context);
            },
            itemCount:
                list[0].data.familyMember.length + list[0].data.tenant.length,
          );
        },
      ),
      floatingActionButton: SpeedDial(
        icons: const [Icons.group_add, Icons.list],
        labels: [
          S.of(context).addFamilyMemberLabel,
          S.of(context).applyListLabel
        ],
        onPressList: [
          () {
            AppRouter.toMemberEdit(context, widget.houseId, edit: false);
          },
          () {},
        ],
      ),
    );
  }

  ListTile buildListTile(familyMember, BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        backgroundImage: NetworkImage(familyMember.memberpicurl ?? ""),
        child: familyMember.memberpicurl != null
            ? null
            : Text("暂无照片",style: Theme.of(context).textTheme.caption,),
        radius: 30,
      ),
      onTap: () => _onExamine(familyMember),
      isThreeLine: true,
      title: Text(familyMember.membername),
      subtitle:
          Text(familyMember.presentStatue + "\r\n" + familyMember.relationtype),
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
                  Text(S.of(context).editLabel),
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
                  Text(S.of(context).deleteLabel),
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
  }

  void _doDeleteMember(BuildContext context, FamilyMember familyMember) async {
    await showDialog(
      context: context,
      builder: (context) {
        return CupertinoAlertDialog(
          title: Text(S.of(context).warningLabel),
          content: Text(S.of(context).deleteHint(familyMember.membername)),
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
                    showAppToast(S.of(context).deleteLabel);
                    Navigator.of(context).pop(true);
                  } else {
                    showAppToast(result.text);
                  }
                }();
              },
              child: Text(S.of(context).confirmLabel),
            )
          ],
        );
      },
    );
    TaskBuilder.of(context).refresh(context);
  }

  _onExamine(FamilyMember familyMember) {
    if (familyMember.examinable) {
    } else {
      showAppToast(
          S.of(context).recordViewNoAuthorizationHint(familyMember.membername));
    }
  }

  void _doEditMember(BuildContext context, FamilyMember familyMember) async {
    bool result = await AppRouter.toMemberEdit(context, familyMember.memberid);
    if (result == true) {
      TaskBuilder.of(context).refresh(context);
    }
  }
}
