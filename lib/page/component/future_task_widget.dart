import 'package:axj_app/model/api.dart';
import 'package:axj_app/redux/action/actions.dart';
import 'package:axj_app/redux/store/store.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';

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

@deprecated
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

class TaskBuilder extends StatefulWidget {
  final AsyncResultTask<List<BaseResp>> task;
  final ModelBuilder<List<BaseResp>> modelBuilder;
  final bool pullToRefresh;

  const TaskBuilder({
    Key key,
    this.task,
    this.modelBuilder,
    this.pullToRefresh: true,
  }) : super(key: key);

  @override
  TaskBuilderState createState() => TaskBuilderState();

  static TaskBuilderState of(BuildContext context) {
    return context.findAncestorStateOfType<TaskBuilderState>();
  }
}

class TaskBuilderState extends State<TaskBuilder> {
  Future future;
  String refreshToken;

  @override
  void initState() {
    future = widget.task();
    refreshToken = hashCode.toString() + DateTime.now().toIso8601String();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: StoreBuilder<AppState>(
        builder: (context, store) {
          if (store.state.needRefresh(refreshToken)) {
            future = widget.task();
            store.state.cancelRefresh(refreshToken);
          }
          return FutureBuilder(
            future: future,
            builder: (context, snapshot) {
              return AnimatedSwitcher(
                child: buildChild(context, snapshot),
                transitionBuilder: (child, animation) {
                  return SlideTransition(
                    position: Tween<Offset>(
                      begin: const Offset(1.0, 0.0),
                      end: Offset.zero,
                    ).animate(animation),
                    child: child,
                  );
                },
                duration: Duration(milliseconds: 200),
              );
            },
          );
        },
      ),
    );
  }

  Future refresh(BuildContext context) async {
    await Future.delayed(Duration(milliseconds: 800));
    await StoreProvider.of<AppState>(context)
        .dispatch(RefreshAction(refreshToken));
  }

  bool _waiting(AsyncSnapshot snapshot) =>
      snapshot.connectionState != ConnectionState.done && !snapshot.hasError;

  bool _success(AsyncSnapshot snapshot) {
    return snapshot.hasData && snapshot.connectionState == ConnectionState.done;
  }

  buildChild(BuildContext context, AsyncSnapshot<dynamic> snapshot) {
    if (_waiting(snapshot)) {
      return LayoutBuilder(
        builder: (c, constraint) {
          return SizedBox(
            width: constraint.maxWidth == double.infinity
                ? MediaQuery.of(context).size.width
                : double.infinity,
            height: constraint.maxHeight == double.infinity
                ? MediaQuery.of(context).size.height
                : double.infinity,
            child: Center(
              child: CupertinoActivityIndicator(),
            ),
          );
        },
      );
    } else if (_success(snapshot)) {
      var buildLayout = widget.modelBuilder(context, snapshot.data);
      return widget.pullToRefresh
          ? RefreshIndicator(
              onRefresh: () async {
                await refresh(context);
              },
              child: buildLayout,
            )
          : buildLayout;
    } else {
      return InkWell(
        child: ErrorHintWidget(
          errors: [getErrorMessage(snapshot.error)],
          refreshToken: refreshToken,
        ),
      );
    }
  }
}

class ErrorHintWidget extends StatelessWidget {
  final List<String> errors;
  final String refreshToken;

  const ErrorHintWidget({Key key, this.errors, this.refreshToken})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => StoreProvider.of<AppState>(context)
          .dispatch(RefreshAction(refreshToken)),
      child: Container(
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text("轻点重试"),
                SizedBox(
                  width: 12,
                ),
                Icon(Icons.refresh),
              ],
            ),
            ...errors
                .map(
                  (e) => Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      e,
                      style: Theme.of(context).textTheme.caption,
                    ),
                  ),
                )
                .toList(),
          ],
        ),
      ),
    );
  }
}
