import 'package:axj_app/model/api.dart';
import 'package:axj_app/redux/store/store.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

typedef ModelBuilder<T> = Widget Function(BuildContext context, T);
typedef ModelBuilder2<T, T1> = Widget Function(BuildContext context, T, T1);

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

class FutureTaskWidget2<T1, T2> extends StatelessWidget {
  final Future<T1> future1;
  final Future<T2> future2;
  final ModelBuilder2<T1, T2> modelBuilder;

  const FutureTaskWidget2(
      {Key key, this.future1, this.future2, this.modelBuilder})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List>(
      future: Future.wait([future1, future2]),
      builder: (BuildContext context, AsyncSnapshot<List> snapshot) {
        if (snapshot.hasData &&
            snapshot.connectionState == ConnectionState.done) {
          var data = snapshot.data;
          return modelBuilder(context, data[0] as T1, data[1] as T2);
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

class MultiFutureTaskWidget extends StatelessWidget {
  final List<Future> futures;
  final ModelBuilder<List> modelBuilder;

  const MultiFutureTaskWidget({Key key, this.futures, this.modelBuilder})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List>(
      future: Future.wait(futures),
      builder: (BuildContext context, AsyncSnapshot<List> snapshot) {
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

class BaseRespTaskBuilder2<T1, T2> extends StatelessWidget {
  final Future<BaseResp<T1>> future1;
  final Future<BaseResp<T2>> future2;
  final ModelBuilder2<T1, T2> modelBuilder;

  const BaseRespTaskBuilder2(
      {Key key, this.future1, this.future2, this.modelBuilder})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureTaskWidget2(
      future1: future1,
      future2: future2,
      modelBuilder: (context, resp1, resp2) {
        if (resp1.success && resp2.success) {
          var data1 = resp1.data as T1;
          var data2 = resp2.data as T2;
          return modelBuilder(context, data1, data2);
        } else {
          return Center(
            child: Text(resp1.text + resp2.text),
          );
        }
      },
    );
  }
}

class MultiBaseRespTaskBuilder extends StatelessWidget {
  final List<Future<BaseResp>> futures;
  final ModelBuilder<List<BaseResp>> modelBuilder;

  const MultiBaseRespTaskBuilder({Key key, this.futures, this.modelBuilder})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureTaskWidget<List<BaseResp>>(
      future: Future.wait(futures),
      modelBuilder: (context, List<BaseResp> resp) {
        if (resp.every((r) => r.success)) {
          return modelBuilder(context, resp);
        } else {
          return Center(
            child: Text(resp.firstWhere((r) => r.success).text),
          );
        }
      },
    );
  }
}
