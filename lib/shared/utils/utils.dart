import 'dart:convert';
import 'dart:developer';
import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:intl/intl.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

import '../../data/constants.dart';
import 'icon_assets.dart';
import 'view_utils.dart';

class Utils {
  static bool compareDate(DateTime datetime1, DateTime datetime2, {bool includeTime = false}) {
    if (includeTime) {
      return datetime1.compareTo(datetime2) == 0;
    } else {
      return datetime1.year == datetime2.year && datetime1.month == datetime2.month && datetime1.day == datetime2.day;
    }
  }

  static String formatDate(String strDate, {bool showTime = false}) {
    try {
      var dateFormat = showTime ? DateFormat('dd/MM/yyyy HH:mm') : DateFormat('dd/MM/yyyy');
      return dateFormat.format(DateTime.parse(strDate)).toString();
    } catch (e) {
      return strDate;
    }
  }

  static String formatAddress(String? address, String? commune, String? district, String? city) {
    return (address != null && address.isNotEmpty ? '$address, ' : '') +
        (commune != null && commune.isNotEmpty ? '$commune, ' : '') +
        (district != null && district.isNotEmpty ? '$district, ' : '') +
        (city != null && city.isNotEmpty ? city : '');
  }

  static String toStringDate(String strDate, {bool showTime = false, String letterDivider = '-'}) {
    try {
      var dateStandardFormat = showTime
          ? DateFormat('dd${letterDivider}MM${letterDivider}yyyy HH:mm:ss')
          : DateFormat('dd${letterDivider}MM${letterDivider}yyyy');

      return dateStandardFormat.format(DateTime.parse(strDate)).toString();
    } catch (e) {
      return strDate;
    }
  }

  static String toStringIsoDate(String strDate) {
    try {
      var dateFormat = DateFormat('dd/MM/yyyy');
      var dateFormatIso = DateFormat("yyyy-MM-dd'T'HH:mm:ss'Z'");
      return dateFormatIso.format(dateFormat.parse(strDate));
    } catch (e) {
      log(e.toString());
      return strDate;
    }
  }

  static String toStringIsoDateTime(String strDate, {String letterDivider = '-'}) {
    try {
      var dateFormat = letterDivider == '-' ? DateFormat('yyyy-MM-dd HH:mm:ss') : DateFormat('dd/MM/yyyy HH:mm:ss');
      var dateFormatIso = DateFormat("yyyy-MM-dd'T'HH:mm:ss'Z'");
      return dateFormatIso.format(dateFormat.parse(strDate));
    } catch (e) {
      log(e.toString());
      return strDate;
    }
  }

  static DateTime? dateTimeFromString(String? strDate) {
    try {
      return DateTime.parse(strDate ?? '');
    } catch (e) {
      log(e.toString());
      return null;
    }
  }

  static String toTime(String strDate, {bool showSecond = false, bool letterDivider = false}) {
    try {
      var timeFormat = letterDivider
          ? DateFormat('HH\'h\'mm')
          : showSecond
              ? DateFormat('HH:mm:ss')
              : DateFormat('HH:mm');
      var dateFormatIso = DateFormat('yyyy-MM-ddTHH:mm:ss');

      return timeFormat.format(dateFormatIso.parse(strDate));
    } catch (e) {
      log(e.toString());
      return strDate;
    }
  }

  static String toWeekDayString(int weekDay, {bool fullText = false}) {
    switch (weekDay) {
      case 1:
        return fullText ? 'Thứ hai' : 'M';
      case 2:
        return fullText ? 'Thứ ba' : 'T';
      case 3:
        return fullText ? 'Thứ tư' : 'W';
      case 4:
        return fullText ? 'Thứ năm' : 'T';
      case 5:
        return fullText ? 'Thứ sáu' : 'F';
      case 6:
        return fullText ? 'Thứ bảy' : 'S';
      case 7:
        return fullText ? 'Chủ nhật' : 'S';
      default:
        return '';
    }
  }

  static String getDateTimeNowIso() {
    var dateFormatIso = DateFormat("yyyy-MM-dd'T'HH:mm:ss'Z'");
    return dateFormatIso.format(DateTime.now()).toString();
  }

