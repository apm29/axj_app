import 'package:axj_app/action/actions.dart';
import 'package:axj_app/generated/i18n.dart';
import 'package:axj_app/main.dart';
import 'package:axj_app/page/main_page.dart';
import 'package:axj_app/page/mine_page.dart';
import 'package:axj_app/route/route.dart';
import 'package:axj_app/store/store.dart';
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
        child: Icon(Icons.settings),
        onPressed: () {
          AppRouter.toPersonal(context);
        },
      ),
    );
  }

  StoreConnector<AppState, int> buildBottomNavigationBar(BuildContext context) {
    return StoreConnector<AppState, int>(
      converter: (store) =>
          ActiveTab.values.indexOf(store.state.homePageState.currentTab),
      builder: (ctx, index) => BottomNavigationBar(
        currentIndex: index,
        onTap: (index) {
          store
              .dispatch(TabSwitchAction(index, context));
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
    );
  }
}
