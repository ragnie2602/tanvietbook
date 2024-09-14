import 'package:flutter/material.dart';

import 'colors.dart';

class AppTextTheme {
  static const TextStyle textPageTitle = TextStyle(
    color: AppColor.black,
    overflow: TextOverflow.ellipsis,
    fontWeight: FontWeight.w600,
    fontSize: 18,
  );

  static const TextStyle titleLarge = TextStyle(color: AppColor.titleColor, fontSize: 30, fontWeight: FontWeight.w700);

  static const TextStyle textPrimary = TextStyle(
    color: AppColor.black,
    fontWeight: FontWeight.w400,
    fontSize: 14,
  );

  static const TextStyle textPrimaryWhite = TextStyle(
    color: AppColor.white,
    fontWeight: FontWeight.w400,
    fontSize: 14,
  );

  static const TextStyle textPrimarySmall = TextStyle(
    color: AppColor.black,
    fontWeight: FontWeight.w400,
    fontSize: 12,
  );

  static const TextStyle textPrimarySmallItalic = TextStyle(
    color: AppColor.black,
    fontWeight: FontWeight.w400,
    fontSize: 12,
    fontStyle: FontStyle.italic,
  );

  static const TextStyle textPrimaryRed = TextStyle(
    color: AppColor.red,
    fontWeight: FontWeight.w400,
    fontSize: 14,
  );

  static const TextStyle textPrimaryGray05 = TextStyle(
    color: AppColor.gray05,
    fontWeight: FontWeight.w400,
    fontSize: 14,
  );

  static const TextStyle textPrimaryBold = TextStyle(
    color: AppColor.black,
    fontWeight: FontWeight.w600,
    fontSize: 14,
  );

  static const TextStyle textPrimaryItalic = TextStyle(
    color: AppColor.black,
    fontWeight: FontWeight.w400,
    fontSize: 14,
    fontStyle: FontStyle.italic,
  );
  static const TextStyle textPrimaryBoldMedium = TextStyle(
    color: AppColor.black,
    fontWeight: FontWeight.w600,
    fontSize: 16,
  );

  static const TextStyle textPrimaryBoldLarge = TextStyle(
    color: AppColor.black,
    fontWeight: FontWeight.w600,
    fontSize: 20,
  );

  static const TextStyle text70024 = TextStyle(
    color: AppColor.primaryColor,
    fontWeight: FontWeight.w700,
    fontSize: 24,
  );

  static const TextStyle text70014 = TextStyle(
    color: AppColor.primaryColor,
    fontWeight: FontWeight.w700,
    fontSize: 14,
  );

  static const TextStyle textPrimaryColor = TextStyle(
    color: AppColor.primaryColor,
    fontWeight: FontWeight.w400,
    fontSize: 14,
  );

  static const TextStyle textLowPriority = TextStyle(
    color: Color.fromARGB(255, 184, 182, 182),
    fontWeight: FontWeight.w600,
    fontSize: 14,
  );

  static const TextStyle textButtonPrimary = TextStyle(
    color: AppColor.white,
    fontWeight: FontWeight.w600,
    fontSize: 14,
    overflow: TextOverflow.ellipsis,
  );

  static const TextStyle textButtonSecondary = TextStyle(
    color: AppColor.secondaryColor,
    fontWeight: FontWeight.w600,
    fontSize: 14,
    overflow: TextOverflow.ellipsis,
  );

  static const TextStyle textRed = TextStyle(
    color: AppColor.errorColor,
    overflow: TextOverflow.ellipsis,
    fontWeight: FontWeight.w400,
    fontSize: 16,
  );

  static const TextStyle textLink = TextStyle(
      color: AppColor.inform,
      overflow: TextOverflow.ellipsis,
      fontWeight: FontWeight.w400,
      fontSize: 12,
      textBaseline: TextBaseline.ideographic);

  static const TextStyle textDisable = TextStyle(
    color: AppColor.gray04,
    overflow: TextOverflow.ellipsis,
    fontWeight: FontWeight.w400,
    fontSize: 12,
  );

