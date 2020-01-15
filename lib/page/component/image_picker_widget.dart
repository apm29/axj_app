import 'dart:io';
import 'package:axj_app/model/api.dart';
import 'package:axj_app/model/bean/file_detail.dart';
import 'package:axj_app/model/repository.dart';
import 'package:axj_app/plugin/permission.dart';
import 'package:axj_app/redux/store/store.dart';
import 'package:axj_app/utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

enum ImageSourceType { Gallery, Camera, All }

class ImagePickerWidget extends StatefulWidget {
  final ImageUrlController controller;
  final bool deletable;
  final ImageSourceType pickerType;
  final Size size;

  const ImagePickerWidget(
      {Key key,
      this.controller,
      this.deletable,
      this.pickerType = ImageSourceType.All,
      this.size})
      : super(key: key);

  @override
  _ImagePickerWidgetState createState() => _ImagePickerWidgetState(controller);
}

Function defaultLoadingBuilder =
    (BuildContext context, Widget child, ImageChunkEvent loadingProgress) {
  if (loadingProgress == null) return child;
  return Center(
    child: CircularProgressIndicator(
      value: loadingProgress.expectedTotalBytes != null
          ? loadingProgress.cumulativeBytesLoaded /
              loadingProgress.expectedTotalBytes
          : null,
    ),
  );
};

class _ImagePickerWidgetState extends State<ImagePickerWidget> {
  ImageUrlController controller;

  _ImagePickerWidgetState(this.controller);

  bool loading = false;

  @override
  void initState() {
    if (controller == null) {
      controller = ImageUrlController();
    }
    controller.addListener(() {
      setState(() {});
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return UnconstrainedBox(
      child: InkWell(
        onTap: () => _pick(context),
        child: Stack(
          children: <Widget>[
            Container(
              constraints: BoxConstraints.tight(
                widget.size ??
                    Size(
                      MediaQuery.of(context).size.width * 0.5,
                      MediaQuery.of(context).size.width * 0.5,
                    ),
              ),
              clipBehavior: Clip.antiAlias,
              decoration: BoxDecoration(
                color: Theme.of(context).dividerColor,
                border: Border(),
                borderRadius: BorderRadius.all(Radius.circular(12)),
              ),
              child: loading
                  ? CupertinoActivityIndicator()
                  : controller.noValue
                      ? Icon(
                          placeholder,
                          color: Theme.of(context).dividerColor.withAlpha(0x66),
                          size: 48,
                        )
                      : Image.network(
                          controller.url,
                          loadingBuilder: defaultLoadingBuilder,
                          fit: BoxFit.cover,
                        ),
            ),
            Positioned(
              top: 0,
              right: 0,
              child: Offstage(
                offstage: controller.noValue,
                child: IconButton(
                  icon: Container(
                    child: Icon(
                      Icons.close,
                      color: Theme.of(context).accentColor,
                    ),
                    decoration: BoxDecoration(
                        color: Theme.of(context).cardColor,
                        borderRadius: BorderRadius.all(Radius.circular(20))),
                  ),
                  onPressed: _delete,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  IconData get placeholder {
    switch (widget.pickerType) {
      case ImageSourceType.Gallery:
        return Icons.image;
      case ImageSourceType.Camera:
        return Icons.camera_alt;
      case ImageSourceType.All:
        return Icons.add;
    }
    return Icons.add;
  }

  void _pick(BuildContext context) async {
    if (widget.pickerType == ImageSourceType.All) {
      if (await Permissions.has(PermissionGroup.storage, context) &&
          await Permissions.has(PermissionGroup.camera, context)) {
        ImageSource type = await showModalBottomSheet<ImageSource>(
          context: context,
          builder: (context) => imageSourceChooseSheet(context),
        );
        if (type != null) await _doPick(type);
      }
    } else if (widget.pickerType == ImageSourceType.Camera) {
      if (await Permissions.has(PermissionGroup.camera, context)) {
        await _doPick(ImageSource.camera);
      }
    } else if (widget.pickerType == ImageSourceType.Gallery) {
      if (await Permissions.has(PermissionGroup.storage, context) &&
          await Permissions.has(PermissionGroup.camera, context)) {
        await _doPick(ImageSource.camera);
      }
    }
  }

  Future _doPick(ImageSource source) async {
    setState(() {
      loading = true;
    });
    try {
      File imageFile = await ImagePicker.pickImage(source: source);
      if (imageFile != null) {
        BaseResp<FileDetail> imageResp = await Repository.uploadFile(imageFile);
        if (imageResp.success) {
          controller.url = imageResp.data.filePath;
        } else {
          showAppToast(imageResp.text);
        }
      }
    } catch (e) {
      showAppToast(getErrorMessage(e));
    } finally {
      setState(() {
        loading = false;
      });
    }
  }

  BottomSheet imageSourceChooseSheet(BuildContext context) {
    return BottomSheet(
      onClosing: () {
        Navigator.of(context).pop(null);
      },
      builder: (context) => ListView(
        shrinkWrap: true,
        children: <Widget>[
          ListTile(
            leading: Icon(Icons.image),
            title: Text("从相册选择"),
            onTap: () {
              Navigator.of(context).pop(ImageSource.gallery);
            },
          ),
          ListTile(
            leading: Icon(Icons.camera_alt),
            title: Text("使用相机拍照"),
            onTap: () {
              Navigator.of(context).pop(ImageSource.camera);
            },
          )
        ],
      ),
    );
  }

  void _delete() {
    controller.url = null;
  }
}

class ImageUrlController extends ChangeNotifier {
  String _url;

  String get url => _url;

  set url(String value) {
    _url = value;
    notifyListeners();
  }

  bool get noValue => _url == null || _url.isEmpty;
}
