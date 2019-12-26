import 'package:axj_app/action/actions.dart';
import 'package:axj_app/main_dev.dart';
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
        converter: (store) => store.state.homePageState.currentTab,
        distinct: true,
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
          StoreProvider.of<AppState>(context)
              .dispatch(TabSwitchAction(index, context));
        },
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            title: Text('主页'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            title: Text('我的'),
          ),
        ],
      ),
    );
  }
}
