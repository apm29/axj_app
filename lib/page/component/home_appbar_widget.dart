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
    var endColor = Theme.of(context).primaryColor;
    ColorTween tween1 = ColorTween(begin: Colors.transparent, end: endColor);
    ColorTween tween2 =
        ColorTween(begin: Colors.transparent, end: endColor.withAlpha(0xdd));
    var elevation = Curves.easeInExpo.transform(percent) * 8.0;
    var realElevation = elevation > 6.0 ? elevation : 0.0;

    Tween<double> sizeTween = Tween(
      begin: maxExtent,
      end: 0.0,
    );

    var textStyle = Theme.of(context).textTheme.title;

    var styleTween = TextStyleTween(
      begin: textStyle.copyWith(color: Colors.white),
      end: textStyle.copyWith(fontSize: 1),
    );

    var alpha = Curves.easeInExpo.transform(percent);

    return Stack(
      fit: StackFit.expand,
      children: <Widget>[
        Image.asset(
          'assets/images/login_banner.jpg',
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
                  tween1.transform(Curves.easeInExpo.transform(percent)),
                  tween2.transform(Curves.easeInExpo.transform(percent))
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
                  child: Row(
                    children: <Widget>[
                      IconButton(icon: Icon(Icons.more_vert), onPressed: null),
                      Expanded(
                        child: Container(
                          height: 36,
                          padding: EdgeInsets.only(left: 16),
                          decoration: BoxDecoration(
                              border: Border.all(color: Colors.grey),
                              borderRadius: BorderRadius.all(Radius.circular(6)),
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
                Container(
                  alignment: Alignment.center,
                  height: sizeTween.transform(percent),
                  child: Text(
                    S.of(context).appName,
                    style: styleTween.transform(Curves.easeInExpo.transform(percent)),
                  ),
                )
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
  double get minExtent => 48;

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) {
    return true;
  }
}
