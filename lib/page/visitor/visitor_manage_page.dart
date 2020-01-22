import 'dart:math';
import 'dart:ui';

import 'package:axj_app/model/bean/house_info.dart';
import 'package:axj_app/model/bean/visitor/paged_visitor_record.dart';
import 'package:axj_app/model/bean/visitor/visit_record.dart';
import 'package:axj_app/model/bean/visitor/visitor_record.dart';
import 'package:axj_app/model/repository.dart';
import 'package:axj_app/page/component/back_drop_background.dart';
import 'package:axj_app/page/component/draggable_upper_drawer.dart';
import 'package:axj_app/page/component/future_task_widget.dart';
import 'package:axj_app/page/component/image_picker_widget.dart';
import 'package:axj_app/page/component/paged_sliver_list.dart';
import 'package:axj_app/page/modal/task_modal.dart';
import 'package:axj_app/redux/store/store.dart';
import 'package:axj_app/utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
              SizedBox(
                height: 32,
              ),
              child,
            ],
          ),
        ),
        upper: StoreConnector<AppState, HouseInfo>(
          builder: (context, house) {
            return SkeletonTaskBuilder<List<HouseInfo>>(
              task: () async {
                return Repository.getMyHouseList(
                  house.districtId,
                );
              },
              builder: (BuildContext context, List<HouseInfo> data) {
                return ConstrainedBox(
                  constraints: BoxConstraints(
                    maxHeight:
                        max(MediaQuery.of(context).size.height * 0.3, 240),
                  ),
                  child: PassCodePagedWidget(
                    data: data,
                    onRefresh: (HouseInfo house) {
                      TaskModal.runTask(context, () async {
                        await Repository.getFamilyPassCode(
                            house.districtId, house.houseId.toString(), true);
                        SkeletonTaskBuilder.of(context).refresh(context);
                      });
                    },
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
        background: GaussBlurBackground(
          assetPath: 'assets/images/home.png',
        ),
        dragHandlerBuilder: (context, anim, child) => GestureDetector(
          child: Container(
            height: 48,
            constraints: BoxConstraints.expand(height: 48),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.primary,
              borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
            ),
            child: Align(
              child: Text(
                '轻点两下${anim.status == AnimationStatus.completed ? '收起' : '展开'}',
                style: Theme.of(context)
                    .textTheme
                    .caption
                    .copyWith(color: Theme.of(context).colorScheme.onPrimary),
              ),
              alignment: Alignment.center,
            ),
            clipBehavior: Clip.antiAlias,
          ),
          onDoubleTap: () => UpDraggableDrawerWidget.of(context).closeOrOpen(),
        ),
        bottomBuilder: (
          context,
          anim,
          child, {
          double top,
          double dragHandlerHeight,
          double minUpperExtend,
        }) {
          print(MediaQuery.of(context).size.height);
          print(top);
          print(dragHandlerHeight);
          print(minUpperExtend);
          print(MediaQuery.of(context).padding.top);
          return SizedBox(
            height: MediaQuery.of(context).size.height -
                top -
                dragHandlerHeight -
                MediaQuery.of(context).padding.top,
            child: child,
          );
        },
        bottom: VisitorRecordWidget(),
        draggableAtBottom: true,
        minUpperExtend: 64,
      ),
    );
  }
}

class VisitorRecordWidget extends StatelessWidget {
  const VisitorRecordWidget({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, HouseInfo>(
      builder: (context, house) {
        return PagedSliverList<VisitorRecord>(
          (page, rows) async {
            return Repository.getVisitorLog(house.houseId,
                page: page, rows: rows);
          },
          (data) => data.rows,
          (context, data) => Container(
            color: Colors.white,
            child: ListTile(
              dense: true,
              title: Text(formattedTime(data.occurtime)),
              subtitle: InkWell(
                onTap: () {},
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Text(
                      '举报',
                      style: Theme.of(context).textTheme.caption.copyWith(
                            color: Theme.of(context).colorScheme.primary,
                          ),
                    )
                  ],
                ),
              ),
              leading: Image.network(
                data.imageurl,
                width: 60,
                height: 80,
                fit: BoxFit.cover,
                loadingBuilder: (context, child, progress) => SizedBox(
                  width: 60,
                  height: 80,
                  child: defaultLoadingBuilder(context, child, progress),
                ),
              ),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Text(data.actionString),
                  Icon(data.actiontype == 2
                      ? Icons.arrow_back
                      : Icons.arrow_forward),
                ],
              ),
            ),
          ),
        );
      },
      converter: (store) => store.state.currentHouse,
    );
  }
}

