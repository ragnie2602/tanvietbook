import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../../../data/resources/colors.dart';
import '../../etx/view_extensions.dart';
import '../primary_icon_button.dart';

class ImageItem extends StatelessWidget {
  final double? height;
  final XFile image;
  final Function(XFile)? onCancel;
  final EdgeInsets? padding;
  final double? width;

  const ImageItem({super.key, this.height, required this.image, this.onCancel, this.padding, this.width});

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      Padding(
        padding: padding ?? EdgeInsets.zero,
        child: Image.file(File(image.path), height: height ?? context.screenHeight * 0.178, width: width ?? context.screenWidth * 0.178),
      ),
      PrimaryIconButton(
          backgroundColor: AppColor.transparent,
          contentPadding: EdgeInsets.zero,
          context: context,
          elevation: 0,
          icon: Icons.cancel,
          iconColor: AppColor.red,
          onPressed: () {
            if (onCancel != null) onCancel!(image);
          })
    ]);
  }
}