  static const TextStyle bodyRegular = TextStyle(
    color: AppColor.black,
    fontWeight: FontWeight.w500,
    fontFamily: 'Quicksand',
    fontSize: 14,
  );

  static const TextStyle bodyLarge =
      TextStyle(color: Color(0xFF252525), fontWeight: FontWeight.w500, fontFamily: 'Quicksand', fontSize: 20);

  static const TextStyle bodyMedium = TextStyle(
    color: Color(0xFF252525),
    fontWeight: FontWeight.w500,
    fontFamily: 'Quicksand',
    fontSize: 16,
  );

  static const TextStyle bodySmall = TextStyle(
    color: Color(0xFF252525),
    fontWeight: FontWeight.w500,
    fontFamily: 'Quicksand',
    fontSize: 12,
  );

  static const TextStyle bodyStrong = TextStyle(
    color: AppColor.black,
    fontWeight: FontWeight.w700,
    fontFamily: 'Quicksand',
    fontSize: 14,
  );

  static const TextStyle titleSemiLarge = TextStyle(
    color: AppColor.black,
    fontWeight: FontWeight.w600,
    fontFamily: 'Quicksand',
    fontSize: 20,
  );

  static const TextStyle titleMedium = TextStyle(
    color: AppColor.black,
    fontWeight: FontWeight.w600,
    fontFamily: 'Quicksand',
    fontSize: 16,
  );

  static const TextStyle titleRegular = TextStyle(
    color: AppColor.black,
    fontWeight: FontWeight.w600,
    fontFamily: 'Quicksand',
    fontSize: 14,
  );

  static const TextStyle titleSmall = TextStyle(
    color: AppColor.black,
    fontWeight: FontWeight.w600,
    fontFamily: 'Quicksand',
    fontSize: 12,
  );

  static const TextStyle titleTiny = TextStyle(
    color: AppColor.black,
    fontWeight: FontWeight.w600,
    fontFamily: 'Quicksand',
    fontSize: 10,
  );

  static const TextStyle subTitle1 = TextStyle(
    color: AppColor.black,
    fontWeight: FontWeight.w400,
    fontFamily: 'Roboto',
    fontSize: 16,
  );

  static const TextStyle subTitle2 = TextStyle(
    color: AppColor.black,
    fontWeight: FontWeight.w400,
    fontFamily: 'Roboto',
    fontSize: 14,
  );

  static const TextStyle subTitleRed = TextStyle(
    color: AppColor.red,
    fontWeight: FontWeight.w500,
    fontFamily: 'Roboto',
    fontSize: 17,
  );

  static TextStyle bodyDescription = TextStyle(
    color: AppColor.black.withOpacity(0.6),
    fontWeight: FontWeight.w500,
    fontFamily: 'Quicksand',
    fontSize: 12,
  );

  static TextStyle bodyTiny =
      const TextStyle(color: AppColor.white, fontWeight: FontWeight.w500, fontFamily: 'Quicksand', fontSize: 10);

  static TextStyle boldSmall =
      const TextStyle(color: AppColor.red, fontWeight: FontWeight.w700, fontFamily: 'Quicksand', fontSize: 12);

  static TextStyle boldRegular =
      const TextStyle(color: AppColor.red, fontWeight: FontWeight.w700, fontFamily: 'Quicksand', fontSize: 14);

  static TextStyle boldMedium =
      const TextStyle(color: AppColor.red, fontWeight: FontWeight.w700, fontFamily: 'Quicksand', fontSize: 16);

  static const TextStyle calendarSmall =
      TextStyle(color: AppColor.gray14, fontFamily: 'Poppins', fontSize: 12, fontWeight: FontWeight.w500);

  static const TextStyle calendarRegular =
      TextStyle(color: AppColor.gray14, fontFamily: 'Poppins', fontSize: 16, fontWeight: FontWeight.w600);

  static const TextStyle calendarMedium =
      TextStyle(color: AppColor.gray13, fontFamily: 'Poppins', fontSize: 18, fontWeight: FontWeight.w600);

  static const TextStyle calendarLarge =
      TextStyle(color: AppColor.gray13, fontWeight: FontWeight.w500, fontFamily: 'Poppins', fontSize: 44);
}
