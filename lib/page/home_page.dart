import 'package:axj_app/action/actions.dart';
import 'package:axj_app/store/store.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';

///
/// author : ciih
/// date : 2019-12-25 16:09
/// description :
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
              return buildHome();
            case ActiveTab.Mine:
              return buildMine();
            default:
              throw Exception('Unknow index enum: $currentTab');
          }
        },
      ),
      bottomNavigationBar: buildBottomNavigationBar(context),
    );
  }

  StoreConnector<AppState, int> buildBottomNavigationBar(BuildContext context) {
    return StoreConnector<AppState, int>(
      converter: (store) =>
          ActiveTab.values.indexOf(store.state.homePageState.currentTab),
      builder: (ctx, index) => BottomNavigationBar(
        currentIndex: index,
        onTap: (index) {
          StoreProvider.of<AppState>(context).dispatch(TabSwitchAction(index));
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

  Widget buildHome() {
    return Center(
      child: Text('Home'),
    );
  }

  Widget buildMine() {
    return Center(
      child: Text('Mine'),
    );
  }
}
