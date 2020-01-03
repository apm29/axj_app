import 'package:axj_app/generated/i18n.dart';
import 'package:axj_app/model/bean/house.dart';
import 'package:axj_app/redux/store/store.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';

class MyHousePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(S.of(context).myHouseTitle),
      ),
      body: StoreConnector<AppState,List<House>>(
        converter: (store) {
          return store.state.userState.userInfo.house;
        },
        builder: (context, model) {
          return ListView(
            children: model.map((house){
              return Text(house.toString());
            }).toList(),
          );
        },
      ),
    );
  }
}
