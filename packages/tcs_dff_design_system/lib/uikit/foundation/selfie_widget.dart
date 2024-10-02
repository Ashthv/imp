import 'dart:io';
import 'package:flutter/material.dart';
import 'package:tcs_dff_device_feature/camera/default_camera.dart';
import '../../theme/size.dart';
import '../../theme/theme.dart';
import '../../utils/image_type.dart';
import '../../utils/sizer/app_sizer.dart';
import '../container/image/image_widget.dart';

class SelfieWidget extends StatefulWidget {
  SelfieWidget({
    super.key,
    required this.onFileCapturedCallBack,
    this.selectedFile,
  });
  final Function(File? path) onFileCapturedCallBack;
  final File? selectedFile;
  @override
  State<SelfieWidget> createState() => _SelfieWidgetState();
}

class _SelfieWidgetState extends State<SelfieWidget> {
  final initCamera = Camera();
  File? resultPicture;
  String? resultPicturePath = '';
  final outerCircle =
      'packages/tcs_dff_design_system/assets/images/ellipse_dotted.svg';
  final captureImage =
      'packages/tcs_dff_design_system/assets/images/camera_icon.svg';
  final refreshImage =
      'packages/tcs_dff_design_system/assets/images/refresh_icon.svg';
  final personImage =
      'packages/tcs_dff_design_system/assets/images/person_icon.svg';
  @override
  void didUpdateWidget(covariant final SelfieWidget oldWidget) {
    if (widget.selectedFile != null) {
      resultPicturePath = widget.selectedFile!.path;
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  void initState() {
    if (widget.selectedFile != null) {
      resultPicturePath = widget.selectedFile!.path;
    }
    super.initState();
  }

  Future<File?>? openPluginCamera(final BuildContext context) async =>
      resultPicture = await initCamera.openCamera(
        direction: 1,
        context: context,
      );
  @override
  Widget build(final BuildContext context) {
    final size = context.theme.appSize;
    if (resultPicturePath == '') {
      resultPicturePath = outerCircle;
    }
    return Stack(
      alignment: Alignment.center,
      children: [
        if (resultPicturePath == outerCircle)
          ImageWidget(
            imageType: ImageType.assetImage,
            path: resultPicturePath!,
            fit: BoxFit.contain,
          )
        else
          ClipRRect(
            borderRadius: BorderRadius.circular(
              size.size100.dp,
            ),
            child: Image.file(
              File(resultPicturePath!),
              fit: BoxFit.fill,
              width: AppSizes.size181.dp,
              height: AppSizes.size181.dp,
            ),
          ),
        Positioned(
          right: size.size6.dp,
          bottom: size.size13.dp,
          child: InkWell(
            onTap: () async {
              final result = await openPluginCamera(context);
              widget.onFileCapturedCallBack(result);
              setState(() {
                resultPicturePath = result!.path;
              });
            },
            child: ImageWidget(
              imageType: ImageType.assetImage,
              path: resultPicturePath == outerCircle
                  ? captureImage
                  : refreshImage,
            ),
          ),
        ),
        Visibility(
          visible: resultPicturePath != outerCircle ? false : true,
          child: Container(
            child: ImageWidget(
              imageType: ImageType.assetImage,
              path: personImage,
            ),
          ),
        ),
      ],
    );
  }
}
