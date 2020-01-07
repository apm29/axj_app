import 'dart:io';
import 'dart:math';
import 'package:axj_app/generated/i18n.dart';
import 'package:axj_app/model/api.dart';
import 'package:axj_app/model/bean/file_detail.dart';
import 'package:axj_app/model/bean/user_verify_info.dart';
import 'package:axj_app/model/bean/verify_status.dart';
import 'package:axj_app/model/repository.dart';
import 'package:axj_app/page/modal/task_modal.dart';
import 'package:axj_app/plugin/permission.dart';
import 'package:axj_app/redux/action/actions.dart';
import 'package:axj_app/route/route.dart';
import 'package:axj_app/redux/store/store.dart';
import 'package:axj_app/widget/loading_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:oktoast/oktoast.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

List<CameraDescription> cameras;

class AuthFormPage extends StatefulWidget {
  @override
  _AuthFormPageState createState() => _AuthFormPageState();
}

class _AuthFormPageState extends State<AuthFormPage> {
  TextEditingController _idCardController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return StoreBuilder<AppState>(builder: (context, store) {
      var idCardNum = store.state.userState.userInfo?.idCard;
      bool isReAuth = store.state.userState.userInfo.isReAuthenticate;
      _idCardController.text = idCardNum;
      return Scaffold(
        appBar: AppBar(
          title: Text(S.of(context).idFormTitle),
        ),
        body: Column(
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.symmetric(vertical: 16, horizontal: 12),
              child: TextFormField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  helperText: S.of(context).idFormTitle,
                  isDense: true,
                  hintText: S.of(context).idFormHint,
                ),
                controller: _idCardController,
                enabled: !isReAuth,
              ),
            ),
            Text(isReAuth ? "您已经经过认证,重新认证不可修改身份证信息" : "身份证一旦进入认证环节将不可修改,请谨慎填写"),
            Expanded(child: Container()),
            Container(
              constraints: BoxConstraints.tightFor(height: 48),
              child: LoadingWidget(
                Text(
                  S.of(context).nextStepLabel,
                  style: Theme.of(context)
                      .textTheme
                      .button
                      .copyWith(color: Colors.white),
                ),
                onPressed: () async {
                  //认证结果转发
                  var navigatorState = Navigator.of(context);
                  var result = await AppRouter.toAuthFace(
                      context, _idCardController.text);
                  navigatorState.pop(result);
                },
                gradient: LinearGradient(colors: [
                  Theme.of(context).accentColor,
                  Theme.of(context).accentColor
                ]),
                constrained: false,
              ),
            ),
          ],
        ),
      );
    });
  }
}

class AuthFacePage extends StatefulWidget {
  final String idCardNum;

  const AuthFacePage({Key key, this.idCardNum}) : super(key: key);

  @override
  _AuthFacePageState createState() => _AuthFacePageState();
}

