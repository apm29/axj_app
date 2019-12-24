import 'package:axj_app/splash/AppRedux.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';

void main() => runApp(FlutterReduxApp());

class FlutterReduxApp extends StatelessWidget {

  final Store<AppState> store = Store<AppState>(appReduce, initialState:AppState(0));

  FlutterReduxApp({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page',store:this.store),
    );
  }
}

class MyHomePage extends StatelessWidget {

  MyHomePage({Key key, this.title, this.store}) : super(key: key);
  final String title;
  final  Store<AppState> store;

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return StoreProvider<AppState>(
      store: store,
      child: Scaffold(
        appBar: AppBar(
          // Here we take the value from the MyHomePage object that was created by
          // the App.build method, and use it to set our appbar title.
          title: Text(title),
        ),
        body: Center(
          // Center is a layout widget. It takes a single child and positions it
          // in the middle of the parent.
          child: Column(
            // Column is also a layout widget. It takes a list of children and
            // arranges them vertically. By default, it sizes itself to fit its
            // children horizontally, and tries to be as tall as its parent.
            //
            // Invoke "debug painting" (press "p" in the console, choose the
            // "Toggle Debug Paint" action from the Flutter Inspector in Android
            // Studio, or the "Toggle Debug Paint" command in Visual Studio Code)
            // to see the wireframe for each widget.
            //
            // Column has various properties to control how it sizes itself and
            // how it positions its children. Here we use mainAxisAlignment to
            // center the children vertically; the main axis here is the vertical
            // axis because Columns are vertical (the cross axis would be
            // horizontal).
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                'You have pushed the button this many times:',
              ),
              StoreConnector<AppState, int>(
                converter: (store) => store.state.count,
                builder: (context, count) {
                  return Text(
                    count.toString(),
                    style: Theme.of(context).textTheme.display1,
                  );
                },
              )
            ],
          ),
        ),
        // Connect the Store to a FloatingActionButton. In this case, we'll
        // use the Store to build a callback that with dispatch an Increment
        // Action.
        //
        // Then, we'll pass this callback to the button's `onPressed` handler.
        floatingActionButton: StoreConnector<AppState, VoidCallback>(
          converter: (store) {
            // Return a `VoidCallback`, which is a fancy name for a function
            // with no parameters. It only dispatches an Increment action.
            return () => store.dispatch(AppActions.ENTER);
          },
          builder: (context, callback) {
            return FloatingActionButton(
              // Attach the `callback` to the `onPressed` attribute
              onPressed: callback,
              child: Icon(Icons.add),
            );
          },
        ),
      ),
    );
  }
}
