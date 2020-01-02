import 'dart:ui';
import 'package:axj_app/action/actions.dart';
import 'package:axj_app/main.dart';
import 'package:axj_app/model/api.dart';
import 'package:axj_app/model/repository.dart';
import 'package:axj_app/generated/i18n.dart';
import 'package:axj_app/route/route.dart';
import 'package:axj_app/store/store.dart';
import 'package:axj_app/widget/loading_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:oktoast/oktoast.dart';

///
/// author : ciih
/// date : 2019-12-26 10:24
/// description :
///
class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          SizedBox(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
          ),
          Positioned(
            top: 0,
            child: DecoratedBox(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  end: Alignment(0.0, 0.5),
                  begin: Alignment(0.0, 0.0),
                  colors: <Color>[
                    Color(0x60000000),
                    Color(0x00000000),
                  ],
                ),
              ),
              position: DecorationPosition.foreground,
              child: Image.asset(
                'assets/images/pineapple.jpg',
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.width * 0.62,
                fit: BoxFit.fill,
              ),
            ),
          ),
          Align(
            alignment: Alignment.topCenter,
            child: SafeArea(
              child: Column(
                children: <Widget>[
                  Text(
                    S.of(context).appName,
                    style: TextStyle(
                      fontSize: 32,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(
                    height: 12,
                  ),
                  Text(
                    S.of(context).motto,
                    style: TextStyle(
                      fontSize: 22,
                      color: Colors.white,
                      fontFamily: 'handwrite_font',
                    ),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            right: 16,
            top: 16,
            child: IconButton(
              icon: Icon(
                Icons.close,
                size: 36,
                color: Colors.white,
              ),
              onPressed: () => _close(context),
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 20).add(
              EdgeInsets.only(
                top: MediaQuery.of(context).size.height * 0.18,
              ),
            ),
            child: LoginCard(
              parent: context,
            ),
          ),
        ],
      ),
      bottomNavigationBar: FlatButton(
        onPressed: () => _register(context),
        child: Text(
          S.of(context).registerHint,
          style: Theme.of(context).textTheme.caption,
        ),
      ),
    );
  }

  bool _close(BuildContext context) => Navigator.of(context).pop();

  void _register(BuildContext context) =>
      AppRouter.toRegister(context).then((resMap) {
        if (resMap != null) {
          store.dispatch(
              LoginAction(resMap['userName'], resMap['password'], context, () {
            Navigator.of(context).pop(true);
          }));
        }
      });
}

class LoginCard extends StatefulWidget {
  const LoginCard({Key key, BuildContext parent})
      : this.parent = parent,
        super(key: key);

  final BuildContext parent;

  @override
  _LoginCardState createState() => _LoginCardState();
}

class _LoginCardState extends State<LoginCard> with TickerProviderStateMixin {
  TabController tabController;
  TextEditingController _phoneController = TextEditingController();
  TextEditingController _smsController = TextEditingController();
  TextEditingController _nameController = TextEditingController();
  TextEditingController _wordController = TextEditingController();
  final textSize = 25.0;
  final letterSpace = 20.0;
  final smsCount = 6;
  final phoneCount = 11;
  FocusNode _smsFocusNode = FocusNode();

  int get currentIndex => (tabController?.index ?? 0);

  bool get enabled {
    return (currentIndex == 1 &&
            _nameController.text.isNotEmpty &&
            _wordController.text.isNotEmpty) ||
        (currentIndex == 0 &&
            _phoneController.text.isNotEmpty &&
            _phoneController.text.length >= phoneCount &&
            _smsController.text.isNotEmpty &&
            _smsController.text.length >= smsCount);
  }

  bool get usePassword => currentIndex == 1;

  bool get phoneReady => _phoneController.text.isNotEmpty;

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 2, vsync: this);
    var listener = () {
      setState(() {});
    };
    _phoneController.addListener(listener);
    _smsController.addListener(listener);
    _nameController.addListener(listener);
    _wordController.addListener(listener);
    tabController.addListener(listener);
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }

  Widget counter(
    BuildContext context, {
    int currentLength,
    int maxLength,
    bool isFocused,
  }) {
    return Container();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      type: MaterialType.card,
      elevation: 3,
      color: Theme.of(context).cardColor,
      child: ListView(
        shrinkWrap: true,
        children: <Widget>[
          TabBar(
            controller: tabController,
            labelColor: Theme.of(context).accentColor,
            unselectedLabelColor: Colors.grey,
            indicatorSize: TabBarIndicatorSize.label,
            indicatorColor: Theme.of(context).accentColor,
            labelStyle: TextStyle(fontSize: 18),
            tabs: [
              Tab(text: S.of(context).smsLoginLabel),
              Tab(text: S.of(context).passwordLoginLabel),
            ],
          ),
          ConstrainedBox(
            constraints: BoxConstraints.tightFor(height: 240),
            child: TabBarView(
              controller: tabController,
              physics: NeverScrollableScrollPhysics(),
              children: [
                buildSmsForm(),
                buildCommonForm(),
              ],
            ),
          ),
          buildLoginButton(context),
          buildServiceProtocol()
        ],
      ),
    );
  }

  Widget buildLoginButton(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 32, vertical: 12),
      constraints:
          BoxConstraints.tightFor(width: MediaQuery.of(context).size.width),
      child: LoadingWidget(
        Text(
          S.of(context).loginLabel,
          style: TextStyle(fontSize: 16),
        ),
        onPressed: enabled
            ? () async {
                _login(context);
              }
            : null,
        gradient: LinearGradient(colors: [
          Theme.of(context).accentColor,
          Theme.of(context).accentColor
        ]),
        constrained: false,
      ),
    );
  }

  Widget buildServiceProtocol() {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
                shape: BoxShape.circle, color: Theme.of(context).accentColor),
            child: Padding(
              padding: const EdgeInsets.all(2.0),
              child: Icon(
                Icons.check,
                size: 10.0,
                color: Colors.white,
              ),
            ),
          ),
          SizedBox(
            width: 12,
          ),
          Text(
            S.of(context).serviceProtocolText(
                S.of(context).serviceProtocolName(S.of(context).appName)),
            style: Theme.of(context).textTheme.caption,
          )
        ],
      ),
    );
  }

  buildSmsForm() {
//    final border = CustomRectInputBorder(
//      letterSpace: letterSpace,
//      textSize: textSize,
//      textLength: smsCount,
//      borderSide: BorderSide(
//        color: Theme.of(context).accentColor.withOpacity(0.6),
//        width: 1.0,
//      ),
//    );
    return Column(
      children: <Widget>[
        Container(
          child: TextField(
            controller: _phoneController,
            decoration: InputDecoration(
              icon: Text(S.of(context).phoneLabel),
              hintText: S.of(context).phoneHint,
              hintStyle: Theme.of(context).textTheme.caption,
              isDense: true,
              suffix: LoadingWidget(
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    S.of(context).sendSmsCodeHint,
                    style: TextStyle(color: Theme.of(context).accentColor),
                  ),
                ),
                onPressed: phoneReady
                    ? () async {
                        await _sendSmsCode();
                      }
                    : null,
              ),
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Theme.of(context).accentColor),
              ),
            ),
            maxLength: phoneCount,
            keyboardType: TextInputType.phone,
            buildCounter: counter,
          ),
          padding: EdgeInsets.symmetric(vertical: 12, horizontal: 24),
        ),
        Container(
          child: TextField(
            controller: _smsController,
            focusNode: _smsFocusNode,
            style: TextStyle(
              fontSize: textSize,
              letterSpacing: letterSpace,
            ),
            maxLength: smsCount,
            buildCounter: counter,
            keyboardType: TextInputType.number,
            textInputAction: TextInputAction.done,
            decoration: InputDecoration(
              icon: Text(S.of(context).smsCodeLabel),
              hintText: S.of(context).smsCodeHint,
              hintStyle: Theme.of(context).textTheme.caption,
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Theme.of(context).accentColor),
              ),
//              enabledBorder: border,
//              focusedBorder: border,
              helperText: S.of(context).smsCodeHint,
            ),
          ),
          padding: EdgeInsets.symmetric(vertical: 12, horizontal: 24),
        ),
      ],
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
    );
  }

  buildCommonForm() {
    return Column(
      children: <Widget>[
        Container(
          child: TextField(
            controller: _nameController,
            decoration: InputDecoration(
              icon: Icon(Icons.person),
              hintText: S.of(context).userNameHint,
              hintStyle: Theme.of(context).textTheme.caption,
            ),
          ),
          padding: EdgeInsets.symmetric(vertical: 12, horizontal: 24),
        ),
        Container(
          child: TextField(
            controller: _wordController,
            decoration: InputDecoration(
              icon: Icon(Icons.verified_user),
              hintText: S.of(context).passwordHint,
              hintStyle: Theme.of(context).textTheme.caption,
            ),
            obscureText: true,
          ),
          padding: EdgeInsets.symmetric(vertical: 12, horizontal: 24),
        ),
      ],
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
    );
  }

  Future _sendSmsCode() async {
    try {
      BaseResp resp = await Repository.sendVerifyCode(_phoneController.text);
      showToast(resp.text);
      _smsFocusNode.requestFocus();
    } catch (e) {
      print(e);
      showToast(getErrorMessage(e));
    }
  }

  void _login(BuildContext context) {
    if (tabController.index == 0) {
      store.dispatch(FastLoginAction(
          _phoneController.text, _smsController.text, context, () {
        Navigator.of(context).pop(true);
      }));
    } else {
      store.dispatch(
          LoginAction(_nameController.text, _wordController.text, context, () {
        Navigator.of(context).pop(true);
      }));
    }
  }
}
