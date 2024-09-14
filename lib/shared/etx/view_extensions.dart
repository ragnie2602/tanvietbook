import 'package:flutter/material.dart';
import '../../data/constants.dart';

extension BuildContextExt on BuildContext {
  double get screenHeight => MediaQuery.of(this).size.height;
  double get screenWidth => MediaQuery.of(this).size.width;
  dynamic get arguments => ModalRoute.of(this)?.settings.arguments;

  AppPlatform get platform {
    var shortestSide = MediaQuery.of(this).size.shortestSide;
    return shortestSide < 550 ? AppPlatform.mobile : AppPlatform.tablet;
  }

  dynamic showAppDialog(Dialog dialog, {bool barrierDismissible = true}) =>
      showDialog(
          context: this,
          builder: (context) => dialog,
          barrierDismissible: barrierDismissible);

  void pop([dynamic result]) {
    if (Navigator.of(this).canPop()) Navigator.of(this).pop(result);
  }

  ensureVisible() {
    Scrollable.ensureVisible(this,
        duration: const Duration(milliseconds: 200), alignment: 0.1);
  }
}

extension FormStateExtension on GlobalKey<FormState> {
  bool validateAndScroll() {
    if (!currentState!.validate()) {
      currentContext!.ensureVisible();
      return false;
    }
    return true;
  }
}
