import 'dart:io';
import 'dart:ui';
import 'package:axj_app/generated/i18n.dart';
import 'package:axj_app/widget/loading_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

///
/// author : ciih
/// date : 2019-12-26 10:24
/// description :
///
class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: Stack(
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
                  onPressed: () => Navigator.of(context).pop(),
                ),
              ),
              Positioned(
                top: MediaQuery.of(context).size.width * 0.36,
                left: 32,
                right: 32,
                child: LoginCard(),
              ),
              Positioned(
                left: 20,
                bottom: 20,
                child: FlatButton(
                  onPressed: () {},
                  child: Text(
                    S.of(context).registerLabel,
                    style: TextStyle(color: Theme.of(context).primaryColor),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class LoginCard extends StatefulWidget {
  const LoginCard({
    Key key,
  }) : super(key: key);

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
      color: Colors.white,
      child: Column(
        children: <Widget>[
          TabBar(
            controller: tabController,
            labelColor: Theme.of(context).primaryColor,
            unselectedLabelColor: Colors.grey,
            indicatorSize: TabBarIndicatorSize.label,
            indicatorColor: Theme.of(context).primaryColor,
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
          Container(
            margin: EdgeInsets.symmetric(horizontal: 32, vertical: 12),
            constraints: BoxConstraints.tightFor(
                width: MediaQuery.of(context).size.width),
            child: LoadingWidget(
              Text(
                S.of(context).loginLabel,
                style: TextStyle(fontSize: 16, letterSpacing: 22),
              ),
              onPressed: enabled
                  ? () async {
                      await Future.delayed(Duration(seconds: 2));
                    }
                  : null,
              gradient: LinearGradient(colors: [
                Theme.of(context).primaryColor,
                Theme.of(context).primaryColor
              ]),
              unconstrained: false,
            ),
          ),
          buildServiceProtocol()
        ],
      ),
    );
  }

  Padding buildServiceProtocol() {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
                shape: BoxShape.circle, color: Theme.of(context).primaryColor),
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
            style: TextStyle(color: Colors.grey, fontSize: 12),
          )
        ],
      ),
    );
  }

  buildSmsForm() {
    final border = CustomRectInputBorder(
      letterSpace: letterSpace,
      textSize: textSize,
      textLength: smsCount,
      borderSide: BorderSide(
        color: Theme.of(context).primaryColor.withOpacity(0.6),
        width: 1.0,
      ),
    );
    return Column(
      children: <Widget>[
        Container(
          child: TextField(
            controller: _phoneController,
            decoration: InputDecoration(
              icon: Text(S.of(context).phoneLabel),
              hintText: S.of(context).phoneHint,
              isDense: true,
              suffix: LoadingWidget(
                Text(
                  S.of(context).sendSmsCodeHint,
                  style: TextStyle(color: Theme.of(context).primaryColor),
                ),
                onPressed: () async {
                  await Future.delayed(Duration(seconds: 2));
                  _smsFocusNode.requestFocus();
                },
              ),
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Theme.of(context).primaryColor),
              ),
            ),
            maxLength: phoneCount,
            keyboardType: TextInputType.phone,
            style: TextStyle(
              fontSize: 15,
            ),
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
              enabledBorder: border,
              focusedBorder: border,
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
            ),
            style: TextStyle(
              fontSize: 20,
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
            ),
            style: TextStyle(fontSize: 20, ),
            obscureText: true,
          ),
          padding: EdgeInsets.symmetric(vertical: 12, horizontal: 24),
        ),
      ],
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
    );
  }
}

abstract class AbsInputBorder extends UnderlineInputBorder {
  final double textSize;
  final double letterSpace;
  final int textLength;

  final double startOffset;

  double calcTrueTextSize() {
    // 测量单个数字实际长度
    var paragraph = ParagraphBuilder(ParagraphStyle(fontSize: textSize))
      ..addText("8");
    var p = paragraph.build()
      ..layout(ParagraphConstraints(width: double.infinity));
    return p.minIntrinsicWidth;
  }

  AbsInputBorder({
    this.textSize = 0.0,
    this.letterSpace = 0.0,
    this.textLength,
    BorderSide borderSide = const BorderSide(),
  })  : startOffset = letterSpace * 0.5,
        super(borderSide: borderSide) {
    calcTrueTextSize();
  }
}

class CustomRectInputBorder extends AbsInputBorder {
  CustomRectInputBorder({
    double textSize = 0.0,
    @required double letterSpace,
    @required int textLength,
    BorderSide borderSide = const BorderSide(),
  }) : super(
            textSize: textSize,
            letterSpace: letterSpace,
            textLength: textLength,
            borderSide: borderSide);

  @override
  void paint(
    Canvas canvas,
    Rect rect, {
    double gapStart,
    double gapExtent = 0.0,
    double gapPercentage = 0.0,
    TextDirection textDirection,
  }) {
    double textTrueWidth = calcTrueTextSize();
    double offsetX = textTrueWidth * 0.5;

    double offsetY = textTrueWidth * 0.5;
    double curStartX = rect.left + startOffset - offsetX;
    if (!Platform.isIOS) {
      for (int i = 0; i < textLength; i++) {
        Rect r = Rect.fromLTWH(curStartX, rect.top + offsetY,
            textTrueWidth + offsetX * 2, rect.height - offsetY * 2);
        canvas.drawRRect(RRect.fromRectAndRadius(r, Radius.circular(6)),
            borderSide.toPaint());
        curStartX += (textTrueWidth + letterSpace);
      }
    } else {
      curStartX = 3;
      double width = rect.width / 6;
      for (int i = 0; i < textLength; i++) {
        Rect r =
            Rect.fromLTWH(curStartX, rect.top + 4, width - 6, rect.height - 8);
        canvas.drawRRect(RRect.fromRectAndRadius(r, Radius.circular(6)),
            borderSide.toPaint());
        curStartX += (width);
      }
    }
  }
}
