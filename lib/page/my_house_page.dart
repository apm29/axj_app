import 'package:axj_app/generated/i18n.dart';
import 'package:axj_app/model/api.dart';
import 'package:axj_app/model/bean/district_info.dart';
import 'package:axj_app/model/bean/house_info.dart';
import 'package:axj_app/model/repository.dart';
import 'package:axj_app/page/component/future_task_widget.dart';
import 'package:axj_app/redux/store/store.dart';
import 'package:axj_app/route/route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:oktoast/oktoast.dart';

class MyHousePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(S.of(context).myHouseTitle),
      ),
      body: StoreBuilder<AppState>(
        builder: (context, store) {
          var model = store.state;
          return TaskBuilder(
            task: () async => [
              await Repository.getMyHouseList(model.currentHouse.districtId)
            ],
            modelBuilder: (context, resp) {
              return buildListView(resp[0].data, model, context);
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          () async {
            BaseResp<List<DistrictInfo>> resp =
                await Repository.getMyDistrictInfo();
            if (resp.success) {
              await showModalBottomSheet(
                  context: context,
                  builder: (context) {
                    return _buildModal(context, resp.data);
                  });
            } else {
              showToast(resp.text);
            }
          }();
        },
        child: Icon(Icons.library_books),
      ),
    );
  }

  ListView buildListView(
      List<HouseInfo> houseList, AppState model, BuildContext context) {
    return ListView(
      children: [
        ...houseList.map((house) {
          var districtInfo = model.settings.getDistrictInfo(house.districtId);
          return ListTile(
            onTap: () {
              AppRouter.toMembersManage(context, house.houseId);
            },
            title: Text(
              districtInfo.districtName,
            ),
            subtitle: Text(
              house.addr + "\r\n" + districtInfo.districtAddr,
            ),
            isThreeLine: true,
            leading: Icon(Icons.home),
            trailing: Text(
              house.name,
            ),
          );
        }).toList(),
      ],
    );
  }

  Widget _buildModal(BuildContext context, List<DistrictInfo> data) {
    return BottomSheet(
        onClosing: () {},
        builder: (context) {
          return ListView(
            shrinkWrap: true,
            children: data
                .map(
                  (h) => Card(
                    child: Container(
                      padding: EdgeInsets.all(8),
                      child: ListTile(
                        leading: Icon(Icons.location_searching),
                        title: Text(h.districtName),
                        subtitle: Text(h.districtAddr),
                      ),
                    ),
                  ),
                )
                .toList(),
          );
        });
  }
}
