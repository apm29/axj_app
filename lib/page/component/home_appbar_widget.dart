import 'dart:ui';

import 'package:axj_app/generated/i18n.dart';
import 'package:flutter/material.dart';

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
  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    double percent = shrinkOffset / (maxExtent - minExtent);
    percent = percent.clamp(0.0, 1.0);
    final Color endColor = Theme.of(context).primaryColor.withAlpha(0xdd);
    final ColorTween tween1 =
        ColorTween(begin: Colors.transparent, end: endColor);
    final ColorTween tween2 =
        ColorTween(begin: Colors.transparent, end: endColor.withAlpha(0xdd));
    double easeInExpoPercent = Curves.easeInExpo.transform(percent);
    final double elevation = easeInExpoPercent * 8.0;
    final double realElevation = elevation > 6.0 ? elevation : 0.0;

    final Tween<double> sizeTween = Tween(
      begin: maxExtent,
      end: 0.0,
    );
    final double bottomHeight = 80.0;
    final Tween<double> buttonSizeTween = Tween(
      begin: bottomHeight,
      end: 0.0,
    );

    final TextStyle textStyle = Theme.of(context).textTheme.title;

    final TextStyleTween styleTween = TextStyleTween(
      begin: textStyle.copyWith(color: Colors.white),
      end: textStyle.copyWith(
        fontSize: 1,
        color: Colors.white.withAlpha(0x00),
      ),
    );
    double alpha = easeInExpoPercent;

    final TextStyle buttonTextStyle = Theme.of(context).textTheme.caption;
    final TextStyleTween buttonStyleTween = TextStyleTween(
      begin: buttonTextStyle.copyWith(color: Colors.white70),
      end: buttonTextStyle.copyWith(
        fontSize: 1,
        color: Colors.white70.withAlpha(0x00),
      ),
    );

    final buttonTextList = ["访客管理", "找警察", "找物业", "找客服"];
    final buttonIconList = [
      Icons.person_outline,
      Icons.lock_outline,
      Icons.lightbulb_outline,
      Icons.help_outline
    ];

    final double buttonSize = 18.0;
    final double buttonMargin = 12.0;
    double systemPadding = 20.0;
    final marginBottomOfButtons = Tween(
        begin: (bottomHeight - buttonSize) / 2.0,
        end: (minExtent - buttonSize - systemPadding) / 2.0);

    final screenWidth = MediaQuery.of(context).size.width;
    int buttonCount = buttonTextList.length;
    // |--buttonHorizontalDistance--|--buttonMargin--|--buttonSize+TextWidth--|--buttonMargin--|
    double textLength = buttonTextList
        .map(
          (s) =>
              calcTrueTextSize(buttonStyleTween.transform(percent).fontSize, s),
        )
        .reduce((sum, size) => sum + size);
    //底部button平均间距
    final buttonHorizontalDistance = (screenWidth -
            buttonCount * buttonSize -
            2 * buttonCount * buttonMargin -
            textLength) /
        (buttonCount + 1);

    final Function calculateButtonLeftAtBottom = (int index) {
      double distance = buttonHorizontalDistance * (index + 1);
      num body = (index == 0
              ? 0
              : buttonTextList
                  .sublist(0, index)
                  .map(
                    (s) => calcTrueTextSize(
                        buttonStyleTween.transform(percent).fontSize, s),
                  )
                  .reduce((sum, size) => sum + size)) +
          buttonSize * index;
      return distance + body + (2 * index) * buttonMargin;
    };

    final Function calculateButtonLeftAtTop = (int index) {
      return (buttonSize + 2 * buttonMargin) * index;
    };

    final ColorTween iconColorTween = ColorTween(
      begin: Colors.white70,
      end: Colors.grey,
    );

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
              end: Alignment(0.0, 0.7),
              colors: <Color>[
                Color(0xF0000000),
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
              backgroundBlendMode: BlendMode.screen,
            ),
            child: Stack(
              children: <Widget>[
                Opacity(
                  opacity: alpha,
                  child: Padding(
                    padding: EdgeInsets.only(top: systemPadding),
                    child: Row(
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
                                border: Border.all(color: Colors.grey),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(6)),
                                color: Colors.grey[200]),
                            alignment: Alignment.centerLeft,
                            child: Text(
                              "搜索",
                              style: Theme.of(context).textTheme.caption,
                            ),
                          ),
                        ),
                        IconButton(icon: Icon(Icons.search), onPressed: null),
                      ],
                    ),
                  ),
                ),
                Container(
                  alignment: Alignment(0.0, -.1),
                  height: sizeTween.transform(percent),
                  child: Text(
                    S.of(context).appName,
                    style: styleTween
                        .transform(easeInExpoPercent),
                  ),
                ),
                Container(
                  alignment: Alignment(0.0, 1.0),
                  child: SizedBox(
                    height: buttonSizeTween.transform(percent),
                    child: ClipRect(
                      child: BackdropFilter(
                        filter: ImageFilter.blur(
                          sigmaX: 8.0,
                          sigmaY: 8.0,
                        ),
                        child: Container(
                          width: MediaQuery.of(context).size.width,
                          height: buttonSizeTween.transform(percent),
                          decoration: BoxDecoration(
                              color: Colors.black.withAlpha(0x55)),
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
                        ).transform( easeInExpoPercent),
                        child: InkWell(
                          onTap: (){},
                          child: Row(
                            children: <Widget>[
                              Container(
                                width: buttonMargin,
                              ),
                              Icon(
                                buttonIconList[buttonTextList.indexOf(s)],
                                size: buttonSize,
                                color: iconColorTween.transform( easeInExpoPercent),
                              ),
                              Container(
                                width: buttonMargin,
                              ),
                              Text(
                                s,
                                style: buttonStyleTween.transform(
                                    easeInExpoPercent),
                              ),
                            ],
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
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) {
    return true;
  }

  double calcTrueTextSize(double textSize, String text) {
    // 测量实际长度
    var paragraph = ParagraphBuilder(ParagraphStyle(fontSize: textSize))
      ..addText(text);
    var p = paragraph.build()
      ..layout(ParagraphConstraints(width: double.infinity));
    return p.minIntrinsicWidth;
  }
}
