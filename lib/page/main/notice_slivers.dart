import 'package:axj_app/model/api.dart';
import 'package:axj_app/model/bean/notice/notice.dart';
import 'package:axj_app/model/repository.dart';
import 'package:axj_app/page/component/image_picker_widget.dart';
import 'package:axj_app/page/notice/notice_detail.dart';
import 'package:axj_app/redux/action/actions.dart';
import 'package:axj_app/redux/store/store.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';

///
/// author : ciih
/// date : 2020-01-15 14:03
/// description :
///
///
///
class NoticeTitle extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 6, horizontal: 18),
        child: Text("社区信息"),
      ),
    );
  }
}

class NoticeSlivers extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, HomePageState>(
      onInit: (store) async {
        store.state.homePageState.getNoticeList(context, store);
      },
      distinct: true,
      builder: (context, state) => SliverList(
        delegate: SliverChildBuilderDelegate(
            (context, index) => NoticeItemWidget(state.noticeList[index]),
            childCount: state.noticeList?.length ?? 0),
      ),
      converter: (store) => store.state.homePageState,
    );
  }
}

class NoticeItemWidget extends StatefulWidget {
  final Notice notice;

  const NoticeItemWidget(
    this.notice, {
    Key key,
  }) : super(key: key);

  @override
  _NoticeItemWidgetState createState() => _NoticeItemWidgetState();
}

class _NoticeItemWidgetState extends State<NoticeItemWidget>
    with SingleTickerProviderStateMixin {
  AnimationController controller;

  _NoticeItemWidgetState():super();

  @override
  void initState() {
    controller =
        AnimationController(vsync: this, duration: Duration(milliseconds: 400));
    controller.forward();
    super.initState();
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var styleBody = Theme.of(context).textTheme.overline.copyWith(
          color: Theme.of(context).colorScheme.onSurface,
        );
    return Container(
      margin:
          EdgeInsets.symmetric(vertical: 4, horizontal: 12).copyWith(bottom: 0),
      child: SlideTransition(
        position: Tween<Offset>(
          end: Offset.zero,
          begin: const Offset(1.0, 0.0),
        ).animate(controller),
        child: Card(
          color: Colors.white,
          child: InkWell(
            onTap: () => toNoticeDetail(context, widget.notice),
            child: Container(
              constraints: BoxConstraints(
                maxHeight: 180,
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
                          transitionOnUserGestures: true,
                          tag: widget.notice.noticeTitle,
                          child: Text(
                            widget.notice.noticeTitle,
                            style: Theme.of(context).textTheme.subtitle.copyWith(
                              color: Theme.of(context).cardColor.withAlpha(0xaa)
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 18,
                        ),
                        Text(
                          widget.notice.formattedCreatedTime,
                          style: Theme.of(context).textTheme.overline,
                        ),
                        Text.rich(
                          TextSpan(
                            text: widget.notice.companyName,
                            children: [
                              TextSpan(
                                text: widget.notice.hashTags,
                                style: Theme.of(context)
                                    .textTheme
                                    .overline
                                    .copyWith(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .onSurface,
                                    ),
                              )
                            ],
                          ),
                          style: Theme.of(context)
                              .textTheme
                              .overline
                              .copyWith(color: Theme.of(context).accentColor),
                        ),
                        Divider(),
                        SizedBox(
                          height: 50,
                          child: Hero(
                            tag: widget.notice.noticeContent,
                            transitionOnUserGestures: true,
                            flightShuttleBuilder:
                                (context, animation, d, from, to) {
                              return Text(
                                widget.notice.contentSummary,
                                style: TextStyleTween(
                                        begin: styleBody,
                                        end: Theme.of(context).textTheme.body1)
                                    .transform(animation.value),
                                maxLines: 3,
                                overflow: TextOverflow.fade,
                              );
                            },
                            child: Text(
                              widget.notice.contentSummary,
                              style: styleBody,
                              maxLines: 3,
                              overflow: TextOverflow.fade,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    width: widget.notice.hasImage ? 12 : 0,
                  ),
                  Flexible(
                    flex: widget.notice.hasImage ? 4 : 0,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: <Widget>[
                        Expanded(
                          child: widget.notice.hasImage
                              ? Material(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(6)),
                                  clipBehavior: Clip.antiAlias,
                                  type: MaterialType.card,
                                  child: Stack(
                                    fit: StackFit.expand,
                                    children: <Widget>[
                                      Hero(
                                        transitionOnUserGestures: true,
                                        tag: widget.notice.firstImage,
                                        child: Image.network(
                                          widget.notice.firstImage,
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