class _AuthFacePageState extends State<AuthFacePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(S.of(context).authTitle),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.switch_camera),
            onPressed: () {
              switchCamera();
            },
          ),
        ],
      ),
      body: cameraReady && controllerReady
          ? Stack(
              children: <Widget>[
                Align(
                  alignment: Alignment.center,
                  child: FaceCameraWidget(
                      controller: controller, verify: inVerify),
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Text(
                          S.of(context).authFaceHint,
                        ),
                      ),
                      StoreConnector<AppState, bool>(
                          converter: (store) =>
                              store.state.userState.userInfo.isReAuthenticate,
                          builder: (context, isAgain) {
                            return Container(
                              constraints: BoxConstraints.tightFor(height: 48),
                              child: LoadingWidget(
                                Text(S.of(context).confirmLabel,
                                    style: Theme.of(context)
                                        .textTheme
                                        .button
                                        .copyWith(color: Colors.white)),
                                onPressed: () async {
                                  await _doAuthorization(isAgain, context);
                                },
                                gradient: LinearGradient(colors: [
                                  Theme.of(context).accentColor,
                                  Theme.of(context).accentColor
                                ]),
                                constrained: false,
                              ),
                            );
                          }),
                    ],
                  ),
                )
              ],
            )
          : Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  CupertinoActivityIndicator(),
                  SizedBox(height: 32),
                  Text(S.of(context).loadingCameraHint)
                ],
              ),
            ),
    );
  }

  CameraController controller;

  bool get cameraReady => cameras != null && cameras.isNotEmpty;

  bool get controllerReady => controller?.value?.isInitialized ?? false;

  int currentCameraIndex = (cameras == null || cameras.isEmpty)
      ? 0
      : cameras.indexWhere((c) => c.lensDirection == CameraLensDirection.front);

  bool inVerify = false;

  @override
  void initState() {
    () async {
      if (!cameraReady) {
        cameras = await availableCameras();
      }
      await initializeCameraController();
    }();
    super.initState();
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }

  void switchCamera() {
    if (!cameraReady) {
      return;
    }
    currentCameraIndex += 1;
    if (currentCameraIndex == cameras.length) {
      currentCameraIndex = 0;
    }
    initializeCameraController();
  }

  Future initializeCameraController() async {
    setState(() {});
    controller =
        CameraController(cameras[currentCameraIndex], ResolutionPreset.high);
    await controller.initialize();
    await Future.delayed(Duration(milliseconds: 400));
    if (!mounted) {
      return;
    }
    setState(() {});
  }

  ///认证方法
  ///
  ///1.先获取房屋信息
  ///2.再验证人脸
  Future<void> _doAuthorization(bool isAgain, BuildContext context) async {
    bool result =
        await Navigator.of(context).push<bool>(TaskModal<bool>(() async {
      try {
        setState(() {
          inVerify = true;
        });
        if (await Permissions.has(PermissionGroup.storage, context)) {
          final Directory tempDir = await getTemporaryDirectory();
          final String dirPath = '${tempDir.path}/Pictures/faces';
          await Directory(dirPath).create(recursive: true);
          final String filePath = imageTempPath(dirPath);
          await controller.takePicture(filePath);
          BaseResp<FileDetail> imageDetailResp =
              await Repository.uploadFile(File(filePath));

          BaseResp<UserVerifyInfo> verifyResp = await Repository.verify(
              imageDetailResp.data.filePath, widget.idCardNum, isAgain);

          BaseResp<VerifyStatus> verifyStatusResp;
          //尝试6次验证
          for (int i = 0; i <= 5; i++) {
            verifyStatusResp = await Repository.getVerifyStatus();
            if (verifyStatusResp.success && verifyStatusResp.data.isVerified) {
              break;
            }
            await Future.delayed(Duration(seconds: 2));
          }
          //重新获取信息
          showToast(verifyResp.text + '\r\n' + verifyStatusResp.text);
          StoreProvider.of<AppState>(context).dispatch(AppInitAction(context));
          await verifyResultHint(context, verifyResp, verifyStatusResp);
          return verifyStatusResp.data.isVerified;
        }
      } catch (e) {
        print(e);
        showToast(getErrorMessage(e));
        return false;
      } finally {
        setState(() {
          inVerify = false;
        });
      }
      return false;
    }));
    Navigator.of(context).pop(result);
  }

  String imageTempPath(String dirPath) =>
      '$dirPath/${DateTime.now().millisecondsSinceEpoch}.jpg';

  verifyResultHint(BuildContext context, BaseResp<UserVerifyInfo> verifyResp,
      BaseResp<VerifyStatus> verifyStatusResp) {
    return showDialog(
      context: context,
      builder: (context) => CupertinoAlertDialog(
        content: Text(verifyResp.text),
        title: Text(verifyStatusResp.text),
        actions: <Widget>[
          CupertinoButton(
              child: Text(S.of(context).confirmLabel),
              onPressed: () => Navigator.of(context).pop())
        ],
      ),
    );
  }
}

class FaceCameraWidget extends StatelessWidget {
  final verify;

  const FaceCameraWidget({
    Key key,
    @required this.controller,
    this.verify,
  }) : super(key: key);

  final CameraController controller;

  @override
  Widget build(BuildContext context) {
    return ClipPath(
      clipBehavior: Clip.antiAlias,
      clipper: FaceClipper(),
      child: AspectRatio(
        aspectRatio: controller.value.aspectRatio,
        child: verify
            ? Container(
                color: Colors.black54,
                child: Center(child: Text('验证中..')),
              )
            : CameraPreview(controller),
      ),
    );
  }
}

class FaceClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();

    Rect faceRect =
        Rect.fromLTWH(20, 20, size.width - 40, (size.width - 40) * 1.3);

    path.moveTo(faceRect.topCenter.dx, faceRect.topCenter.dy);

    Offset p1 = faceRect.topRight.translate(0, 0);
    Offset p2 = faceRect.centerRight.translate(-10, 0);

    path.quadraticBezierTo(p1.dx, p1.dy, p2.dx, p2.dy);

    p1 = faceRect.bottomRight.translate(-30, -25);
    p2 = faceRect.bottomCenter.translate(10, 0);

    path.quadraticBezierTo(p1.dx, p1.dy, p2.dx, p2.dy);
    p2 = faceRect.bottomCenter.translate(-10, 0);
    path.lineTo(p2.dx, p2.dy);

    p1 = faceRect.bottomLeft.translate(30, -25);
    p2 = faceRect.centerLeft.translate(10, 0);

    path.quadraticBezierTo(p1.dx, p1.dy, p2.dx, p2.dy);

    p1 = faceRect.topLeft.translate(0, 0);
    p2 = faceRect.topCenter.translate(0, 0);

    path.quadraticBezierTo(p1.dx, p1.dy, p2.dx, p2.dy);

    var rightEarRect = Rect.fromLTWH(
      faceRect.centerRight.dx - 20,
      faceRect.centerRight.dy - 35,
      20,
      60,
    );
    path.addArc(rightEarRect, -pi / 2, pi);

    path.addPolygon([
      rightEarRect.bottomCenter,
      rightEarRect.bottomLeft,
      rightEarRect.topCenter,
    ], true);

    var leftEarRect = Rect.fromLTWH(
      faceRect.centerLeft.dx,
      faceRect.centerLeft.dy - 35,
      20,
      60,
    );
    path.addArc(leftEarRect, pi / 2, pi);

    path.addPolygon([
      leftEarRect.topCenter,
      leftEarRect.bottomRight,
      leftEarRect.bottomCenter,
    ], true);

    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper oldClipper) {
    return false;
  }
}
