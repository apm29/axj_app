import 'package:axj_app/model/bean/notice/notice.dart';
import 'package:axj_app/model/repository.dart';
import 'package:axj_app/page/component/future_task_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class NoticeDetailPage extends StatelessWidget {
  final String noticeId;
  final Notice notice;

  const NoticeDetailPage({
    Key key,
    this.noticeId,
    this.notice,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SkeletonTasksBuilder(
      tasks: () async {
        return [
          Repository.getNoticeDetail(notice.noticeId.toString()),
          Repository.getNoticeLikes(notice.noticeId.toString()),
        ];
      },
      builder: (context, data) {
        var noticeDetail = data[0].data;
        var likeUserList = data[1].data;
        return buildScaffold(context, noticeDetail, likeUserList: likeUserList);
      },
      skeletonBuilder: (context) {
        return buildScaffold(
          context,
          notice,
        );
      },
    );
  }

  Scaffold buildScaffold(
    BuildContext context,
    Notice data, {
    List likeUserList,
  }) {
    print(likeUserList);
    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            stretch: false,
            expandedHeight: 200.0,
            flexibleSpace: FlexibleSpaceBar(
              stretchModes: <StretchMode>[
                StretchMode.zoomBackground,
                StretchMode.blurBackground,
                StretchMode.fadeTitle,
              ],
              collapseMode: CollapseMode.parallax,
              centerTitle: true,
              title: Hero(
                transitionOnUserGestures: true,
                tag: data.noticeTitle,
                child: SizedBox(
                  width: MediaQuery.of(context).size.width * 0.5,
                  child: Text(
                    data.noticeTitle,
                    style: Theme.of(context).textTheme.subtitle,
                  ),
                ),
              ),
              background: Stack(
                fit: StackFit.expand,
                children: [
                  data.hasImage
                      ? SizedBox.expand(
                          child: Hero(
                            transitionOnUserGestures: true,
                            child: Image.network(
                              data.firstImage,
                              fit: BoxFit.cover,
                            ),
                            tag: data.firstImage,
                          ),
                        )
                      : Image.asset(
                          'assets/images/home.png',
                          fit: BoxFit.cover,
                        ),
                  const DecoratedBox(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment(0.0, -1),
                        end: Alignment(0.0, 0.7),
                        colors: <Color>[
                          Color(0x60000000),
                          Color(0x00000000),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          CupertinoSliverRefreshControl(
            refreshTriggerPullDistance: 60,
            onRefresh: () async {
              await refresh(context);
            },
          ),
          SliverToBoxAdapter(
            child: Hero(
              transitionOnUserGestures: true,
              child: Text(data.noticeContent),
              tag: data.noticeContent,
            ),
          )
        ],
      ),
    );
  }

  Future refresh(BuildContext context) =>
      SkeletonTasksBuilder.of(context).refresh(context);
}
