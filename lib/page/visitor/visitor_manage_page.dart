import 'package:axj_app/model/bean/house_info.dart';
import 'package:axj_app/model/bean/visitor/family_code.dart';
import 'package:axj_app/model/repository.dart';
import 'package:axj_app/page/component/draggable_upper_drawer.dart';
import 'package:axj_app/page/component/future_task_widget.dart';
import 'package:axj_app/redux/store/store.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';

///
/// author : ciih
/// date : 2020-01-21 13:16
/// description :
///
class VisitorManagePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: UpDraggableDrawerWidget(
        upperBuilder: (context, anim, child) => Container(
          padding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Row(
                children: <Widget>[
                  InkWell(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: BackButtonIcon(),
                    ),
                    onTap: () {
                      Navigator.of(context).pop();
                    },
                  ),
                  Expanded(
                    child: Text(
                      '访客管理',
                      style: Theme.of(context).textTheme.title,
                    ),
                  ),
                  InkWell(
                    child: AnimatedIcon(
                        icon: AnimatedIcons.close_menu, progress: anim),
                    onTap: () =>
                        UpDraggableDrawerWidget.of(context).closeOrOpen(),
                  )
                ],
              ),
              SizedBox(height: 120,),
              child,
            ],
          ),
        ),
        upper: StoreConnector<AppState, HouseInfo>(
          builder: (context, house) {
            return SkeletonTaskBuilder<List<FamilyCode>>(
              task: () async {
                await Future.delayed(Duration(seconds: 3));
                return Repository.getFamilyPassCode(
                  house.districtId,
                  house.houseId.toString(),
                  true,
                );
              },
              builder: (BuildContext context, List<FamilyCode> data) {
                return Material(
                  type: MaterialType.card,
                  color: Theme.of(context).colorScheme.primary,
                  elevation: 2,
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 18, horizontal: 24),
                    child: Column(
                      children: <Widget>[
                        Text(
                          data.first.passCode,
                          style: Theme.of(context).textTheme.title.copyWith(
                            color: Theme.of(context).colorScheme.onPrimary,
                            fontWeight: FontWeight.w900,
                            letterSpacing: 24,
                            fontSize: 36
                          ),
                        ),
                        SizedBox(
                          height: 16,
                        ),
                        Text(
                          data.first.houseAddress,
                          style: Theme.of(context).textTheme.caption.copyWith(
                            color: Theme.of(context).colorScheme.onPrimary,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
              skeletonBuilder: (context) => Container(
                height: 120,
                child: CupertinoActivityIndicator(),
              ),
            );
          },
          converter: (store) => store.state.currentHouse,
        ),
        background: Column(
          children: <Widget>[
            Image.asset(
              'assets/images/visitor_manage.png',
            ),
            Expanded(
              child: SizedBox(
                height: 1,
              ),
            )
          ],
        ),
        dragHandlerBuilder:(context,anim,child) => InkWell(
          child: Container(
            height: 48,
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.surface,
              borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
            ),
            clipBehavior: Clip.antiAlias,
          ),
          onTap: ()=>UpDraggableDrawerWidget.of(context).closeOrOpen(),
        ),
        bottom: Container(
          color: Colors.white,
          child: ListView(
            shrinkWrap: true,
            children: <Widget>[
              ...[1, 2, 3, 4, 5, 6, 2, 3, 4, 6].map((c) => Text(c.toString()))
            ],
          ),
        ),
      ),
    );
  }
}
