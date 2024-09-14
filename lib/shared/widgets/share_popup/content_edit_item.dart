import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../data/resources/colors.dart';
import '../../../data/resources/themes.dart';
import '../bouncing.dart';

class ContentEditItem {
  final String text;
  final Widget? icon;
  Function? onTap;

  ContentEditItem({
    required this.text,
    this.icon,
    this.onTap,
  });
}

class ContentEditItems {
  final List<ContentEditItem> items;

  const ContentEditItems({required this.items});

  static final addPicture = ContentEditItem(
      text: 'Thêm ảnh', icon: SvgPicture.asset("assets/icons/ic_add.svg"));
  static final edit = ContentEditItem(
      text: 'Chỉnh sửa', icon: SvgPicture.asset("assets/icons/ic_edit2.svg"));
  static final function = ContentEditItem(
      text: 'Chức năng',
      icon: SvgPicture.asset("assets/icons/ic_function.svg"));
  static final changePosition = ContentEditItem(
      text: 'Đổi vị trí',
      icon: SvgPicture.asset("assets/icons/ic_change_position.svg"));
  static final delete = ContentEditItem(
      text: 'Xóa', icon: SvgPicture.asset("assets/icons/ic_delete.svg"));
  static final config = ContentEditItem(
      text: 'Cấu hình', icon: SvgPicture.asset("assets/icons/ic_config.svg"));
  static final align = ContentEditItem(
      text: 'Căn lề', icon: SvgPicture.asset("assets/icons/ic_alignment.svg"));
  static final changeBackgroundImage = ContentEditItem(
      text: 'Sửa hình nền',
      icon: SvgPicture.asset("assets/icons/ic_config.svg"));

  static Widget buildItem(ContentEditItem item) {
    return Bouncing(
      child: GestureDetector(
        onTap: () {
          if (item.onTap != null) {
            item.onTap!();
          }
        },
        child: Container(
          width: 85,
          margin: const EdgeInsets.symmetric(horizontal: 5),
          padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
          decoration: BoxDecoration(
              color: AppColor.gray10, borderRadius: BorderRadius.circular(2)),
          alignment: Alignment.center,
          child: Column(
            children: [
              item.icon ?? const SizedBox(),
              const SizedBox(
                height: 3,
              ),
              Text(
                item.text,
                style: AppTextTheme.textPrimarySmall,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
