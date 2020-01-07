import 'package:axj_app/model/bean/role_info.dart';
import 'package:axj_app/model/repository.dart';
import 'package:axj_app/page/component/future_task_widget.dart';
import 'package:flutter/cupertino.dart';

class RoleChooseDialog extends StatefulWidget {
  @override
  _RoleChooseDialogState createState() => _RoleChooseDialogState();
}

class _RoleChooseDialogState extends State<RoleChooseDialog> {
  final Future future = Repository.findUserRoles();
  bool offstage = false;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Offstage(
        offstage: offstage,
        child: BaseRespTaskBuilder<List<RoleInfo>>(
          future: future,
          modelBuilder: (context, List<RoleInfo> model) {
            return CupertinoActionSheet(
              title: Text("选择角色"),
              message: Text("选择当前使用的角色"),
              actions: model
                  .map(
                    (d) => CupertinoActionSheetAction(
                      child: Text(d.roleName),
                      onPressed: () => Navigator.of(context).pop(d),
                    ),
                  )
                  .toList(),
            );
          },
        ),
      ),
    );
  }
}
