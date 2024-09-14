import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:scan/scan.dart';
import '../../config/config.dart';

import '../../config/routes.dart';
import '../../data/constants.dart';
import '../../shared/widgets/back_button.dart';
import '../base/base_page_sate.dart';
import '../base/bloc/common/common_cubit.dart';
import '../user_profile/user_profile.dart';

class CustomQrCode extends StatefulWidget {
  const CustomQrCode({Key? key}) : super(key: key);

  @override
  State<CustomQrCode> createState() => _CustomQrCodeState();
}

class _CustomQrCodeState extends BasePageState<CustomQrCode, CommonCubit> {
  final qrKey = GlobalKey(debugLabel: 'QR');
  Barcode? barcode;
  QRViewController? controller;

  @override
  EdgeInsets get padding => EdgeInsets.zero;

  @override
  void dispose() {
    super.dispose();
    controller?.dispose();
  }

  @override
  Widget buildPage(BuildContext context) {
    return Stack(
      children: [
        QRView(
          key: qrKey,
          onQRViewCreated: onQRViewCreated,
          overlay: QrScannerOverlayShape(
            borderColor: primaryColor,
            borderRadius: 10,
            borderLength: 30,
            borderWidth: 10,
            cutOutSize: MediaQuery.of(context).size.width * 0.7,
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const BackButtonCustom(),
            GestureDetector(
              onTap: () {
                scanImage();
              },
              child: const Padding(
                padding: EdgeInsets.all(8.0),
                child: Icon(Icons.image_search, color: Colors.white, size: 24),
              ),
            )
          ],
        ),
      ],
    );
  }

  String lastestData = '';

  void onQRViewCreated(QRViewController controller) {
    log('scanning......');

    this.controller = controller;
    controller.resumeCamera();

    controller.scannedDataStream.listen((scanData) async {
      barcode = scanData;
      handleScannerData(controller, barcode!.code!);
    });
  }

  scanImage() async {
    controller?.pauseCamera();
    final image = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (image == null) return;
    String? result = await Scan.parse(image.path);
    handleScannerData(controller!, result ?? '');
  }

  void handleScannerData(QRViewController controller, String data) async {
    log('data: $data');
    if (data.contains('/ano/')) {
      lastestData = data;
      final anoCardId = data.split('/ano/')[1];
      log('ano: $anoCardId');
      controller.pauseCamera();
      await Navigator.pushNamed(context, AppRoute.anoCardActivate,
          arguments: AnoCardActivationPageArgs(cardId: anoCardId));

      controller.resumeCamera();
    } else if (data.contains('/scancard/') || data.contains('/profile/')) {
      controller.pauseCamera();
      String username = data
          .split(data.contains('/scancard/') ? '/scancard/' : '/profile/')
          .last;

      await Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => UserProfile(
                    viewType: ViewType.viewMember,
                    memberUserName: username,
                    memberFullName: username,
                  )));
      controller.resumeCamera();
    } else {
      controller.pauseCamera();
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Thông báo'),
          content: const Text('Mã QR không hợp lệ.'),
          actions: <Widget>[
            TextButton(
              onPressed: () =>
                  {Navigator.pop(context), controller.resumeCamera()},
              child: const Text('Đồng ý'),
            ),
          ],
        ),
      );
    }
  }
}
