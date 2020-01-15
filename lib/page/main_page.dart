import 'package:axj_app/page/component/gradient_background_widget.dart';
import 'package:axj_app/page/component/home_appbar_widget.dart';
import 'package:axj_app/page/component/skeleton_widget.dart';
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
    return GradientBackgroundWidget(
      child: CustomScrollView(
        slivers: <Widget>[
          SliverPersistentHeader(
            delegate: HomeAppbarDelegate(),
            pinned: true,
          ),
          SliverToBoxAdapter(
            child: SkeletonWidget(skeletonType: SkeletonType.Card,),
          ),
          SliverToBoxAdapter(
            child: SkeletonWidget(skeletonType: SkeletonType.Card,),
          ),
          SliverToBoxAdapter(
            child: SkeletonWidget(skeletonType: SkeletonType.Card,),
          ),
          SliverToBoxAdapter(
            child: SkeletonWidget(skeletonType: SkeletonType.Card,),
          ),

        ],
      ),
    );
  }
}
