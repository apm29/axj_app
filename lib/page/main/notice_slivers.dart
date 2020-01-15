import 'package:axj_app/model/api.dart';
import 'package:axj_app/model/bean/notice/notice.dart';
import 'package:axj_app/model/repository.dart';
import 'package:axj_app/page/component/bottom_fade_container.dart';
import 'package:axj_app/redux/action/actions.dart';
import 'package:axj_app/redux/store/store.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';

///
/// author : ciih
/// date : 2020-01-15 14:03
/// description :
///
class NoticeSlivers extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, HomePageState>(
      onInit: (store) async {
        store.dispatch(
          ImplicitTaskAction(
            () async {
              BaseResp<List<Notice>> notice = await Repository.getAllNotice();
              store.state.homePageState.noticeList = notice.data ?? [];
            },
            context,
          ),
        );
      },
      builder: (context, state) => SliverList(
        delegate: SliverChildBuilderDelegate(
            (context, index) => NoticeItemWidget(state.noticeList[index]),
            childCount: state.noticeList?.length ?? 0),
      ),
      converter: (store) => store.state.homePageState,
    );
  }
}

class NoticeItemWidget extends StatelessWidget {
  final Notice notice;

  const NoticeItemWidget(
    this.notice, {
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 6, horizontal: 12),
      child: Card(
        child: Container(
          constraints: BoxConstraints(
            maxHeight: 200,
          ),
          padding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Flexible(
                flex: 7,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      notice.noticeTitle,
                      style: Theme.of(context).textTheme.subtitle,
                    ),
                    SizedBox(
                      height: 24,
                    ),
                    BottomFadeContainer(
                      child: Text(
                        notice.contentSummary,
                        style: Theme.of(context).textTheme.body1,
                      ),
                    ),
                    Expanded(
                      child: Container(),
                    ),
                    Text(
                      notice.createTime,
                      style: Theme.of(context).textTheme.overline,
                    ),
                    Text(
                      notice.companyName,
                      style: Theme.of(context).textTheme.overline,
                    ),
                  ],
                ),
              ),
              Flexible(
                flex: notice.hasImage ? 4 : 0,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: <Widget>[
                    Expanded(
                      child: notice.hasImage
                          ? Image.network(
                              notice.firstImage,
                              fit: BoxFit.fitHeight,
                            )
                          : Container(),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
