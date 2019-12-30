import 'dart:ui';

import 'package:axj_app/generated/i18n.dart';
import 'package:axj_app/widget/loading_widget.dart';
import 'package:flutter/material.dart';

///
/// author : ciih
/// date : 2019-12-30 14:33
/// description :
///
class RegisterPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          SizedBox.expand(
            child: Image.asset(
              'assets/images/car.jpg',
              fit: BoxFit.cover,
            ),
          ),
          RegisterColumn(),
          Positioned(
            right: 16,
            top: 0,
            child: SafeArea(
              child: IconButton(
                icon: Icon(
                  Icons.close,
                  size: 36,
                  color: Colors.white,
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class RegisterColumn extends StatefulWidget {
  @override
  _RegisterColumnState createState() => _RegisterColumnState();
}

class _RegisterColumnState extends State<RegisterColumn> {
  bool enabled = false;

  @override
  Widget build(BuildContext context) {
    final inputDecorationMobile = InputDecoration(
        enabledBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Colors.white),
          gapPadding: 1.1,
        ),
        filled: true,
        fillColor: Colors.white,
        border: const OutlineInputBorder(
          borderSide: BorderSide(color: Colors.white),
          gapPadding: 1.1,
        ),
        hintText: S.of(context).phoneLabel);

    final inputDecorationUserName = InputDecoration(
        enabledBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Colors.white),
          gapPadding: 1.1,
        ),
        filled: true,
        fillColor: Colors.white,
        border: const OutlineInputBorder(
          borderSide: BorderSide(color: Colors.white),
          gapPadding: 1.1,
        ),
        hintText: S.of(context).userNameHint);

    final inputDecorationPassword = InputDecoration(
        enabledBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Colors.white),
          gapPadding: 1.1,
        ),
        filled: true,
        fillColor: Colors.white,
        border: const OutlineInputBorder(
          borderSide: BorderSide(color: Colors.white),
          gapPadding: 1.1,
        ),
        hintText: S.of(context).passwordHint);

    final inputDecorationPasswordConfirm = InputDecoration(
        enabledBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Colors.white),
          gapPadding: 1.1,
        ),
        filled: true,
        fillColor: Colors.white,
        border: const OutlineInputBorder(
          borderSide: BorderSide(color: Colors.white),
          gapPadding: 1.1,
        ),
        hintText: S.of(context).passwordRepeatHint);

    final inputDecorationCode = InputDecoration(
      enabledBorder: const OutlineInputBorder(
        borderSide: BorderSide(color: Colors.white),
        gapPadding: 1.1,
      ),
      filled: true,
      fillColor: Colors.white,
      border: const OutlineInputBorder(
        borderSide: BorderSide(color: Colors.white),
        gapPadding: 1.1,
      ),
      hintText: S.of(context).smsCodeLabel,
      isDense: true,
    );

    return ClipRect(
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 2.0, sigmaY: 2.0),
        child: SizedBox.expand(
          child: Container(
            padding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
            alignment: Alignment.center,
            child: ListView(
              shrinkWrap: true,
              children: <Widget>[
                Text(
                  S.of(context).registerLabel,
                  style: Theme.of(context).textTheme.title.copyWith(
                        color: Colors.blue,
                        fontSize: 36,
                        fontFamily: 'handwrite_font',
                      ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(
                  height: 24,
                ),
                TextField(
                  decoration: inputDecorationMobile,
                ),
                SizedBox(
                  height: 6,
                ),
                TextFormField(
                  decoration: inputDecorationUserName,
                ),
                SizedBox(
                  height: 6,
                ),
                TextFormField(
                  decoration: inputDecorationPassword,
                ),
                SizedBox(
                  height: 6,
                ),
                TextFormField(
                  decoration: inputDecorationPasswordConfirm,
                ),
                SizedBox(
                  height: 6,
                ),
                Row(
                  children: <Widget>[
                    Expanded(
                      child: TextFormField(
                        decoration: inputDecorationCode,
                      ),
                    ),
                    LoadingWidget(
                      Container(
                        margin: EdgeInsets.only(left: 12),
                        padding:
                            EdgeInsets.symmetric(vertical: 17, horizontal: 12),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.all(Radius.circular(6))),
                        child: Text(
                          S.of(context).sendSmsCodeHint,
                          style:
                              TextStyle(color: Theme.of(context).primaryColor),
                        ),
                      ),
                      onPressed: () async {
                        await _sendSmsCode();
                      },
                    )
                  ],
                ),
                SizedBox(
                  height: 24,
                ),
                Container(
                  constraints: BoxConstraints.tightFor(
                      width: MediaQuery.of(context).size.width),
                  child: LoadingWidget(
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        S.of(context).registerLabel,
                        style: TextStyle(fontSize: 20),
                      ),
                    ),
                    onPressed: enabled
                        ? () async {
                            await _register(context);
                          }
                        : null,
                    gradient: LinearGradient(
                      colors: [
                        Theme.of(context).primaryColor,
                        Theme.of(context).primaryColor
                      ],
                    ),
                    unconstrained: false,
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future _register(BuildContext context) async {}

  Future _sendSmsCode() async {}
}
