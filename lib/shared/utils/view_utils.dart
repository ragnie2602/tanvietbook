import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_cropper/image_cropper.dart';
import '../../data/constants.dart';
import '../../data/resources/colors.dart';
import '../widgets/dialog_helper.dart';

class ViewUtils {
  static GlobalKey<NavigatorState>? _rootNavigatorKey;
  static void unFocusView() {
    FocusManager.instance.primaryFocus?.unfocus();
  }

  static GlobalKey<NavigatorState> getRootNavigatorKey() => _rootNavigatorKey ??= GlobalKey<NavigatorState>();
}

toastWarning(String text) => Fluttertoast.showToast(
    msg: text,
    toastLength: Toast.LENGTH_SHORT,
    gravity: ToastGravity.TOP,
    timeInSecForIosWeb: 1,
    backgroundColor: Colors.red,
    textColor: Colors.white,
    fontSize: 16.0);

// {
//   FToast fToast = FToast();
//   try{
//     fToast.init(navigatorKey.currentContext!);
//   } catch(e){
//       return;
//   }
//   Widget toast = Container(
//     padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
//     decoration: BoxDecoration(
//       borderRadius: BorderRadius.circular(5),
//       color: AppColor.errorColor
//     ),
//     child: Row(
//       mainAxisSize: MainAxisSize.max,
//       children: [
//         SvgPicture.asset('assets/icons/ic_warning.svg'),
//         const SizedBox(width: 10),
//         Expanded(child: Text(text, style: AppTextTheme.textPrimary))
//       ],
//     ),
//   );
//   fToast.showToast(child: toast, toastDuration: const Duration(seconds: 1));
// }

toastSuccess(String text) => Fluttertoast.showToast(
    msg: text,
    toastLength: Toast.LENGTH_SHORT,
    gravity: ToastGravity.TOP,
    timeInSecForIosWeb: 1,
    backgroundColor: AppColor.successColor,
    textColor: AppColor.white,
    fontSize: 16.0);
// {
//   FToast fToast = FToast();
//   fToast.init(navigatorKey.currentContext!);
//   Widget toast = Container(
//     padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
//     decoration: BoxDecoration(
//         borderRadius: BorderRadius.circular(5),
//         color: AppColor.errorColor
//     ),
//     child: Row(
//       mainAxisSize: MainAxisSize.max,
//       children: [
//         SvgPicture.asset('assets/icons/ic_warning.svg'),
//         const SizedBox(width: 10),
//         Expanded(child: Text(text, style: AppTextTheme.textPrimary))
//       ],
//     ),
//   );
//   fToast.showToast(child: toast, toastDuration: const Duration(seconds: 1));
// }

Future<DateTime?> getDatePicker(BuildContext context) async {
  final DateTime? select = await showDatePicker(
      context: context,
      locale: const Locale("vi"),
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now());
  return select;
}

void showGlobalDialog(
    {required String message,
    DialogType dialogType = DialogType.alert,
    Function(dynamic value)? callbackWhenDismiss}) async {
  switch (dialogType) {
    case DialogType.alert:
      await showDialog(
        context: ViewUtils.getRootNavigatorKey().currentContext!,
        builder: (context) => getErrorDialog(
          context: context,
          message: message,
        ),
      ).then((value) => callbackWhenDismiss != null ? callbackWhenDismiss(value) : null);
      break;
    case DialogType.datePicker:
      break;
  }
}

class CornerBottomRightClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    // path.moveTo(size.width,0);
    path.lineTo(size.width, 0);
    path.lineTo(size.width - size.height, size.height);
    path.lineTo(0, size.height);
    // path.lineTo(0.0, size.height);
    // path.fillType = PathFillType.evenOdd;
    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return false;
  }
}

class CrossButtonPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint()
      ..color = Colors.blue
      ..strokeWidth = 20;
    // canvas.drawLine(Offset(0, 0), Offset(size.width, 0), paint);

    final path = Path();
    path.moveTo(size.height, 0);
    path.lineTo(size.width, 0);
    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);
    // path.lineTo(0.0, size.height);
    // path.fillType = PathFillType.evenOdd;
    path.close();
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}

class FolderContainerPainter extends CustomPainter {
  final int radius = 10;
  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint()
      ..color = Colors.white
      ..strokeWidth = 20;
    // canvas.drawLine(const Offset(0, 0), Offset(size.width, 0), paint);

    final path = Path();
    path.moveTo(10, 0);
    path.lineTo(size.width * 2 / 3, 0);
    path.cubicTo(
      size.width * 2 / 3 + 30,
      0,
      size.width * 2 / 3 + 40,
      50,
      size.width * 2 / 3 + 60,
      50,
    );
    path.lineTo(size.width - radius, 50);
    path.quadraticBezierTo(size.width, 50, size.width, 50.0 + radius);
    path.lineTo(size.width, size.height - radius);
    path.quadraticBezierTo(size.width, size.height, size.width - radius, size.height);
    path.lineTo(10, size.height);
    path.quadraticBezierTo(0, size.height, 0, size.height - 10);
    path.lineTo(0, 10);
    path.quadraticBezierTo(0, 0, 10, 0);
    path.close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}

class CornerTopLeftClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    path.moveTo(size.height, 0);
    path.lineTo(size.width, 0);
    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);
    // path.lineTo(0.0, size.height);
    // path.fillType = PathFillType.evenOdd;
    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return false;
  }
}

Future<CroppedFile?> cropImage(File imageFile, ImageCropStyle imageCropStyle) async => await ImageCropper().cropImage(
      sourcePath: imageFile.path,
      cropStyle: imageCropStyle == ImageCropStyle.circle ? CropStyle.circle : CropStyle.rectangle,
      aspectRatio: imageCropStyle == ImageCropStyle.circle || imageCropStyle == ImageCropStyle.square
          ? const CropAspectRatio(ratioX: 1, ratioY: 1)
          : const CropAspectRatio(ratioX: 16, ratioY: 9),
      aspectRatioPresets: [
        CropAspectRatioPreset.square,
      ],
      uiSettings: [
        AndroidUiSettings(
            toolbarTitle: 'Chỉnh sửa',
            toolbarColor: AppColor.primaryColor,
            activeControlsWidgetColor: AppColor.primaryColor,
            showCropGrid: false,
            toolbarWidgetColor: Colors.white,
            lockAspectRatio: false),
        IOSUiSettings(
          title: 'Chỉnh sửa',
        ),
      ],
    );
