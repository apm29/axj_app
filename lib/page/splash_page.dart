import 'package:axj_app/redux/action/actions.dart';
import 'package:axj_app/generated/i18n.dart';
import 'package:axj_app/route/route.dart';
import 'package:axj_app/redux/store/store.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';

///
/// author : ciih
/// date : 2019-12-25 14:41
/// description :
///
class SplashPage extends StatefulWidget {
  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, AppState>(
      converter: (store) {
        return store.state;
      },
      onInit: (store) {
        store.dispatch(AppInitAction(context));
        () async {
          await Future.delayed(Duration(milliseconds: 4000));
          if (mounted) {
            AppRouter.toHomeAndReplaceSelf(context);
          }
        }();
      },
      builder: (context, state) {
        return Scaffold(
          body: SizedBox.expand(
            child: Stack(
              fit: StackFit.expand,
              children: <Widget>[
                Image.asset(
                  'assets/images/godness.jpg',
                  fit: BoxFit.cover,
                ),
                Align(
                  alignment: Alignment.topRight,
                  child: InkWell(
                    child: Container(
                      margin: EdgeInsets.all(24),
                      padding: EdgeInsets.all(10),
                      clipBehavior: Clip.antiAlias,
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.white),
                        borderRadius: BorderRadius.all(Radius.circular(100)),
                      ),
                      child: Text(
                        S.of(context).skipLabel,
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                    onTap: () {
                      AppRouter.toHomeAndReplaceSelf(context);
                    },
                  ),
                ),
              ],
            ),
          ),
          floatingActionButton: Builder(builder: (ctx) {
            return FloatingActionButton(
              child: Text('Dev'),
              onPressed: () {
                Scaffold.of(ctx).openEndDrawer();
              },
            );
          }),
        );
      },
    );
  }
}
