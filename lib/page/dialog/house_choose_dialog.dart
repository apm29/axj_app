import 'package:axj_app/model/bean/district_info.dart';
import 'package:axj_app/model/bean/house_info.dart';
import 'package:axj_app/model/repository.dart';
import 'package:axj_app/page/component/future_task_widget.dart';
import 'package:axj_app/page/modal/house_choose_modal.dart';
import 'package:flutter/cupertino.dart';

class HouseChooseDialog extends StatefulWidget {
  @override
  _HouseChooseDialogState createState() => _HouseChooseDialogState();
}

class _HouseChooseDialogState extends State<HouseChooseDialog> {
  final Future future = Repository.getMyDistrictInfo();
  bool offstage = false;
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Offstage(
        offstage: offstage,
        child: BaseRespTaskBuilder<List<DistrictInfo>>(
          future: future,
          modelBuilder: (context, List<DistrictInfo> model) {
            return CupertinoActionSheet(
              title: Text("选择小区"),
              message: Text("选择当前居住的小区"*3),
              actions: model
                  .map(
                    (d) => CupertinoActionSheetAction(
                      child: Text(d.districtName),
                      onPressed: () {
                        () async {
                          setState(() {
                            offstage = true;
                          });
                          HouseInfo result = await Navigator.of(context)
                              .push<HouseInfo>(HouseChooseModal2(d.districtId));
                          Navigator.of(context).pop(result);
                        }();
                      },
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

class HouseChooseDialog2 extends StatelessWidget {
  final dynamic districtId;

  Future get future => Repository.getMyHouseList(districtId);

  const HouseChooseDialog2({Key key, this.districtId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: BaseRespTaskBuilder<List<HouseInfo>>(
        future: future,
        modelBuilder: (context, List<HouseInfo> model) {
          return CupertinoActionSheet(
            title: Text("选择房屋"),
            message: Text("选择当前居住的房屋"),
            actions: model
                .map(
                  (d) => CupertinoActionSheetAction(
                    child: Text(d.house),
                    onPressed: () {
                      Navigator.of(context).pop(d);
                    },
                  ),
                )
                .toList(),
          );
        },
      ),
    );
  }
}
