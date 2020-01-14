import 'package:axj_app/page/component/gradient_background_widget.dart';
import 'package:axj_app/page/component/home_appbar_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

///
/// author : ciih
/// date : 2019-12-26 10:15
/// description :
///
class MainPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        GradientBackgroundWidget(),
        CustomScrollView(
          slivers: <Widget>[
//            SliverAppBar(
//              stretch: true,
//              onStretchTrigger: () {
//                // Function callback for stretch
//                return;
//              },
//              expandedHeight: 200.0,
//              flexibleSpace: FlexibleSpaceBar(
//                stretchModes: <StretchMode>[
//                  StretchMode.zoomBackground,
//                  StretchMode.blurBackground,
//                  StretchMode.fadeTitle,
//                ],
//                collapseMode: CollapseMode.parallax,
//                centerTitle: true,
//                title: Text(S.of(context).appName),
//                background: Stack(
//                  fit: StackFit.expand,
//                  children: [
//                    Image.asset(
//                      'assets/images/login_banner.jpg',
//                      fit: BoxFit.cover,
//                    ),
//                    const DecoratedBox(
//                      decoration: BoxDecoration(
//                        gradient: LinearGradient(
//                          begin: Alignment(0.0, -1),
//                          end: Alignment(0.0, 0.7),
//                          colors: <Color>[
//                            Color(0xF0000000),
//                            Color(0x00000000),
//                          ],
//                        ),
//                      ),
//                    ),
//                  ],
//                ),
//              ),
//            ),
            SliverPersistentHeader(
              delegate: HomeAppbarDelegate(),
              pinned: true,
            ),
            SliverToBoxAdapter(
              child: Text(
                'Sliver在前面讲过，有细片、薄片之意，在Flutter中，Sliver'
                '通常指可滚动组件子元素（就像一个个薄片一样）。但是在CustomScrollView中，需要粘起来的可滚动组件就是CustomScrollView的Sliver了，如果直接将ListView、GridView作为CustomScrollView是不行的，因为它们本身是可滚动组件而并不是Sliver！因此，为了能让可滚动组件能和CustomScrollView配合使用，Flutter提供了一些可滚动组件的Sliver版，如SliverList、SliverGrid等。实际上Sliver版的可滚动组件和非Sliver版的可滚动组件最大的区别就是前者不包含滚动模型（自身不能再滚动），而后者包含滚动模型 ，也正因如此，CustomScrollView才可以将多个Sliver"粘"在一起，这些Sliver共用CustomScrollView的Scrollable，所以最终才实现了统一的滑动效果。',
              ),
            ),
            SliverToBoxAdapter(
              child: Text(
                'Sliver在前面讲过，有细片、薄片之意，在Flutter中，Sliver'
                '通常指可滚动组件子元素（就像一个个薄片一样）。但是在CustomScrollView中，需要粘起来的可滚动组件就是CustomScrollView的Sliver了，如果直接将ListView、GridView作为CustomScrollView是不行的，因为它们本身是可滚动组件而并不是Sliver！因此，为了能让可滚动组件能和CustomScrollView配合使用，Flutter提供了一些可滚动组件的Sliver版，如SliverList、SliverGrid等。实际上Sliver版的可滚动组件和非Sliver版的可滚动组件最大的区别就是前者不包含滚动模型（自身不能再滚动），而后者包含滚动模型 ，也正因如此，CustomScrollView才可以将多个Sliver"粘"在一起，这些Sliver共用CustomScrollView的Scrollable，所以最终才实现了统一的滑动效果。',
              ),
            ),
            SliverToBoxAdapter(
              child: Text(
                'Sliver在前面讲过，有细片、薄片之意，在Flutter中，Sliver'
                '通常指可滚动组件子元素（就像一个个薄片一样）。但是在CustomScrollView'
                '中，需要粘起来的可滚动组件就是CustomScrollView的Sliver了，如果直接将ListView、GridView作为CustomScrollView是不行的，因为它们本身是可滚动组件而并不是Sliver！因此，为了能让可滚动组件能和CustomScrollView配合使用，Flutter提供了一些可滚动组件的Sliver版，如SliverList、SliverGrid等。实际上Sliver版的可滚动组件和非Sliver版的可滚动组件最大的区别就是前者不包含滚动模型（自身不能再滚动），而后者包含滚动模型 ，也正因如此，CustomScrollView才可以将多个Sliver"粘"在一起，这些Sliver共用CustomScrollView的Scrollable，所以最终才实现了统一的滑动效果。',
              ),
            ),
            SliverToBoxAdapter(
              child: Text(
                'Sliver在前面讲过，有细片、薄片之意，在Flutter中，Sliver'
                '通常指可滚动组件子元素（就像一个个薄片一样）。但是在CustomScrollView中，需要粘起来的可滚动组件就是CustomScrollView的Sliver了，如果直接将ListView、GridView作为CustomScrollView是不行的，因为它们本身是可滚动组件而并不是Sliver！因此，为了能让可滚动组件能和CustomScrollView配合使用，Flutter提供了一些可滚动组件的Sliver版，如SliverList、SliverGrid等。实际上Sliver版的可滚动组件和非Sliver版的可滚动组件最大的区别就是前者不包含滚动模型（自身不能再滚动），而后者包含滚动模型 ，也正因如此，CustomScrollView才可以将多个Sliver"粘"在一起，这些Sliver共用CustomScrollView的Scrollable，所以最终才实现了统一的滑动效果。',
              ),
            ),
          ],
        ),
      ],
    );
  }
}
