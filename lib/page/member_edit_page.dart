import 'package:axj_app/generated/l10n.dart';
import 'package:axj_app/model/api.dart';
import 'package:axj_app/model/bean/family_member.dart';
import 'package:axj_app/model/repository.dart';
import 'package:axj_app/page/component/future_task_widget.dart';
import 'package:axj_app/page/component/image_picker_widget.dart';
import 'package:axj_app/page/modal/task_modal.dart';
import 'package:axj_app/utils.dart';
import 'package:axj_app/widget/loading_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MemberEditPage extends StatefulWidget {
  final String id;
  final bool edit;

  const MemberEditPage({Key key, this.id, this.edit}) : super(key: key);

  @override
  _MemberEditPageState createState() => _MemberEditPageState();
}

class _MemberEditPageState extends State<MemberEditPage> {
  ImageUrlController _imageUrlController = ImageUrlController();
  TextEditingController _nameController = TextEditingController();
  TextEditingController _phoneController = TextEditingController();
  TextEditingController _idController = TextEditingController();
  TextEditingController _relationshipController = TextEditingController();
  SwitchController _shareController = SwitchController();
  Future<BaseResp<FamilyMember>> future;

  bool get editMember => widget.edit;
  bool initialCalled = false;

  @override
  void initState() {
    if (editMember) {
      future = Repository.getFamilyMemberDetail(widget.id);
    } else {
      future = Future.value(BaseResp.success(data: FamilyMember()));
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      appBar: AppBar(
        title: Text(editMember ? "修改成员信息" : "新增成员信息"),
      ),
      body: Form(
        child: BaseRespTaskBuilder<FamilyMember>(
          future: future,
          modelBuilder: (context, memberInfo) {
            if (!initialCalled) {
              _imageUrlController.url = memberInfo.memberpicurl??"";
              _nameController.text = memberInfo.membername;
              _phoneController.text = memberInfo.memberphone;
              _idController.text = memberInfo.idno;
              _relationshipController.text = memberInfo.relationtype;
              _shareController.checked = memberInfo.share;
              initialCalled = true;
            }
            return CustomScrollView(
              physics: AlwaysScrollableScrollPhysics(),
              slivers: <Widget>[
                SliverToBoxAdapter(
                  child: InputActionTile(
                      title: "人脸照片",
                      helpText: "上传成员人脸照片,用于出入小区",
                      icon: Icons.tag_faces,
                      end: ImagePickerWidget(
                        controller: _imageUrlController,
                        size: Size(96, 92),
                      ),
                      validator: (s) => s.isEmpty ? "请上传人脸照片" : null),
                ),
                SliverToBoxAdapter(
                  child: SizedBox(
                    height: 16,
                  ),
                ),
                SliverToBoxAdapter(
                  child: InputActionTile(
                      title: "成员姓名",
                      icon: Icons.person_outline,
                      helpText: "输入成员姓名",
                      controller: _nameController,
                      validator: (s) => s.isEmpty ? "请输入成员姓名" : null),
                ),
                SliverToBoxAdapter(
                  child: InputActionTile(
                      title: "联系号码",
                      icon: Icons.phone_android,
                      helpText: "输入成员联系号码",
                      controller: _phoneController,
                      validator: (s) => s.isEmpty ? "请输入联系电话" : null),
                ),
                SliverToBoxAdapter(
                  child: InputActionTile(
                      title: "身份证号",
                      icon: Icons.credit_card,
                      helpText: "输入成员身份证号",
                      controller: _idController,
                      validator: (s) => s.isEmpty ? "请输入有效的身份证号码" : null),
                ),
                SliverToBoxAdapter(
                  child: SizedBox(
                    height: 16,
                  ),
                ),
                SliverToBoxAdapter(
                  child: InputActionTile(
                      title: "成员关系",
                      icon: Icons.group,
                      helpText: "选择成员关系",
                      selectable: true,
                      onSelect: () => _chooseRelationship(context),
                      controller: _relationshipController,
                      validator: (s) => s.isEmpty ? "请选择成员关系" : null),
                ),
                SliverToBoxAdapter(
                  child: InputActionTile(
                    title: "共享出入记录",
                    helpText: "共享出入小区的记录",
                    icon: CupertinoIcons.shuffle_thick,
                    end: SwitchActionButton(
                      controller: _shareController,
                    ),
                  ),
                ),
                SliverToBoxAdapter(
                  child: SizedBox(
                    height: 16,
                  ),
                ),
                SliverToBoxAdapter(
                  child: Container(
                    margin: EdgeInsets.symmetric(horizontal: 16),
                    child: LoadingWidget(
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          S.of(context).confirmLabel,
                          style: TextStyle(fontSize: 20),
                        ),
                      ),
                      constrained: false,
                      onPressed: () => _submit(context),
                      gradient: LinearGradient(
                        colors: [
                          Theme.of(context).colorScheme.secondary,
                          Theme.of(context).colorScheme.secondary
                        ],
                      ),
                    ),
                  ),
                )
              ],
            );
          },
        ),
      ),
    );
  }

  Future<void> _submit(BuildContext context) async {
    if (Form.of(context).validate()) {
      if (_imageUrlController.url == null) {
        showAppToast("请选择人脸照片");
        return;
      }
      var resp = await Navigator.of(context)
          .push<BaseResp>(TaskModal<BaseResp>(() async {
        return task();
      }));
      if (resp.success) {
        Navigator.of(context).pop(true);
        showAppToast(editMember ? "修改成功" : "保存成功");
      } else {
        showAppToast(resp.text);
      }
    }
  }

  Future<BaseResp> task() async {
    return editMember
        ? await Repository.updateMemberInfo(
            memberId: widget.id,
            memberName: _nameController.text,
            memberPhone: _phoneController.text,
            idNo: _idController.text,
            memberPicUrl: _imageUrlController.url,
            relationType: _relationshipController.text,
            isShare: _shareController.isShare,
          )
        : await Repository.addMemberInfo(
            familyId: widget.id,
            memberName: _nameController.text,
            memberPhone: _phoneController.text,
            idNo: _idController.text,
            memberPicUrl: _imageUrlController.url,
            relationType: _relationshipController.text,
            isShare: _shareController.isShare,
          );
  }

  List<String> typeDictionary = ["家庭成员", "租客", "寄住"];

  void _chooseRelationship(BuildContext context) async {
    String type = await showModalBottomSheet(
        context: context,
        builder: (context) {
          return ListView(
            shrinkWrap: true,
            children: typeDictionary
                .map((s) => ListTile(
                      title: Center(child: Text(s)),
                      onTap: () {
                        Navigator.of(context).pop(s);
                      },
                    ))
                .toList(),
          );
        });
    if (type != null) {
      _relationshipController.text = type;
    }
  }
}

