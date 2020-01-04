import 'package:axj_app/model/api.dart';
import 'package:axj_app/redux/store/store.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

typedef ModelBuilder<T> = Widget Function(BuildContext context, T);

class FutureTaskWidget<T> extends StatelessWidget {
  final Future<T> future;
  final ModelBuilder<T> modelBuilder;

  const FutureTaskWidget({Key key, this.future, this.modelBuilder})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<T>(
      future: future,
      builder: (BuildContext context, AsyncSnapshot<T> snapshot) {
        if (snapshot.hasData &&
            snapshot.connectionState == ConnectionState.done) {
          var data = snapshot.data;
          return modelBuilder(context, data);
        } else if (snapshot.hasError) {
          return Center(
            child: Text(getErrorMessage(snapshot.error)),
          );
        } else {
          return Center(
            child: CupertinoActivityIndicator(),
          );
        }
      },
    );
  }
}

class BaseRespTaskBuilder<T> extends StatelessWidget {
  final Future<BaseResp<T>> future;
  final ModelBuilder<T> modelBuilder;

  const BaseRespTaskBuilder({Key key, this.future, this.modelBuilder})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureTaskWidget<BaseResp<T>>(
      future: future,
      modelBuilder: (context, resp) {
        if (resp.success) {
          var data = resp.data;
          return modelBuilder(context, data);
        } else {
          return Center(
            child: Text(resp.text),
          );
        }
      },
    );
  }
}
