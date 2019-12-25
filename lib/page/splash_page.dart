import 'package:axj_app/action/actions.dart';
import 'package:axj_app/main_dev.dart';
import 'package:axj_app/store/store.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_redux_dev_tools/flutter_redux_dev_tools.dart';

///
/// author : ciih
/// date : 2019-12-25 14:41
/// description :
///
class SplashPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, AppState>(
      converter: (store) {
        return store.state;
      },
      onInit: (store) {
        store.dispatch(AppInitAction(context));
      },
      builder: (context, state) {
        return Scaffold(
          endDrawer: Drawer(
            child: ReduxDevTools(store),
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
