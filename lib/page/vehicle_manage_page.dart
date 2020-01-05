import 'package:axj_app/model/api.dart';
import 'package:axj_app/model/bean/car_info.dart';
import 'package:axj_app/model/bean/e_bike.dart';
import 'package:axj_app/model/repository.dart';
import 'package:axj_app/page/component/future_task_widget.dart';
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
              SliverList(
                delegate: SliverChildListDelegate(
                  car.rows
                      .map(
                        (c) => InkWell(
                          child: Row(
                            children: <Widget>[
                              Card(
                                child: Image.asset(
                                  'assets/images/car3.jpg',
                                  width:
                                      MediaQuery.of(context).size.width * 0.4,
                                ),
                                elevation: 6,
                                shape: RoundedRectangleBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(12))),
                                clipBehavior: Clip.antiAlias,
                              ),
                              Text(c.licencePlate),
                            ],
                          ),
                          onTap: () {},
                        ),
                      )
                      .toList(),
                ),
              ),
              SliverList(
                delegate: SliverChildListDelegate(
                  eBike
                      .map(
                        (c) => InkWell(
                          child: Row(
                            children: <Widget>[
                              Card(
                                child: Image.asset(
                                  'assets/images/ebike.png',
                                  width:
                                      MediaQuery.of(context).size.width * 0.4,
                                ),
                                elevation: 6,
                                shape: RoundedRectangleBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(12))),
                                clipBehavior: Clip.antiAlias,
                              ),
                              Text(c.plateDecode),
                            ],
                          ),
                          onTap: () {},
                        ),
                      )
                      .toList(),
                ),
              )
            ],
          );
        },
      ),
    );
  }
}
