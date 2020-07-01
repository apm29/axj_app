import 'package:axj_app/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:axj_app/model/bean/car.dart';
import 'package:axj_app/model/bean/car_info.dart';
import 'package:axj_app/model/bean/e_bike.dart';
import 'package:axj_app/model/repository.dart';
import 'package:axj_app/page/component/future_task_widget.dart';
import 'package:axj_app/page/component/speed_dial.dart';

class VehicleManagePage extends StatefulWidget {
  @override
  _VehicleManagePageState createState() => _VehicleManagePageState();
}

class _VehicleManagePageState extends State<VehicleManagePage> {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(S.of(context).vehicleManageTitle),
      ),
      body: TaskBuilder(
        task: () async {
          await Future.delayed(Duration(milliseconds: 800));
          return [await Repository.getMyCars(), await Repository.getMyEBike()];
        },
        modelBuilder: (context, resp) {
          return buildCustomScrollView(resp[0].data, context, resp[1].data);
        },
      ),
      floatingActionButton: SpeedDial(
        icons: const [Icons.directions_car, Icons.directions_bike],
        labels: [
          S.of(context).addEBikeLabel,
          S.of(context).addVehicleLabel,
        ],
        onPressList: [
          () {},
          () {},
        ],
      ),
    );
  }

  CustomScrollView buildCustomScrollView(
      CarInfo car, BuildContext context, List<EBike> eBike) {
    return CustomScrollView(
      slivers: <Widget>[
        SliverPadding(padding: EdgeInsets.all(8)),
        SliverList(
          delegate: SliverChildListDelegate(
            car.rows
                .map(
                  (car) => buildCarLabel(context, car),
                )
                .toList(),
          ),
        ),
        SliverList(
          delegate: SliverChildListDelegate(
            eBike
                .map(
                  (bike) => buildEBikeLabel(context, bike),
                )
                .toList(),
          ),
        )
      ],
    );
  }

  Container buildEBikeLabel(BuildContext context, EBike bike) {
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
                        S.of(context).eBikeTagLabel,
                        style: Theme.of(context)
                            .textTheme
                            .headline6
                            .copyWith(color: Colors.black54),
                      ),
                      Container(
                        child: Text(
                          bike.eBilePlate,
                          style: Theme.of(context).textTheme.headline6.copyWith(
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
                        S.of(context).clickToSeeAccessRecord,
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

  Container buildCarLabel(BuildContext context, Car car) {
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
                      image: car.hasImage
                          ? NetworkImage(car.vehicleBrand)
                          : AssetImage('assets/images/car1.png'),
                      width: MediaQuery.of(context).size.width * 0.4,
                      height: MediaQuery.of(context).size.width * 0.35,
                      fit: BoxFit.fitWidth,
                    ),
                    Positioned.fill(
                      child: Align(
                        alignment: Alignment.topCenter,
                        child: Visibility(
                          visible: !car.hasImage,
                          child: Text(S.of(context).imageNoAvailable),
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
                          car.licencePlate,
                          style: Theme.of(context)
                              .textTheme
                              .headline6
                              .copyWith(color: Colors.white),
                        ),
                      ),
                      Text(
                        car.statusLabel + car.vehicleTypeLabel,
                        style: Theme.of(context)
                            .textTheme
                            .caption
                            .copyWith(color: Colors.black87),
                      ),
                      Text(
                        car.visitorLabel,
                        style: Theme.of(context)
                            .textTheme
                            .subtitle2
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
