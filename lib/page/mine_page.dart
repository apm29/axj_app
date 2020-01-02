import 'package:axj_app/action/actions.dart';
import 'package:axj_app/generated/i18n.dart';
import 'package:axj_app/main.dart';
import 'package:axj_app/route/route.dart';
import 'package:axj_app/store/store.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';

///
/// author : ciih
/// date : 2019-12-26 10:15
/// description :
///
class MinePage extends StatelessWidget {
  final pageHorizontalPadding = 12.0;

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: <Widget>[
        const DecoratedBox(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment(0.0, -0.8),
              colors: <Color>[
                Color(0x33333333),
                Color(0x00000000),
              ],
            ),
          ),
        ),
        CustomScrollView(
          slivers: <Widget>[
            SliverSafeArea(
              sliver: SliverToBoxAdapter(
                child: buildUserProfileCard(),
              ),
            ),
            SliverPadding(
              padding: EdgeInsets.symmetric(horizontal: pageHorizontalPadding),
              sliver: SliverToBoxAdapter(
                child: ClosableSwitchSliver(),
              ),
            ),
            SliverPadding(
              padding: EdgeInsets.symmetric(horizontal: pageHorizontalPadding),
              sliver: SliverToBoxAdapter(
                child: ActionTile(
                  title: '我的房屋',
                  hint: '查看房屋信息',
                  iconData: CupertinoIcons.bell_solid,
                  onTap: () async {
                    store.dispatch(
                        CheckAuthAndRouteAction(context, Routes.myHouse));
                  },
                ),
              ),
            ),
            SliverPadding(
              padding: EdgeInsets.symmetric(horizontal: pageHorizontalPadding),
              sliver: SliverToBoxAdapter(
                child: ActionTile(
                  title: '家庭成员',
                  hint: '家庭成员,租客信息',
                  iconData: CupertinoIcons.group_solid,
                  onTap: () async {
                    await Future.delayed(Duration(seconds: 2));
                  },
                ),
              ),
            ),
            SliverPadding(
              padding: EdgeInsets.symmetric(horizontal: pageHorizontalPadding),
              sliver: SliverToBoxAdapter(
                child: ActionTile(
                  title: '我的爱车',
                  hint: '查看车辆信息',
                  iconData: CupertinoIcons.car,
                  onTap: () async {
                    await Future.delayed(Duration(seconds: 2));
                  },
                ),
              ),
            ),
            SliverPadding(
              padding: EdgeInsets.all(16),
              sliver: SliverToBoxAdapter(
                child: Text(
                  'Sliver在前面讲过，有细片、薄片之意，在Flutter中，Sliver'
                  '通常指可滚动组件子元素（就像一个个薄片一样）。但是在CustomScrollView中，需要粘起来的可滚动组件就是CustomScrollView的Sliver了，如果直接将ListView、GridView作为CustomScrollView是不行的，因为它们本身是可滚动组件而并不是Sliver！因此，为了能让可滚动组件能和CustomScrollView配合使用，Flutter提供了一些可滚动组件的Sliver版，如SliverList、SliverGrid等。实际上Sliver版的可滚动组件和非Sliver版的可滚动组件最大的区别就是前者不包含滚动模型（自身不能再滚动），而后者包含滚动模型 ，也正因如此，CustomScrollView才可以将多个Sliver"粘"在一起，这些Sliver共用CustomScrollView的Scrollable，所以最终才实现了统一的滑动效果。',
                ),
              ),
            ),
            SliverPadding(
              padding: EdgeInsets.all(16),
              sliver: SliverToBoxAdapter(
                child: Text(
                  'Sliver在前面讲过，有细片、薄片之意，在Flutter中，Sliver'
                  '通常指可滚动组件子元素（就像一个个薄片一样）。但是在CustomScrollView中，需要粘起来的可滚动组件就是CustomScrollView的Sliver了，如果直接将ListView、GridView作为CustomScrollView是不行的，因为它们本身是可滚动组件而并不是Sliver！因此，为了能让可滚动组件能和CustomScrollView配合使用，Flutter提供了一些可滚动组件的Sliver版，如SliverList、SliverGrid等。实际上Sliver版的可滚动组件和非Sliver版的可滚动组件最大的区别就是前者不包含滚动模型（自身不能再滚动），而后者包含滚动模型 ，也正因如此，CustomScrollView才可以将多个Sliver"粘"在一起，这些Sliver共用CustomScrollView的Scrollable，所以最终才实现了统一的滑动效果。',
                ),
              ),
            ),
            SliverPadding(
              padding: EdgeInsets.all(16),
              sliver: SliverToBoxAdapter(
                child: Text(
                  'Sliver在前面讲过，有细片、薄片之意，在Flutter中，Sliver'
                  '通常指可滚动组件子元素（就像一个个薄片一样）。但是在CustomScrollView中，需要粘起来的可滚动组件就是CustomScrollView的Sliver了，如果直接将ListView、GridView作为CustomScrollView是不行的，因为它们本身是可滚动组件而并不是Sliver！因此，为了能让可滚动组件能和CustomScrollView配合使用，Flutter提供了一些可滚动组件的Sliver版，如SliverList、SliverGrid等。实际上Sliver版的可滚动组件和非Sliver版的可滚动组件最大的区别就是前者不包含滚动模型（自身不能再滚动），而后者包含滚动模型 ，也正因如此，CustomScrollView才可以将多个Sliver"粘"在一起，这些Sliver共用CustomScrollView的Scrollable，所以最终才实现了统一的滑动效果。',
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  StoreConnector<AppState, UserState> buildUserProfileCard() {
    return StoreConnector<AppState, UserState>(
      converter: (store) => store.state.userState,
      builder: (context, userState) {
        return Container(
          margin: EdgeInsets.all(8),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Expanded(
                child: Stack(
                  children: <Widget>[
                    AbsorbPointer(
                      absorbing: !userState.login,
                      child: RoundCardButton(
                        child: Image.asset(
                          'assets/images/river.jpg',
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    Offstage(
                      offstage: !userState.login,
                      child: Align(
                        alignment: Alignment.topRight,
                        child: IconButton(
                          icon: Icon(
                            Icons.edit,
                            color: Colors.white,
                          ),
                          onPressed: () {},
                        ),
                      ),
                    ),
                    Visibility(
                      visible: userState.login,
                      child: Positioned(
                        bottom: 16,
                        left: 16,
                        child: DefaultTextStyle(
                          style: TextStyle(color: Colors.white),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                userState.login
                                    ? userState.userInfo?.nickName ??
                                        userState.userInfo?.userName??""
                                    : "",
                                style: TextStyle(
                                  fontSize: 20,
                                ),
                              ),
                              Text(
                                S.of(context).editUserProfile,
                                style: TextStyle(
                                  fontSize: 10,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Visibility(
                      visible: !userState.login,
                      child: Positioned.fromRelativeRect(
                        rect: RelativeRect.fill,
                        child: Center(
                          child: Text(
                            S.of(context).loginLabel,
                            style: TextStyle(
                                fontSize: 32,
                                fontWeight: FontWeight.w400,
                                color: Colors.white),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              Column(
                children: <Widget>[
                  Card(
                    elevation: 3,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(16))),
                    clipBehavior: Clip.antiAlias,
                    child: InkWell(
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 14.0,
                          vertical: 10.0,
                        ),
                        child: Column(
                          children: <Widget>[
                            Text(S.of(context).messageLabel),
                            Icon(
                              CupertinoIcons.mail,
                              size: 32,
                            ),
                          ],
                        ),
                      ),
                      onTap: () {},
                    ),
                  ),
                  Card(
                    elevation: 3,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(16))),
                    clipBehavior: Clip.antiAlias,
                    child: InkWell(
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16.0,
                          vertical: 10.0,
                        ),
                        child: Column(
                          children: <Widget>[
                            Text(S.of(context).settingLabel),
                            Icon(
                              CupertinoIcons.gear,
                              size: 32,
                            ),
                          ],
                        ),
                      ),
                      onTap: () {},
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}

class RoundCardButton extends StatelessWidget {
  final Widget child;
  final VoidCallback onTap;

  const RoundCardButton({
    Key key,
    @required this.child,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(16),
        ),
      ),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        child: child,
        onTap: () {
          onTap?.call();
        },
      ),
    );
  }
}

class ClosableSwitchSliver extends StatefulWidget {
  @override
  _ClosableSwitchSliverState createState() => _ClosableSwitchSliverState();
}

class _ClosableSwitchSliverState extends State<ClosableSwitchSliver> {
  bool hide = false;
  bool checked = false;

  @override
  Widget build(BuildContext context) {
    return Offstage(
      offstage: hide,
      child: Card(
        elevation: 3,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(6),
          ),
        ),
        clipBehavior: Clip.antiAlias,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Expanded(
                  child: Container(
                    color: Colors.grey[200],
                    padding: const EdgeInsets.only(
                        left: 8.0, right: 8.0, top: 4.0, bottom: 4.0),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: InkWell(
                        child: Icon(
                          Icons.close,
                          color: Colors.grey[400],
                        ),
                        onTap: () {
                          setState(() {
                            hide = true;
                          });
                        },
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: 12.0,
                      horizontal: 12.0,
                    ),
                    child: Text(
                      S.of(context).openNotificationHint,
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                ),
                CupertinoSwitch(
                  value: checked,
                  onChanged: (v) {
                    setState(() {
                      checked = v;
                    });
                  },
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class ActionTile extends StatefulWidget {
  final String title;
  final String hint;
  final IconData iconData;
  final AsyncCallback onTap;

  const ActionTile({Key key, this.title, this.hint, this.iconData, this.onTap})
      : super(key: key);

  @override
  _ActionTileState createState() => _ActionTileState();
}

class _ActionTileState extends State<ActionTile> {
  bool loading = false;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: loading
          ? null
          : () async {
              setState(() {
                loading = true;
              });
              await widget.onTap?.call();
              setState(() {
                loading = false;
              });
            },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 8, vertical: 16),
        child: Row(
          children: <Widget>[
            Icon(
              widget.iconData,
            ),
            SizedBox(
              width: 16,
            ),
            Text(
              widget.title,
              style: TextStyle(fontSize: 18),
            ),
            Expanded(
              child: Text(
                widget.hint,
                textAlign: TextAlign.end,
                style: Theme.of(context).textTheme.caption,
              ),
            ),
            SizedBox(
              width: 16,
            ),
            loading
                ? CupertinoActivityIndicator()
                : Icon(
                    Icons.arrow_forward_ios,
                    size: 20,
                    color: Colors.grey[400],
                  ),
          ],
        ),
      ),
    );
  }
}
