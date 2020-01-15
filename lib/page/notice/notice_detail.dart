import 'package:axj_app/generated/i18n.dart';
import 'package:axj_app/model/api.dart';
import 'package:axj_app/model/bean/notice/notice.dart';
import 'package:axj_app/model/repository.dart';
import 'package:axj_app/page/component/future_task_widget.dart';
import 'package:flutter/material.dart';

class NoticeDetailPage extends StatelessWidget {
  final String noticeId;
  final Notice notice;

  const NoticeDetailPage({Key key, this.noticeId, this.notice})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return (notice != null)
        ? buildScaffold(notice, context)
        : TaskBuilder(
            task: () async => [
              await Repository.getNoticeDetail(noticeId),
            ],
            modelBuilder: (context, model) {
              Notice data = model[0].data;
              return buildScaffold(data, context);
            },
          );
  }

  Scaffold buildScaffold(Notice data, BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            stretch: true,
            onStretchTrigger: () {
              // Function callback for stretch
              return;
            },
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
                            child: Image.network(
                              data.firstImage,
                              fit: BoxFit.cover,
                            ),
                            tag: data.firstImage,
                          ),
                        )
                      : Container(),
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
          SliverToBoxAdapter(
            child: Hero(
              child: Text(data.noticeContent),
              tag: data.noticeContent,
            ),
          )
        ],
      ),
    );
  }
}
