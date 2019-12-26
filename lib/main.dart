import 'package:axj_app/action/actions.dart';
import 'package:axj_app/middleware/middlewares.dart';
import 'package:axj_app/model/cache.dart';
import 'package:axj_app/page/splash_page.dart';
import 'package:axj_app/store/store.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:oktoast/oktoast.dart';
import 'package:redux/redux.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Cache().init();
  runApp(FlutterReduxApp());
}

final Store<AppState> store = Store<AppState>(
  appReduce,
  initialState: AppState(),
  middleware: createAppMiddleware(),
);

class FlutterReduxApp extends StatelessWidget {


  FlutterReduxApp({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StoreProvider(
      store: store,
      child: OKToast(
        child: MaterialApp(
          title: 'Flutter Demo',
          theme: ThemeData(
            // This is the theme of your application.
            //
            // Try running your application with "flutter run". You'll see the
            // application has a blue toolbar. Then, without quitting the app, try
            // changing the primarySwatch below to Theme.of(context).primaryColor and then invoke
            // "hot reload" (press "r" in the console where you ran "flutter run",
            // or simply save your changes to "hot reload" in a Flutter IDE).
            // Notice that the counter didn't reset back to zero; the application
            // is not restarted.
            primarySwatch: Colors.blue,
          ),
          home: SplashPage(),
        ),
      ),
    );
  }
}

class MyHomePage extends StatelessWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: buildLoginSuccess(),
      // Connect the Store to a FloatingActionButton. In this case, we'll
      // use the Store to build a callback that with dispatch an Increment
      // Action.
      //
      // Then, we'll pass this callback to the button's `onPressed` handler.
      floatingActionButton: StoreConnector<AppState, VoidCallback>(
        converter: (store) {
          // Return a `VoidCallback`, which is a fancy name for a function
          // with no parameters. It only dispatches an Increment action.
          return () => store.dispatch(LoginAction('zhangby', '123456'));
        },
        builder: (context, callback) {
          return FloatingActionButton(
            // Attach the `callback` to the `onPressed` attribute
            onPressed: callback,
            child: Icon(Icons.add),
          );
        },
      ),
    );
  }

  Center buildLoginSuccess() {
    return Center(
      child: ListView(
        children: <Widget>[
          Text(
            'You have pushed the button this many times:',
          ),
          StoreConnector<AppState, String>(
            converter: (store) {
              return store.state.userState.userInfo.toString();
            },
            builder: (context, info) {
              return Text(
                info,
                style: Theme.of(context).textTheme.display1,
              );
            },
          )
        ],
      ),
    );
  }
}
