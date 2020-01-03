import 'dart:ui';

import 'package:axj_app/generated/i18n.dart';
import 'package:axj_app/model/api.dart';
import 'package:axj_app/model/repository.dart';
import 'package:axj_app/redux/store/store.dart';
import 'package:axj_app/widget/loading_widget.dart';
import 'package:flutter/material.dart';
import 'package:oktoast/oktoast.dart';

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
              'assets/images/city.jpg',
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
  TextEditingController _phoneController = TextEditingController();
  TextEditingController _nameController = TextEditingController();
  TextEditingController _wordController = TextEditingController();
  TextEditingController _wordRepeatController = TextEditingController();
  TextEditingController _smsController = TextEditingController();
  GlobalKey<FormFieldState> _phoneKey = GlobalKey();

  bool get enabled {
    return (_phoneController.text.isNotEmpty &&
        _nameController.text.isNotEmpty &&
        _wordController.text.isNotEmpty &&
        _wordRepeatController.text.isNotEmpty &&
        _smsController.text.isNotEmpty &&
        _phoneController.text.length >= 11 &&
        _smsController.text.length >= 6);
  }

  @override
  void initState() {
    var listener = () {
      setState(() {});
    };
    _phoneController.addListener(listener);
    _smsController.addListener(listener);
    _nameController.addListener(listener);
    _wordController.addListener(listener);
    _wordRepeatController.addListener(listener);
    super.initState();
  }

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
      hintText: S.of(context).phoneHint,
      isDense: true,
    );

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
      hintText: S.of(context).userNameHint,
      isDense: true,
    );

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
      hintText: S.of(context).passwordHint,
      isDense: true,
    );

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
      hintText: S.of(context).passwordRepeatHint,
      isDense: true,
    );

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
            child: Form(
              child: Builder(
                builder: (context) => ListView(
                  shrinkWrap: true,
                  children: <Widget>[
                    Text(
                      S.of(context).registerTitle,
                      style: Theme.of(context).textTheme.title.copyWith(
                            color: Theme.of(context).secondaryHeaderColor,
                            fontSize: 36,
                            fontFamily: 'handwrite_font',
                            fontWeight: FontWeight.w600,
                          ),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(
                      height: 24,
                    ),
                    TextFormField(
                      key: _phoneKey,
                      decoration: inputDecorationMobile,
                      controller: _phoneController,
                      validator: (v) {
                        return v.length == 11 ? null : S.of(context).phoneHint;
                      },
                      keyboardType: TextInputType.phone,
                    ),
                    SizedBox(
                      height: 6,
                    ),
                    TextFormField(
                      decoration: inputDecorationUserName,
                      controller: _nameController,
                      validator: (v) {
                        return v.length >= 1
                            ? null
                            : S.of(context).userNameHint;
                      },
                    ),
                    SizedBox(
                      height: 6,
                    ),
                    TextFormField(
                      decoration: inputDecorationPassword,
                      controller: _wordController,
                      validator: (v) {
                        return v.length >= 1
                            ? null
                            : S.of(context).passwordHint;
                      },
                      obscureText: true,
                    ),
                    SizedBox(
                      height: 6,
                    ),
                    TextFormField(
                      decoration: inputDecorationPasswordConfirm,
                      controller: _wordRepeatController,
                      validator: (v) {
                        return (v == _wordController.text)
                            ? null
                            : S.of(context).passwordRepeatError;
                      },
                      obscureText: true,
                    ),
                    SizedBox(
                      height: 6,
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Expanded(
                          child: TextFormField(
                            decoration: inputDecorationCode,
                            controller: _smsController,
                            validator: (v) {
                              return (v.length == 6)
                                  ? null
                                  : S.of(context).smsCodeHint;
                            },
                            keyboardType: TextInputType.number,
                          ),
                        ),
                        LoadingWidget(
                          Container(
                            margin: EdgeInsets.only(left: 12),
                            padding: EdgeInsets.symmetric(
                              vertical: 17,
                              horizontal: 12,
                            ),
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(6))),
                            child: Text(
                              S.of(context).sendSmsCodeHint,
                              style: TextStyle(
                                  color: Theme.of(context).primaryColor),
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
                        constrained: false,
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future _register(BuildContext context) async {
    if (Form.of(context).validate()) {
      BaseResp resp = await Repository.register(_phoneController.text,
          _smsController.text, _wordController.text, _nameController.text);
      showToast(resp.text);
      Navigator.of(context).pop({
        "userName": _nameController.text,
        "password": _wordController.text,
      });
    }
  }

  Future _sendSmsCode() async {
    if (_phoneKey.currentState.validate()) {
      try {
        BaseResp resp = await Repository.sendVerifyCode(_phoneController.text,
                  isRegister: true);
        showToast(resp.text);
      } catch (e) {
        showToast(getErrorMessage(e));
      }

    }
  }
}