class SwitchController extends ChangeNotifier {
  bool _checked = false;

  bool get checked => _checked;

  String get isShare => checked ? "1" : "0";

  set checked(bool value) {
    if (_checked != value) {
      _checked = value;
      notifyListeners();
    }
  }
}

class SwitchActionButton extends StatefulWidget {
  final SwitchController controller;

  const SwitchActionButton({Key key, this.controller}) : super(key: key);

  @override
  _SwitchActionButtonState createState() =>
      _SwitchActionButtonState(controller);
}

class _SwitchActionButtonState extends State<SwitchActionButton> {
  SwitchController controller;

  _SwitchActionButtonState(this.controller);

  @override
  void initState() {
    if (controller == null) {
      controller = SwitchController();
    }
    controller.addListener(() {
      setState(() {});
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoSwitch(
      value: controller.checked,
      onChanged: (v) {
        controller.checked = v;
      },
    );
  }
}

class InputActionTile extends StatelessWidget {
  final String title;
  final IconData icon;
  final String helpText;
  final bool selectable;
  final VoidCallback onSelect;
  final Widget end;
  final TextEditingController controller;
  final FormFieldValidator<String> validator;

  InputActionTile(
      {this.title,
      this.icon,
      this.helpText,
      this.selectable = false,
      this.onSelect,
      this.end,
      this.controller,
      this.validator});

  bool get noInput => end != null;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: selectable ? onSelect : null,
      child: Column(
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
              color: Theme.of(context).cardColor,
            ),
            padding: EdgeInsets.symmetric(vertical: 8, horizontal: 12),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Icon(
                  icon,
                  size: 28,
                  color: Theme.of(context).accentColor,
                ),
                SizedBox(
                  width: 16,
                ),
                Text(title),
                SizedBox(
                  width: 16,
                ),
                noInput
                    ? Expanded(
                        child: Text(
                        helpText,
                        style: Theme.of(context).textTheme.caption,
                      ))
                    : Container(),
                Expanded(
                  child: noInput
                      ? Align(
                          child: end,
                          alignment: Alignment.centerRight,
                        )
                      : AbsorbPointer(
                          absorbing: selectable,
                          child: TextFormField(
                            validator: validator,
                            decoration: InputDecoration.collapsed(
                              hintText: helpText,
                              hintStyle: Theme.of(context).textTheme.caption,
                            ),
                            readOnly: selectable,
                            controller: controller,
                          ),
                        ),
                ),
                Visibility(
                  visible: selectable,
                  child: Icon(Icons.keyboard_arrow_down),
                )
              ],
            ),
          ),
          Container(
            height: 0.5,
          )
        ],
      ),
    );
  }
}