class PassCodePagedWidget extends StatelessWidget {
  final List<HouseInfo> data;
  final ValueChanged<HouseInfo> onRefresh;

  const PassCodePagedWidget({
    Key key,
    this.data,
    this.onRefresh,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PageView.custom(
      controller: PageController(),
      childrenDelegate: SliverChildBuilderDelegate(
          (context, index) => Container(
                padding: EdgeInsets.all(8),
                child: Material(
                  type: MaterialType.card,
                  color: Theme.of(context).colorScheme.surface,
                  elevation: 4,
                  child: GaussBlurBackground(
                    assetPath: 'assets/images/city_night.png',
                    sigmaX: 0,
                    sigmaY: 0,
                    child: Container(
                      padding:
                          EdgeInsets.symmetric(vertical: 18, horizontal: 24),
                      child: Column(
                        children: <Widget>[
                          Text(
                            data[index].addr,
                            style: Theme.of(context).textTheme.caption.copyWith(
                                  color: Colors.white,
                                ),
                          ),
                          SizedBox(
                            height: 12,
                          ),
                          Text(
                            '家庭通行码',
                            style: Theme.of(context).textTheme.caption.copyWith(
                                  color: Colors.white,
                                ),
                          ),
                          SizedBox(
                            height: 12,
                          ),
                          ClipPath(
                            clipBehavior: Clip.antiAlias,
                            clipper: RoundedRectangleClipper(radius: 6),
                            child: BackdropFilter(
                              filter: ImageFilter.blur(sigmaY: 5, sigmaX: 5),
                              child: Container(
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: Colors.white,
                                    width: 6,
                                  ),
                                  color: Theme.of(context)
                                      .colorScheme
                                      .surface
                                      .withAlpha(77),
                                ),
                                padding: EdgeInsets.all(6),
                                child: Text(
                                  data[index].passCode,
                                  style: Theme.of(context)
                                      .textTheme
                                      .title
                                      .copyWith(
                                          color: Theme.of(context)
                                              .colorScheme
                                              .onPrimary,
                                          fontWeight: FontWeight.w900,
                                          letterSpacing: 24,
                                          fontSize: 36),
                                ),
                              ),
                            ),
                          ),
                          Divider(
                            height: 12,
                          ),
                          Material(
                            elevation: 3,
                            clipBehavior: Clip.antiAlias,
                            borderRadius: BorderRadius.all(Radius.circular(24)),
                            color: Theme.of(context).colorScheme.primary,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                FlatButton.icon(
                                  onPressed: () async {
                                    await onRefreshPassCode(context, index);
                                  },
                                  icon: Icon(
                                    Icons.refresh,
                                    color:
                                        Theme.of(context).colorScheme.onPrimary,
                                  ),
                                  label: Text(
                                    '刷新通行码',
                                    style: Theme.of(context)
                                        .textTheme
                                        .caption
                                        .copyWith(
                                          color: Theme.of(context)
                                              .colorScheme
                                              .onPrimary,
                                        ),
                                  ),
                                ),
                                FlatButton.icon(
                                  onPressed: () async {
                                    await onCopyPassCode(context, index);
                                  },
                                  icon: Icon(
                                    Icons.content_copy,
                                    color:
                                        Theme.of(context).colorScheme.onPrimary,
                                  ),
                                  label: Text(
                                    '复制通行码',
                                    style: Theme.of(context)
                                        .textTheme
                                        .caption
                                        .copyWith(
                                          color: Theme.of(context)
                                              .colorScheme
                                              .onPrimary,
                                        ),
                                  ),
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
          childCount: data.length),
    );
  }

  Future onRefreshPassCode(BuildContext context, int index) async {
    bool result = await showDialog<bool>(
        context: context,
        builder: (context) => CupertinoAlertDialog(
              title: Text('警告'),
              content: Text('更新后所有访客无法进去，需要重新使用家庭通行码'),
              actions: <Widget>[
                CupertinoButton(
                    child: Text('取消'),
                    onPressed: () {
                      Navigator.of(context).pop(false);
                    }),
                CupertinoButton(
                    child: Text('确定'),
                    onPressed: () {
                      Navigator.of(context).pop(true);
                    }),
              ],
            ));
    if (result == true) {
      onRefresh?.call(data[index]);
    }
  }

  Future onCopyPassCode(BuildContext context, int index) async {
    await Clipboard.setData(
        ClipboardData(text: data[index].passCode.toString()));
    showAppToast('已复制到剪切板');
  }
}