  static String secondToTime(int seconds) {
    int hours = seconds ~/ 3600;
    int minutes = (seconds - hours * 3600) ~/ 60;
    int secondMods = seconds - hours * 3600 - minutes * 60;
    return '${hours.toString().padLeft(2, '0')}:${minutes.toString().padLeft(2, '0')}:${secondMods.toString().padLeft(2, '0')}';
  }

  static bool isToday(String strDateTime) {
    if (strDateTime.isEmpty) return false;
    try {
      final now = DateTime.now();
      final dateTime = DateTime.parse(strDateTime);
      final diff = dateTime.difference(DateTime(now.year, now.month, now.day));

      return diff.inMilliseconds > 0 && diff.inMilliseconds < 24 * 60 * 60 * 1000;
    } catch (e) {
      return false;
    }
  }

  static String formatMoney(double money) {
    try {
      var moneyFormat = NumberFormat('#,###');
      return '${moneyFormat.format(money)}đ';
    } catch (e) {
      return '$moneyđ';
    }
  }

  static String getDiffDate(DateTime time) {
    // try {
    final DateFormat formatDate = DateFormat('dd/MM/yyyy HH:mm');
    //   final date = DateTime.now();
    //   final duration = date.difference(time);
    //   if (duration.inDays > 0) {
    //     return formatDate.format(time);
    //   } else if (duration.inHours > 0) {
    //     return '${duration.inHours} giờ trước';
    //   } else if (duration.inMinutes > 0) {
    //     return '${duration.inMinutes} phút trước';
    //   } else {
    //     return 'Vừa xong';
    //   }
    // } catch (e) {
    return formatDate.format(time);
    //   }
  }

  static String convertHtmlToText(String text) {
    return text.replaceAll(RegExp(r'<p>'), '').replaceAll(RegExp(r'</p>'), '\n').replaceAll(RegExp(r'<br>'), '\n');
  }

  static Document parseQuillDocument(String? data) {
    try {
      final List documentData = data == null
          ? [
              {"insert": "\n"}
            ]
          : (jsonDecode(data) is Map && jsonDecode(data)['ops'] != null)
              ? jsonDecode(data)['ops']
              : jsonDecode(data);

      // remove size set by px. E.g: 14px
      // flutter quill only accepts the fontSize type: small, large, huge

      return Document.fromJson(
        documentData.map((e) {
          if (e['attributes'] != null && e['attributes']['size'] != null) {
            if (e['attributes']['size'] is String && (e['attributes']['size'] as String).contains('px')) {
              int fontSizeInPx = int.tryParse((e['attributes']['size'] as String).replaceAll('px', '')) ?? 14;
              if (fontSizeInPx < 14) {
                e['attributes']['size'] = 'small';
              } else if (fontSizeInPx < 18) {
                e['attributes']['size'] = 'large';
              } else {
                e['attributes']['size'] = 'huge';
              }
            }
          }
          return e;
        }).toList(),
      );
    } catch (e) {
      return Document.fromJson([
        {"insert": "\n"}
      ]);
    }
  }

  static void share({required String content, required BuildContext context, String? subject}) async {
    final box = context.findRenderObject() as RenderBox?;
    await Share.share(
      content,
      subject: subject,
      sharePositionOrigin: box!.localToGlobal(Offset.zero) & box.size,
    );
  }

