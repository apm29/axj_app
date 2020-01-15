import 'package:axj_app/model/api.dart';
import 'package:axj_app/model/bean/notice/notice.dart';
import 'package:axj_app/model/repository.dart';
import 'package:axj_app/page/component/image_picker_widget.dart';
import 'package:axj_app/page/notice/notice_detail.dart';
import 'package:axj_app/redux/action/actions.dart';
import 'package:axj_app/redux/store/store.dart';
import 'package:axj_app/route/route.dart';
import 'package:flutter/cupertino.dart';
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
            (context, index) => NoticeItemWidget(state.latestNoticeList[index]),
            childCount: state.latestNoticeList?.length ?? 0),
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
    var styleBody =
        Theme.of(context).textTheme.overline.copyWith(color: Colors.white70);
    return Container(
      margin:
          EdgeInsets.symmetric(vertical: 4, horizontal: 12).copyWith(bottom: 0),
      child: Card(
        child: InkWell(
          onTap: () => toNoticeDetail(context, notice),
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
                      Hero(
                        tag: notice.noticeTitle,
                        child: Text(
                          notice.noticeTitle,
                          style: Theme.of(context).textTheme.subtitle,
                        ),
                      ),
                      SizedBox(
                        height: 18,
                      ),
                      Text(
                        notice.formattedCreatedTime,
                        style: Theme.of(context).textTheme.overline,
                      ),
                      Text(
                        notice.companyName,
                        style: Theme.of(context)
                            .textTheme
                            .overline
                            .copyWith(color: Theme.of(context).accentColor),
                      ),
                      Divider(),
                      Expanded(
                        child: Hero(
                          tag: notice.noticeContent,
                          flightShuttleBuilder:
                              (context, animation, d, from, to) {
                            return Text(
                              notice.contentSummary,
                              style: TextStyleTween(
                                begin: styleBody,
                                end: Theme.of(context).textTheme.body1
                              ).transform(animation.value),
                              maxLines: 5,
                              overflow: TextOverflow.fade,
                            );
                          },
                          child: Text(
                            notice.contentSummary,
                            style: styleBody,
                            maxLines: 5,
                            overflow: TextOverflow.fade,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  width: notice.hasImage ? 12 : 0,
                ),
                Flexible(
                  flex: notice.hasImage ? 4 : 0,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: <Widget>[
                      Expanded(
                        child: notice.hasImage
                            ? Material(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(6)),
                                clipBehavior: Clip.antiAlias,
                                type: MaterialType.card,
                                child: Stack(
                                  fit: StackFit.expand,
                                  children: <Widget>[
                                    Hero(
                                      tag: notice.firstImage,
                                      child: Image.network(
                                        notice.firstImage,
                                        fit: BoxFit.fitHeight,
                                        loadingBuilder: defaultLoadingBuilder,
                                      ),
                                    ),
                                    DecoratedBox(
                                      decoration: BoxDecoration(
                                        gradient: LinearGradient(
                                          begin: Alignment(1.0, 1.0),
                                          end: Alignment(0.0, 0.5),
                                          colors: <Color>[
                                            Color(0xF0000000),
                                            Color(0x00000000),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
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
      ),
    );
  }

  toNoticeDetail(BuildContext context, Notice notice) {
    //AppRouter.toNoticeDetail(context, notice.noticeId);
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => NoticeDetailPage(
          notice: notice,
        ),
      ),
    );
  }
}
