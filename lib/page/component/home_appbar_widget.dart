import 'dart:ui';
import 'package:axj_app/generated/l10n.dart';
import 'package:axj_app/redux/action/actions.dart';
import 'package:axj_app/redux/store/store.dart';
import 'package:axj_app/route/route.dart';
import 'package:axj_app/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_redux/flutter_redux.dart';

///
/// author : ciih
/// date : 2020-01-14 16:10
/// description :
///
class HomeAppbarWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

class HomeAppbarDelegate extends SliverPersistentHeaderDelegate {
  final double buttonSize = 18.0;
  final double buttonMargin = 12.0;
  final double systemPadding = 20.0;
  final buttonTextList = ["访客管理", "找警察", "找物业", "找客服"];
  final buttonIconList = [
    Icons.person_outline,
    Icons.lock_outline,
    Icons.lightbulb_outline,
    Icons.help_outline
  ];

  double currentOffset;

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    double percent = shrinkOffset / (maxExtent - minExtent);
    percent = percent.clamp(0.0, 1.0);
    currentOffset = shrinkOffset;
    final Color endColor = Theme.of(context).colorScheme.surface;
    final ColorTween tween1 =
        ColorTween(begin: Colors.transparent, end: endColor);
    final ColorTween tween2 =
        ColorTween(begin: Colors.transparent, end: endColor.withAlpha(0xdd));
    double easeInExpoPercent = Curves.easeInExpo.transform(percent);
    //Appbar顶框高度
    final double elevation = easeInExpoPercent * 8.0;
    final double realElevation = elevation > 6.0 ? elevation : 0.0;
    final double bottomHeight = 80.0;
    final Tween<double> buttonSizeTween = Tween(
      begin: bottomHeight,
      end: 0.0,
    );
    final Tween<double> sizeTween = Tween(
      begin: maxExtent - bottomHeight,
      end: 0.0,
    );

    final TextStyle textStyle = Theme.of(context).textTheme.title;

    final TextStyleTween styleTween = TextStyleTween(
      begin: textStyle.copyWith(color: Colors.white),
      end: textStyle.copyWith(
        fontSize: 0,
        color: Colors.white.withAlpha(0x00),
      ),
    );
    double alpha = easeInExpoPercent;

    Tween<double> fadeTween = Tween(begin: 1.0, end: 0.0);

    final TextStyle buttonTextStyle = Theme.of(context).textTheme.caption;
    final TextStyleTween buttonStyleTween = TextStyleTween(
      begin: buttonTextStyle.copyWith(color: Colors.white70),
      end: buttonTextStyle.copyWith(
        fontSize: 0,
        color: Colors.white70.withAlpha(0x00),
      ),
    );

    Color onSurface = Theme.of(context).colorScheme.onSurface;

    final marginBottomOfButtons = Tween(
      begin: 0.0, //(bottomHeight - buttonSize) / 2.0,
      end: 0.0, //(minExtent - buttonSize - systemPadding) / 2.0
    );
    final screenWidth = MediaQuery.of(context).size.width;
    int buttonCount = buttonTextList.length;
    // |--buttonHorizontalDistance--|--buttonMargin--|--buttonSize+TextWidth--|--buttonMargin--|
    double textLength = buttonTextList
        .map(
          (s) => calcTrueTextWidth(
              buttonStyleTween.transform(percent).fontSize, s),
        )
        .reduce((sum, size) => sum + size);
    //底部button平均间距
    final buttonHorizontalDistance = (screenWidth -
            buttonCount * buttonSize -
            2 * buttonCount * buttonMargin -
            textLength) /
        (buttonCount * 2);

    final Tween<double> buttonHPaddingTween =
        Tween(begin: buttonHorizontalDistance, end: 0.0);
    final Tween<double> buttonVPaddingTween = Tween(
      begin: (bottomHeight - buttonSize) / 2.0,
      end: (minExtent - systemPadding - buttonSize) / 2,
    );
    final Function calculateButtonLeftAtBottom = (int index) {
      return (index == 0
          ? 0.0
          : buttonTextList.sublist(0, index).map(
              (s) {
                return calcTrueTextWidth(
                        buttonStyleTween.transform(percent).fontSize, s) +
                    buttonSize +
                    2 * buttonMargin +
                    2 * buttonHorizontalDistance;
              },
            ).reduce((sum, size) => sum + size));
    };

    final Function calculateButtonLeftAtTop = (int index) {
      return (buttonSize + 2 * buttonMargin) * index;
    };

    final ColorTween iconColorTween = ColorTween(
      begin: Colors.white70,
      end: onSurface,
      //end: Theme.of(context).accentColor,
    );

