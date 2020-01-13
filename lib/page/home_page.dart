import 'dart:math' as math;
import 'package:axj_app/redux/action/actions.dart';
import 'package:axj_app/generated/i18n.dart';
import 'package:axj_app/main.dart';
import 'package:axj_app/page/main_page.dart';
import 'package:axj_app/page/mine_page.dart';
import 'package:axj_app/route/route.dart';
import 'package:axj_app/redux/store/store.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_redux_dev_tools/flutter_redux_dev_tools.dart';

///
/// author : ciih
/// date : 2019-12-25 16:09
/// description : 参考 https://juejin.im/post/5d051a5b6fb9a07ec07fbdc5
///
class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StoreConnector<AppState, ActiveTab>(
        converter: (store) {
          return store.state.homePageState.currentTab;
        },
        builder: (ctx, currentTab) {
          switch (currentTab) {
            case ActiveTab.Home:
              return MainPage();
            case ActiveTab.Mine:
              return MinePage();
            default:
              throw Exception('Unknow index enum: $currentTab');
          }
        },
      ),
      bottomNavigationBar: buildBottomNavigationBar(context),
      endDrawer: Drawer(
        child: ReduxDevTools(store),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          AppRouter.toPersonal(context);
        },
        elevation: 10,
      ),
      extendBody: true,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }

  StoreConnector<AppState, int> buildBottomNavigationBar(BuildContext context) {
    var marginHorizontal = 12.0;
    return StoreConnector<AppState, int>(
      converter: (store) =>
          ActiveTab.values.indexOf(store.state.homePageState.currentTab),
      builder: (ctx, index) => Theme(
        data: Theme.of(context).copyWith(
          primaryColor: Color(0xff1a7fd5),
        ),
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: marginHorizontal),
          child: BottomAppBar(
            elevation: 12,
            shape: CircularNotchedRectangleWithMargin(marginHorizontal),
            clipBehavior: Clip.antiAlias,
            child: BottomNavigationBar(
              currentIndex: index,
              onTap: (index) {
                store.dispatch(TabSwitchAction(index, context));
              },
              items: [
                BottomNavigationBarItem(
                  icon: Icon(Icons.home),
                  title: Text(S.of(context).homeTab),
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.person),
                  title: Text(S.of(context).mineTab),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class CircularNotchedRectangleWithMargin extends NotchedShape {
  final double margin;

  const CircularNotchedRectangleWithMargin(this.margin);

  @override
  Path getOuterPath(Rect oldHost, Rect oldGuest) {
    Rect host = Rect.fromLTWH(
        oldHost.left + margin, 0, oldHost.width - 2 * margin, oldHost.height);
    Rect guest = Rect.fromLTRB(oldGuest.left - margin, oldGuest.top,
        oldGuest.right - margin, oldGuest.bottom);
    if (guest == null || !host.overlaps(guest)) return Path()..addRect(host);

    // The guest's shape is a circle bounded by the guest rectangle.
    // So the guest's radius is half the guest width.
    final double notchRadius = guest.width / 2.0;

    // We build a path for the notch from 3 segments:
    // Segment A - a Bezier curve from the host's top edge to segment B.
    // Segment B - an arc with radius notchRadius.
    // Segment C - a Bezier curve from segment B back to the host's top edge.
    //
    // A detailed explanation and the derivation of the formulas below is
    // available at: https://goo.gl/Ufzrqn

    const double s1 = 15.0;
    const double s2 = 1.0;

    final double r = notchRadius;
    final double a = -1.0 * r - s2;
    final double b = host.top - guest.center.dy;

    final double n2 = math.sqrt(b * b * r * r * (a * a + b * b - r * r));
    final double p2xA = ((a * r * r) - n2) / (a * a + b * b);
    final double p2xB = ((a * r * r) + n2) / (a * a + b * b);
    final double p2yA = math.sqrt(r * r - p2xA * p2xA);
    final double p2yB = math.sqrt(r * r - p2xB * p2xB);

    final List<Offset> p = List<Offset>(6);

    // p0, p1, and p2 are the control points for segment A.
    p[0] = Offset(a - s1, b);
    p[1] = Offset(a, b);
    final double cmp = b < 0 ? -1.0 : 1.0;
    p[2] = cmp * p2yA > cmp * p2yB ? Offset(p2xA, p2yA) : Offset(p2xB, p2yB);

    // p3, p4, and p5 are the control points for segment B, which is a mirror
    // of segment A around the y axis.
    p[3] = Offset(-1.0 * p[2].dx, p[2].dy);
    p[4] = Offset(-1.0 * p[1].dx, p[1].dy);
    p[5] = Offset(-1.0 * p[0].dx, p[0].dy);

    // translate all points back to the absolute coordinate system.
    for (int i = 0; i < p.length; i += 1) p[i] += guest.center;

    double tRadius = 12;

    return Path()
      ..moveTo(host.left + tRadius, host.top)
      ..lineTo(p[0].dx, p[0].dy)
      ..quadraticBezierTo(p[1].dx, p[1].dy, p[2].dx, p[2].dy)
      ..arcToPoint(
        p[3],
        radius: Radius.circular(notchRadius),
        clockwise: false,
      )
      ..quadraticBezierTo(p[4].dx, p[4].dy, p[5].dx, p[5].dy)
      ..lineTo(host.right - tRadius, host.top)
      ..arcToPoint(
        Offset(host.right, host.top + tRadius),
        radius: Radius.circular(tRadius),
      )
      ..lineTo(host.right, host.bottom)
      ..lineTo(host.left, host.bottom)
      ..lineTo(host.left, host.top + tRadius)
      ..arcToPoint(
        Offset(host.left + tRadius, host.top),
        radius: Radius.circular(tRadius),
      )
      ..close();
  }
}
