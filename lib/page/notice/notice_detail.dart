import 'dart:ui';

import 'package:axj_app/model/api.dart';
import 'package:axj_app/model/bean/notice/comment.dart';
import 'package:axj_app/model/bean/notice/comment_detail.dart';
import 'package:axj_app/model/bean/notice/notice.dart';
import 'package:axj_app/model/repository.dart';
import 'package:axj_app/page/component/future_task_widget.dart';
import 'package:axj_app/page/modal/task_modal.dart';
import 'package:axj_app/page/transition/auto_transition.dart';
import 'package:axj_app/redux/store/store.dart';
import 'package:axj_app/utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';

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
          Repository.getNoticeComments(notice.noticeId.toString()),
        ];
      },
      builder: (context, data) {
        var noticeDetail = data[0].data;
        var likeUserList = data[1].data;
        CommentData commentList = data[2].data.comment;
        return buildScaffold(context, noticeDetail,
            likeUserList: likeUserList, commentList: commentList);
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
    CommentData commentList,
  }) {
    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          buildSliverAppBar(data, context),
          CupertinoSliverRefreshControl(
            refreshTriggerPullDistance: 60,
            onRefresh: () async {
              await refresh(context);
            },
          ),
          SliverPadding(
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            sliver: SliverList(
              delegate: SliverChildListDelegate(
                [
                  Text(
                    formattedTime(notice?.createTime ?? '--'),
                    style: Theme.of(context).textTheme.caption,
                  ),
                  SizedBox(
                    width: 18,
                  ),
                  Text(
                    notice?.noticeTitle ?? '--',
                    style: Theme.of(context).textTheme.subtitle.copyWith(
                        fontFeatures: [FontFeature.oldstyleFigures()]),
                  ),
                  Divider(),
                  Row(
                    children: <Widget>[
                      InkWell(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8.0),
                          child: Row(
                            children: <Widget>[
                              Icon(
                                Icons.thumb_up,
                                size: 18,
                              ),
                              SizedBox(
                                width: 8,
                              ),
                              Text((likeUserList?.length ?? 0).toString())
                            ],
                          ),
                        ),
                        onTap: () async {
                          await addLike(context, data.noticeId.toString());
                          refresh(context);
                        },
                      ),
                      SizedBox(
                        width: 18,
                      ),
                      InkWell(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8.0),
                          child: Row(
                            children: <Widget>[
                              Icon(
                                Icons.message,
                                size: 18,
                              ),
                              SizedBox(
                                width: 8,
                              ),
                              Text((commentList?.all?.length ?? 0).toString())
                            ],
                          ),
                        ),
                        onTap: () {},
                      ),
                    ],
                  ),
                  Hero(
                    transitionOnUserGestures: true,
                    child: AutoSizeInTransition(
                      child: Text(data.noticeContent),
                    ),
                    tag: data.noticeContent,
                  ),
                  SizedBox(
                    height: 32,
                  ),
                  ...buildCommentList(commentList, context)
                ],
              ),
            ),
          )
        ],
      ),
      bottomNavigationBar: CommentWidget(
        notice: notice,
        afterComment: () => refresh(context),
      ),
    );
  }

  List<Widget> buildCommentList(CommentData commentList, BuildContext context) {
    if (commentList == null ||
        commentList.all == null ||
        commentList.all.isEmpty) {
      return [];
    }
    return commentList.all.map((c) => buildCommentItem(c, context)).toList();
  }

  Widget buildCommentItem(Comment c, BuildContext context) {
    return Column(
      children: <Widget>[
        Row(
          children: <Widget>[
            CircleAvatar(
              backgroundColor: Theme.of(context).colorScheme.onSurface,
              child: Text(c.nickName.substring(0, 1)),
            ),
            SizedBox(
              width: 12,
            ),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.max,
                children: <Widget>[
                  SizedBox(
                    height: 12,
                  ),
                  Text(
                    c.nickName,
                    style: Theme.of(context).textTheme.subhead,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Text(
                      c.content,
                      style: Theme.of(context).textTheme.caption,
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: <Widget>[
                      Text(
                        formattedTime(c.time),
                        style: Theme.of(context).textTheme.overline,
                      ),
                      SizedBox(
                        width: 12,
                      ),
                      Icon(
                        Icons.calendar_today,
                        size: 12,
                      )
                    ],
                  ),
                  SizedBox(
                    height: 12,
                  ),
                ],
              ),
            ),
          ],
        ),
        Divider(
          height: 0.1,
          indent: 48,
        ),
      ],
    );
  }

  SliverAppBar buildSliverAppBar(Notice data, BuildContext context) {
    return SliverAppBar(
      stretch: false,
      expandedHeight: 200.0,
      flexibleSpace: FlexibleSpaceBar(
        stretchModes: <StretchMode>[
          StretchMode.zoomBackground,
          StretchMode.blurBackground,
          StretchMode.fadeTitle,
        ],
        collapseMode: CollapseMode.parallax,
        title: Hero(
          transitionOnUserGestures: true,
          tag: data.noticeTitle,
          child: SizedBox(
            width: MediaQuery.of(context).size.width * 0.5,
            child: Text(
              data.noticeTitle,
              style: Theme.of(context)
                  .textTheme
                  .subtitle
                  .copyWith(color: Colors.white, wordSpacing: 20),
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
    );
  }

  Future refresh(BuildContext context) =>
      SkeletonTasksBuilder.of(context).refresh(context);

  Future addLike(BuildContext context, String noticeId) =>
      Navigator.of(context).push(
        TaskModal(() async {
          BaseResp resp = await Repository.addNoticeLike(noticeId);
          showAppToast(resp.success ? '成功' : resp.text);
        }),
      );
}

class CommentWidget extends StatefulWidget {
  final VoidCallback afterComment;

  const CommentWidget({
    Key key,
    @required this.notice,
    this.afterComment,
  }) : super(key: key);

  final Notice notice;

  @override
  _CommentWidgetState createState() => _CommentWidgetState();
}

class _CommentWidgetState extends State<CommentWidget> {
  TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, bool>(
        converter: (store) => store.state.userState.login,
        builder: (context, login) {
          return login
              ? Material(
                  type: MaterialType.card,
                  color: Theme.of(context).colorScheme.surface,
                  child: Container(
                    height: 64,
                    padding: EdgeInsets.symmetric(vertical: 6, horizontal: 12),
                    child: Row(
                      children: <Widget>[
                        Expanded(
                          child: TextField(
                            controller: controller,
                            decoration: InputDecoration(
                                border: OutlineInputBorder(),
                                hintText: '说点什么吧'),
                          ),
                        ),
                        FlatButton(
                          child: Text(
                            '发送',
                            style: TextStyle(
                                color: Theme.of(context).colorScheme.onSurface),
                          ),
                          onPressed: () {
                            addComment(
                              context,
                              widget.notice.noticeId.toString(),
                              controller.text,
                            );
                          },
                        )
                      ],
                    ),
                  ),
                )
              : Container(
            height: 0,
          );
        });
  }

  Future addComment(BuildContext context, String noticeId, String content) =>
      Navigator.of(context).push(
        TaskModal(() async {
          if (content == null || content.isEmpty) {
            showAppToast('请输入内容');
            return;
          }
          BaseResp resp = await Repository.addNoticeComments(noticeId, content);
          showAppToast(resp.success ? '成功' : resp.text);
          controller.clear();
          widget.afterComment?.call();
        }),
      );
}