    Color blurForeground = Theme.of(context).colorScheme.surface.withAlpha(77);
    return Stack(
      fit: StackFit.expand,
      children: <Widget>[
        Image.asset(
          'assets/images/home.png',
          fit: BoxFit.cover,
        ),
        const DecoratedBox(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment(0.0, -1),
              end: Alignment(0.0, 0.0),
              colors: <Color>[
                Color(0x70000000),
                Color(0x00000000),
              ],
            ),
          ),
        ),
        Material(
          elevation: realElevation,
          color: Colors.transparent,
          clipBehavior: Clip.antiAlias,
          child: Container(
            alignment: Alignment.topCenter,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  tween1.transform(easeInExpoPercent),
                  tween2.transform(easeInExpoPercent)
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
            child: Stack(
              children: <Widget>[
                Opacity(
                  opacity: alpha,
                  child: Padding(
                    padding: EdgeInsets.only(
                        top: systemPadding +
                            (minExtent - systemPadding - 36) / 2.0,
                        right: 16),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        SizedBox(
                          width: buttonMargin * buttonCount * 2 +
                              buttonSize * buttonCount,
                        ),
                        Expanded(
                          child: Container(
                            height: 36,
                            padding: EdgeInsets.only(left: 16),
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: onSurface,
                              ),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(6)),
                              color: Theme.of(context).colorScheme.surface,
                            ),
                            alignment: Alignment.centerLeft,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Expanded(
                                  child: Text(
                                    "搜索",
                                    style: Theme.of(context)
                                        .textTheme
                                        .caption
                                        .copyWith(
                                          color: onSurface,
                                        ),
                                  ),
                                ),
                                IconButton(
                                  icon: Icon(
                                    Icons.search,
                                    size: buttonSize,
                                  ),
                                  onPressed: null,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
                  alignment: Alignment(0.0, 0.0),
                  height: sizeTween.transform(percent),
                  child: Text(
                    S.of(context).appName,
                    style: styleTween.transform(easeInExpoPercent),
                  ),
                ),
                Container(
                  alignment: Alignment(0.0, 1.0),
                  child: Opacity(
                    opacity: fadeTween.transform(easeInExpoPercent),
                    child: ClipRect(
                      child: BackdropFilter(
                        filter: ImageFilter.blur(
                          sigmaX: 8.0,
                          sigmaY: 8.0,
                        ),
                        child: Container(
                          width: MediaQuery.of(context).size.width,
                          height: bottomHeight,
                          decoration: BoxDecoration(
                            //color: Colors.black.withAlpha(0x55),
                            color: blurForeground,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                ...buttonTextList
                    .map(
                      (s) => Positioned(
                        bottom: marginBottomOfButtons.transform(percent),
                        left: Tween(
                          begin: calculateButtonLeftAtBottom(
                              buttonTextList.indexOf(s)),
                          end: calculateButtonLeftAtTop(
                              buttonTextList.indexOf(s)),
                        ).transform(easeInExpoPercent),
                        child: InkWell(
                          onTap: () {
                            var buttonIndex = buttonTextList.indexOf(s);
                            if(buttonIndex==0){
                              _toVisitorManage(context);
                            }
                          },
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                              horizontal: buttonHPaddingTween
                                  .transform(easeInExpoPercent),
                              vertical: buttonVPaddingTween
                                  .transform(easeInExpoPercent),
                            ),
                            child: Row(
                              children: <Widget>[
                                Container(
                                  width: buttonMargin,
                                ),
                                Icon(
                                  buttonIconList[buttonTextList.indexOf(s)],
                                  size: buttonSize,
                                  color: iconColorTween
                                      .transform(easeInExpoPercent),
                                ),
                                Container(
                                  width: buttonMargin,
                                ),
                                Text(
                                  s,
                                  style: buttonStyleTween
                                      .transform(easeInExpoPercent),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    )
                    .toList()
              ],
            ),
          ),
        ),
      ],
    );
  }

  @override
  double get maxExtent => 200;

  @override
  double get minExtent => 68;

  @override
  bool shouldRebuild(HomeAppbarDelegate oldDelegate) {
    return false;
  }

  @override
  OverScrollHeaderStretchConfiguration get stretchConfiguration {
    return OverScrollHeaderStretchConfiguration(
      stretchTriggerOffset: 100,
      onStretchTrigger: () async {
        print('trigger');
      },
    );
  }

  _toVisitorManage(BuildContext context) {
    StoreProvider.of<AppState>(context).dispatch(
      CheckHouseAndRouteAction(context,routeName: Routes.visitorManage),
    );
  }
}
