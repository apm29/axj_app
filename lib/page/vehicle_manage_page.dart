import 'package:axj_app/model/api.dart';
import 'package:axj_app/model/bean/car.dart';
import 'package:axj_app/model/bean/car_info.dart';
import 'package:axj_app/model/bean/e_bike.dart';
import 'package:axj_app/model/repository.dart';
import 'package:axj_app/page/component/future_task_widget.dart';
import 'package:axj_app/page/component/speed_dial.dart';
import 'package:flutter/material.dart';

class VehicleManagePage extends StatefulWidget {
  @override
  _VehicleManagePageState createState() => _VehicleManagePageState();
}

class _VehicleManagePageState extends State<VehicleManagePage> {
  Future<BaseResp<CarInfo>> carData;
  Future<BaseResp<List<EBike>>> eBikeInfo;

  @override
  void initState() {
    carData = Repository.getMyCars();
    eBikeInfo = Repository.getMyEBike();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('车辆管理'),
      ),
      body: BaseRespTaskBuilder2(
        future1: carData,
        future2: eBikeInfo,
        modelBuilder: (context, CarInfo car, List<EBike> eBike) {
          return CustomScrollView(
            slivers: <Widget>[
              SliverPadding(padding: EdgeInsets.all(8)),
              SliverList(
                delegate: SliverChildListDelegate(
                  car.rows
                      .map(
                        (c) => buildCarLabel(context, c),
                      )
                      .toList(),
                ),
              ),
              SliverList(
                delegate: SliverChildListDelegate(
                  eBike
                      .map(
                        (c) => buildEBikeLabel(context, c),
                      )
                      .toList(),
                ),
              )
            ],
          );
        },
      ),
      floatingActionButton: SpeedDial(
        icons: const [Icons.directions_car, Icons.directions_bike],
        labels: ["添加汽车", "添加非机动车"],
        onPressList: [
          () {},
          () {},
        ],
      ),
    );
  }

  Container buildEBikeLabel(BuildContext context, EBike c) {
    return Container(
      margin: EdgeInsets.symmetric(
        vertical: 6,
        horizontal: 16,
      ),
      child: InkWell(
        child: Row(
          children: <Widget>[
            Material(
              color: Colors.white,
              child: Container(
                child: Image.asset(
                  'assets/images/ebike.png',
                  width: MediaQuery.of(context).size.width * 0.4,
                  height: MediaQuery.of(context).size.width * 0.32,
                ),
                constraints: BoxConstraints(minHeight: 120),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Theme.of(context).secondaryHeaderColor,
                      Theme.of(context).primaryColorLight,
                    ],
                  ),
                ),
              ),
              elevation: 6,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(12))),
              clipBehavior: Clip.antiAlias,
            ),
            Expanded(
              child: Material(
                elevation: 3,
                shape: RoundedRectangleBorder(
                    borderRadius:
                        BorderRadius.horizontal(right: Radius.circular(12))),
                clipBehavior: Clip.antiAlias,
                color: Colors.white,
                child: Container(
                  padding: EdgeInsets.symmetric(
                    vertical: 16,
                    horizontal: 12,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        '非机动车标签:',
                        style: Theme.of(context)
                            .textTheme
                            .title
                            .copyWith(color: Colors.black54),
                      ),
                      Container(
                        child: Text(
                          c.eBilePlate,
                          style: Theme.of(context).textTheme.title.copyWith(
                                color: Colors.white,
                              ),
                        ),
                        padding: EdgeInsets.symmetric(
                          vertical: 4,
                          horizontal: 12,
                        ),
                        decoration: BoxDecoration(
                          color: Theme.of(context).primaryColor,
                          borderRadius: BorderRadius.all(Radius.circular(8)),
                        ),
                      ),
                      Text(
                        '点击查看出入记录',
                        style: Theme.of(context)
                            .textTheme
                            .caption
                            .copyWith(color: Colors.black54),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
        onTap: () {},
      ),
    );
  }

  Container buildCarLabel(BuildContext context, Car c) {
    return Container(
      margin: EdgeInsets.symmetric(
        vertical: 6,
        horizontal: 16,
      ),
      child: InkWell(
        child: Row(
          children: <Widget>[
            Material(
              color: Colors.white,
              child: Container(
                child: Stack(
                  children: <Widget>[
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.4,
                      height: MediaQuery.of(context).size.width * 0.35,
                    ),
                    Image(
                      image: c.hasImage
                          ? NetworkImage(c.vehicleBrand)
                          : AssetImage(''
                              'ass'
                              'ets/images/car1.png'),
                      width: MediaQuery.of(context).size.width * 0.4,
                      height: MediaQuery.of(context).size.width * 0.35,
                      fit: BoxFit.fitWidth,
                    ),
                    Positioned.fill(
                      child: Align(
                        alignment: Alignment.topCenter,
                        child: Visibility(
                          visible: !c.hasImage,
                          child: Text("暂无图片"),
                        ),
                      ),
                    )
                  ],
                ),
                constraints: BoxConstraints(minHeight: 120),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Theme.of(context).secondaryHeaderColor,
                      Theme.of(context).primaryColorLight,
                    ],
                  ),
                ),
              ),
              elevation: 6,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(12))),
              clipBehavior: Clip.antiAlias,
            ),
            Expanded(
              child: Material(
                elevation: 3,
                shape: RoundedRectangleBorder(
                    borderRadius:
                        BorderRadius.horizontal(right: Radius.circular(12))),
                clipBehavior: Clip.antiAlias,
                color: Colors.white,
                child: Container(
                  padding: EdgeInsets.symmetric(
                    vertical: 16,
                    horizontal: 12,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        padding: EdgeInsets.symmetric(
                          vertical: 4,
                          horizontal: 12,
                        ),
                        decoration: BoxDecoration(
                          color: Theme.of(context).primaryColor,
                          borderRadius: BorderRadius.all(Radius.circular(8)),
                        ),
                        child: Text(
                          c.licencePlate,
                          style: Theme.of(context)
                              .textTheme
                              .title
                              .copyWith(color: Colors.white),
                        ),
                      ),
                      Text(
                        c.statusLabel + c.vehicleTypeLabel,
                        style: Theme.of(context)
                            .textTheme
                            .caption
                            .copyWith(color: Colors.black87),
                      ),
                      Text(
                        c.visitorLabel,
                        style: Theme.of(context)
                            .textTheme
                            .subtitle
                            .copyWith(color: Colors.black54),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
        onTap: () {},
      ),
    );
  }
}
