import 'dart:developer';
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:path_provider/path_provider.dart';
import 'package:qr_flutter/qr_flutter.dart';
import '../../config/config.dart';
import '../../data/resources/resources.dart';
import '../../shared/utils/utils.dart';
import '../../shared/utils/view_utils.dart';
import '../../shared/widgets/primary_button.dart';
import 'package:screenshot/screenshot.dart';
import 'package:share_plus/share_plus.dart';

class MyQrCode extends StatelessWidget {
  final String username;
  final String fullName;
  final String avatarUrl;

  // final String avatarUrl;

  const MyQrCode(
      {Key? key,
      required this.username,
      required this.fullName,
      required this.avatarUrl})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    ScreenshotController screenshotController = ScreenshotController();
    final size = MediaQuery.of(context).size;
    return Dialog(
      child: ConstrainedBox(
        constraints: const BoxConstraints(
            // maxHeight: 500,
            minHeight: 150),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Screenshot(
              controller: screenshotController,
              child: Container(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                      colors: [Color(0xFF0FAE7E), Color(0xFF078947)],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      stops: [0.0, 1.0],
                      tileMode: TileMode.clamp),
                ),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Row(
                        children: [
                          CircleAvatar(
                            backgroundColor: Colors.white,
                            backgroundImage: NetworkImage(avatarUrl),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(fullName,
                                    style: AppTextTheme.textPrimary.copyWith(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w600)),
                                const SizedBox(height: 4),
                                Text(
                                  'Mã QR code của $fullName trên True Connect',
                                  style: AppTextTheme.textPrimarySmall
                                      .copyWith(color: Colors.white),
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                    const Divider(height: 0.5),
                    Container(
                      padding: const EdgeInsets.all(20.0),
                      height: MediaQuery.of(context).size.width * 0.5,
                      width: MediaQuery.of(context).size.width * 0.5,
                      child: Stack(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(2),
                            child: QrImageView(
                              data: '${Environment.domain}/profile/$username',
                              size: MediaQuery.of(context).size.width * 0.5,
                              errorCorrectionLevel: QrErrorCorrectLevel.H,
                              backgroundColor: AppColor.white,
                            ),
                          ),
                          Center(
                            child: CircleAvatar(
                                radius: 25,
                                backgroundColor: AppColor.white,
                                child: Padding(
                                  padding: const EdgeInsets.all(6.0),
                                  child: SvgPicture.asset(
                                    Assets.icLogo,
                                    width: 50,
                                    height: 50,
                                    // fit: BoxFit.cover,
                                  ),
                                )),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const Divider(height: 0.5),
            Container(
                width: double.infinity,
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                decoration: const BoxDecoration(
                  color: Color(0xFF078947),
                ),
                child: Row(
                  children: [
                    Expanded(
                        child: PrimaryButton(
                      context: context,
                      onPressed: () {
                        screenshotController.capture().then((image) async {
                          if (image == null) return;
                          final directoryPath =
                              (await getApplicationDocumentsDirectory()).path;
                          final imagePath = File(
                              '$directoryPath/qr-$username-${Utils.getDateTimeNowIso()}.png');
                          await imagePath.writeAsBytes(image);

                          await Share.shareXFiles([XFile(imagePath.path)],
                              subject: 'TrueConnect: Chia sẻ mã QR với bạn',
                              text:
                                  'Xin vui lòng quét mã QR của $username để xem thông tin cá nhân và doanh nghiệp.',
                              sharePositionOrigin: Rect.fromLTWH(
                                  0, 0, size.width, size.height / 2)
                              // (context.findRenderObject()
                              //             as RenderBox?)!
                              //         .localToGlobal(Offset.zero) &
                              //     (context.findRenderObject()
                              //             as RenderBox)
                              //         .size,
                              );
                        }).catchError((onError) {});
                      },
                      label: 'Chia sẻ QR',
                      backgroundColor: Colors.white,
                      icon: Icons.share_outlined,
                      iconColor: AppColor.black,
                      borderColor: AppColor.neutral5,
                      textStyle: AppTextTheme.textButtonPrimary
                          .copyWith(color: AppColor.black),
                    )),
                    const SizedBox(
                      width: 10,
                    ),
                    Expanded(
                        child: PrimaryButton(
                            context: context,
                            onPressed: () async {
                              screenshotController
                                  .capture()
                                  .then((image) async {
                                if (image == null) return;
                                final directoryPath =
                                    (await getApplicationDocumentsDirectory())
                                        .path;
                                final imagePath =
                                    '$directoryPath/qr-$username-${Utils.getDateTimeNowIso()}.png';

                                // save the image to gallery
                                await ImageGallerySaver.saveImage(
                                  Uint8List.fromList(image),
                                  name: imagePath,
                                );
                                // ignore: use_build_context_synchronously
                                Navigator.of(context).pop();
                                toastSuccess('Đã tải xuống thành công!');
                              }).catchError((onError) {
                                log('capture error: $onError');
                              });
                            },
                            label: 'Tải xuống QR',
                            icon: Icons.file_download_outlined,
                            borderColor: AppColor.neutral5,
                            backgroundColor: Colors.white,
                            iconColor: AppColor.black,
                            textStyle: AppTextTheme.textButtonPrimary.copyWith(
                              color: AppColor.black,
                            ))),
                  ],
                )),
          ],
        ),
      ),
    );
  }
}
