import 'package:axj_app/generated/i18n.dart';
import 'package:flutter/material.dart';

///
/// author : ciih
/// date : 2019-12-26 10:15
/// description : 
///
class MainPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(S.of(context).appName),
      ),
    );
  }
}
