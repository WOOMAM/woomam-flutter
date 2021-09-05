import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:woomam/bloc/bloc.dart';
import 'package:woomam/model/model.dart';
import 'dart:io' show Platform;

import '../../control_panel/control_panels.dart';

class QRCodeScreen extends StatefulWidget {
  final bool isSecondQRCheck;
  final String phoneNumber;
  final WashingMachine washingMachine;
  const QRCodeScreen(
      {Key? key,
      required this.phoneNumber,
      required this.washingMachine,
      required this.isSecondQRCheck})
      : super(key: key);

  @override
  _QRCodeScreenState createState() => _QRCodeScreenState();
}

class _QRCodeScreenState extends State<QRCodeScreen> {
  /// variables
  Barcode? scannedResult;
  QRViewController? controller;
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');

  // In order to get hot reload to work we need to pause the camera if the platform
  // is android, or resume the camera if the platform is iOS.
  @override
  void reassemble() {
    super.reassemble();
    if (Platform.isAndroid) {
      controller!.pauseCamera();
    }
    controller!.resumeCamera();
  }

  Widget _buildQrView(BuildContext context) {
    // For this example we check how width or tall the device is and change the scanArea and overlay accordingly.
    var scanArea = (MediaQuery.of(context).size.width < 400 ||
            MediaQuery.of(context).size.height < 400)
        ? 200.0
        : 400.0;
    // To ensure the Scanner view is properly sizes after rotation
    // we need to listen for Flutter SizeChanged notification and update controller
    return QRView(
      key: qrKey,
      onQRViewCreated: _onQRViewCreated,
      overlay: QrScannerOverlayShape(
          borderColor: Colors.pinkAccent,
          borderRadius: 10,
          borderLength: 30,
          borderWidth: 15,
          cutOutSize: scanArea),
      onPermissionSet: (ctrl, p) => _onPermissionSet(context, ctrl, p),
    );
  }

  void _onQRViewCreated(QRViewController controller) {
    setState(() {
      this.controller = controller;
    });
    controller.scannedDataStream.listen((scanData) {
      setState(() {
        scannedResult = scanData;
      });
      if (scannedResult != null) {
        /// dispose controller - QR
        this.controller!.dispose();
        if (widget.isSecondQRCheck) {
          /// add event for QR check
          BlocProvider.of<WashingMachineBloc>(context).add(
              InitWashingMachineEvent(washingMachine: widget.washingMachine));
        } else {
          /// add event for QR check
          BlocProvider.of<WashingMachineBloc>(context).add(
              ConfirmUserToWashingMachineEvent(
                  currentUserPhoneNumber: widget.phoneNumber,
                  washingMachineUID: widget.washingMachine.washingMachineUID));
        }
        Navigator.pop(
            context,
            (res) =>
                showCustomSnackbar(context: context, msg: 'QR 인증이 완료되었습니다'));
      }
    });
  }

  void _onPermissionSet(BuildContext context, QRViewController ctrl, bool p) {
    log('${DateTime.now().toIso8601String()}_onPermissionSet $p',
        name: 'QRCODE');
    if (!p) showCustomSnackbar(context: context, msg: 'no permission');
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryColor,
      appBar: AppBar(
        title: const Text('QR CODE'),
        backgroundColor: primaryColor,
        actions: [
          IconButton(
              onPressed: () async {
                await controller?.flipCamera();
                setState(() {});
              },
              icon: const Icon(FeatherIcons.shuffle))
        ],
      ),
      body: Column(
        children: <Widget>[
          Expanded(flex: 7, child: _buildQrView(context)),
          Expanded(
            flex: 3,
            child: Container(
              padding: paddingHV(16, 8),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  if (scannedResult != null)
                    Text(
                      scannedResult!.code,
                      style: headlineTextStyle(color: Colors.white),
                      maxLines: null,
                    )
                  else
                    Text(
                      widget.isSecondQRCheck
                          ? 'QR코드 스캔 후 완성된 빨래를 찾아가세요 🤩'
                          : '세탁기 옆 QR 코드를 스캔해 세탁기를 돌려보세요 🧐',
                      style: headlineTextStyle(color: Colors.white),
                    ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
