import 'package:axj_app/model/api.dart';
import 'package:axj_app/model/bean/basic/paged_data.dart';
import 'package:axj_app/model/bean/visitor/visitor_record.dart';
import 'package:axj_app/page/component/auto_slide_down_widget.dart';
import 'package:axj_app/page/component/future_task_widget.dart';
import 'package:axj_app/page/transition/auto_transition.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

///
/// author : ciih
/// date : 2020-01-22 11:03
/// description :
///
typedef ValueConverter<T, R> = R Function(T);
typedef AsyncPagedDataTask<T> = Future<T> Function(int, int);

class PagedSliverList<T> extends StatefulWidget {
  static WidgetBuilder defaultEmptyBuilder = (context) => SliverList(
        delegate: SliverChildListDelegate.fixed(
          [
            SizedBox(
              height: 32,
            ),
            Text(
              '暂无数据',
              textAlign: TextAlign.center,
            ),
            SizedBox(
              height: 32,
            ),
            Image.asset(
              'assets/images/no_data.png',
              width: 100,
              height: 100,
            ),
          ],
        ),
      );

  final AsyncPagedDataTask<BaseResp<PagedData<T>>> pagedApi;
  final ValueConverter<PagedData<T>, List<T>> converter;
  final ModelBuilder<T> builder;
  final bool shrinkWrap;

  final WidgetBuilder emptyBuilder;

  PagedSliverList(
    this.pagedApi,
    this.converter,
    this.builder, {
    this.shrinkWrap: true,
    emptyBuilder,
  }) : this.emptyBuilder = emptyBuilder ?? defaultEmptyBuilder;

  @override
  _PagedSliverListState<T> createState() => _PagedSliverListState<T>();
}

class _PagedSliverListState<T> extends State<PagedSliverList<T>> {
  int page = 1;
  int rows = 10;
  List<T> itemList = [];
  bool loading = false;
  bool noMore = false;

  @override
  Widget build(BuildContext context) {
    return SkeletonTaskBuilder<PagedData<T>>(
      task: () async {
        return widget.pagedApi(page, rows);
      },
      builder: (context, data) {
        List<T> list = widget.converter(data);
        if (page == 1) {
          noMore = false;
          itemList.clear();
        }
        if (itemList.length == data.total) {
          noMore = true;
        }
        itemList.addAll(list);
        if (itemList == null || itemList.isEmpty) {
          return CustomScrollView(
            slivers: <Widget>[widget.emptyBuilder(context)],
          );
        }
        return NotificationListener<ScrollNotification>(
          onNotification: (notification) {
            if (notification.metrics.extentAfter <= 0.0) {
              _loadPagedData(context);
            }
            return false;
          },
          child: CustomScrollView(
            shrinkWrap: widget.shrinkWrap,
            slivers: <Widget>[
              CupertinoSliverRefreshControl(
                onRefresh: () async {
                  if (loading) {
                    return;
                  }
                  await Future.delayed(Duration(milliseconds: 300));
                  await _loadPagedData(context, refresh: true);
                },
                refreshTriggerPullDistance: 64,
                refreshIndicatorExtent: 48,
              ),
              SliverToBoxAdapter(
                child: MaterialBanner(
                  content: Text('访客记录'),
                  actions: [Container()],
                ),
              ),
              SliverList(
                delegate: SliverChildBuilderDelegate(
                  (context, index) {
                    return AutoFadeInTransition(
                      child: widget.builder(context, itemList[index]),
                    );
                  },
                  childCount: itemList.length,
                ),
              ),
              SliverToBoxAdapter(
                child: Center(
                  child: noMore ? Text('没有更多了',style: Theme.of(context)
                      .textTheme.caption,) :
                         CupertinoActivityIndicator(),
                ),
              ),
            ],
          ),
        );
      },
      skeletonBuilder: (context) => CupertinoActivityIndicator(),
    );
  }

  Future _loadPagedData(BuildContext context, {bool refresh: false}) async {
    if(refresh){
      noMore = false;
    }
    if (loading || noMore) {
      return;
    }
    loading = true;
    page += 1;
    try {
      await Future.delayed(Duration(milliseconds: 300));
      if(refresh) {
        page = 1;
        await SkeletonTaskBuilder.of<PagedData<T>>(context).add(
          context,
          BaseResp.success(
            data: PagedData.empty(),
          ),
        );
      }
      await SkeletonTaskBuilder.of(context).refresh(context);
    } catch (e) {
      print(e);
    } finally {
      loading = false;
    }
  }
}