  static Future<bool> launchUri(String uriPath, UriType uriType, {LaunchMode? mode}) async {
    final Uri uri;
    switch (uriType) {
      case UriType.phone:
        uri = Uri(
          scheme: 'tel',
          path: uriPath,
        );
        break;
      case UriType.email:
        uri = Uri(
          scheme: 'mailto',
          path: uriPath,
        );
        break;
      case UriType.website:
        uri = Uri.parse(uriPath);
        break;
      case UriType.zalo:
        uri = Uri(
          scheme: 'https://zalo.me/',
          path: uriPath,
        );
        break;
      case UriType.sms:
        uri = Uri(scheme: 'sms', path: uriPath);
    }

    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: mode ?? LaunchMode.platformDefault).then((value) {});
      return true;
    } else {
      toastWarning('Không thể mở đường dẫn tới liên kết này');
      return false;
    }
  }

  static String? textEmptyValidator(
    String? text,
  ) {
    if (text == null || text.isEmpty || text.toString().trim().isEmpty) {
      return 'Không được để trống';
    }
    return null;
  }

  static String? emailValidator(
    String? text,
  ) {
    if (text == null || text.isEmpty) {
      return 'Email không được để trống';
    }
    final bool emailValid =
        RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(text);
    if (!emailValid) return 'Email không đúng định dạng';
    return null;
  }

  static String? phoneValidator(String? text) {
    if (text == null || text.isEmpty) {
      return 'Só điện thoại không được để trống';
    }
    if (text.length != 10) {
      if (!RegExp(r'^0\d{9}$').hasMatch(text)) return 'Số điện thoại không hợp lệ';
    }
    return null;
  }

  static String intToHexadecimal(int value) {
    return "#${value.toRadixString(16).padLeft(8, '0').substring(2).toUpperCase()}";
  }

  static String? convertUrlToYoutubeVideoId(String url, {bool trimWhitespaces = true}) {
    if (trimWhitespaces) url = url.trim();

    for (var exp in [
      RegExp(r"^https:\/\/(?:www\.|m\.)?youtube\.com\/watch\?v=([_\-a-zA-Z0-9]{11}).*$"),
      RegExp(r"^https:\/\/(?:www\.|m\.)?youtube(?:-nocookie)?\.com\/embed\/([_\-a-zA-Z0-9]{11}).*$"),
      RegExp(r"^https:\/\/youtu\.be\/([_\-a-zA-Z0-9]{11}).*$")
    ]) {
      Match? match = exp.firstMatch(url);
      if (match != null && match.groupCount >= 1) {
        return match.group(1);
      }
    }

    return null;
  }

  static String getThumbnail({
    required String videoId,
    String quality = ThumbnailQuality.standard,
    bool webp = true,
  }) =>
      webp ? 'https://i3.ytimg.com/vi_webp/$videoId/$quality.webp' : 'https://i3.ytimg.com/vi/$videoId/$quality.jpg';

  static String getIconUrlByType(String type) {
    String url = '';
    for (var element in socialOptions) {
      if ((element['value'] as Map)['type'] == type) {
        url = (element['value'] as Map)['iconUrl'];
        break;
      }
    }
    return url;
  }

  static String getBankIconUrlByType(String type) {
    String url = '';
    for (var element in bankOptions) {
      if ((element['value'] as Map)['type'] == type) {
        url = (element['value'] as Map)['iconUrl'];
        break;
      }
    }
    return url;
  }

  static String getSocialLabelByType(String type) {
    String label = '';
    for (var element in socialOptions) {
      if ((element['value'] as Map)['type'] == type) {
        label = element['label'].toString();
        break;
      }
    }
    return label;
  }

  static double distanceBetween(double fromLatitude, double fromLongitude, double toLatitude, double toLongitude) {
    double fromLatitudeRad = fromLatitude * (math.pi / 180),
        fromLongitudeRad = fromLongitude * (math.pi / 180),
        toLatitudeRad = toLatitude * (math.pi / 180),
        toLongitudeRad = toLongitude * (math.pi / 180);
    double deltaLatitude = toLatitudeRad - fromLatitudeRad, deltaLongitude = toLongitudeRad - fromLongitudeRad;

    return 6371 *
        2 *
        math.asin(math.sqrt(math.sin(deltaLatitude / 2) * math.sin(deltaLatitude / 2) +
            math.cos(fromLatitudeRad) *
                math.cos(toLatitudeRad) *
                math.sin(deltaLongitude / 2) *
                math.sin(deltaLongitude / 2)));
  }

  static String formatNumber(int number, {String divider = '.'}) {
    var s = number.toString().split('').reversed.join();
    s = s.replaceAllMapped(RegExp(r'.{3}'), (match) => '${match.group(0)}.');
    s = s.split('').reversed.join();
    if (s[0] == '.') {
      s = s.replaceRange(0, 1, '');
    }

    return s;
  }
}
