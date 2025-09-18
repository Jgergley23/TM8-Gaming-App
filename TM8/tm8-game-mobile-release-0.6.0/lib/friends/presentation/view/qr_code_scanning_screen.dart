import 'package:flutter/material.dart';
import 'package:auto_route/auto_route.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:tm8/app/constants/constants.dart';
import 'package:tm8/app/constants/fonts.dart';
import 'package:tm8/app/constants/palette.dart';
import 'package:tm8/app/widgets/tm8_body_container_widget.dart';
import 'package:tm8/app/widgets/tm8_main_app_bar_scaffold_widget.dart';
import 'package:tm8/app/widgets/tm8_main_button_widget.dart';
import 'package:qr_code_dart_scan/qr_code_dart_scan.dart';

@RoutePage() //QRCodeRoute.page
class QRCodeScanningScreen extends StatefulWidget {
  const QRCodeScanningScreen({
    super.key,
    required this.onCapture,
    required this.permissionStatus,
  });

  final Function(String) onCapture;
  final PermissionStatus permissionStatus;

  @override
  State<QRCodeScanningScreen> createState() => _QRCodeScanningScreenState();
}

class _QRCodeScanningScreenState extends State<QRCodeScanningScreen> {
  @override
  Widget build(BuildContext context) {
    return Tm8BodyContainerWidget(
      child: Scaffold(
        appBar: Tm8MainAppBarScaffoldWidget(
          title: '',
          leading: true,
          navigationPadding: screenPadding,
          leadingColor: achromatic500.withOpacity(0.7),
        ),
        body: QRCodeDartScanView(
          scanInvertedQRCode: true,
          typeScan: TypeScan.live,
          resolutionPreset: QRCodeDartScanResolutionPreset.veryHigh,
          onCapture: (Result result) {
            widget.onCapture(result.text);
            context.maybePop();
          },
          child: Padding(
            padding: screenPadding,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                expanded,
                if (widget.permissionStatus ==
                    PermissionStatus.permanentlyDenied) ...[
                  Text(
                    'Camera permission denied',
                    style: heading4Regular.copyWith(color: achromatic100),
                  ),
                  expanded,
                ],
                Tm8MainButtonWidget(
                  onTap: () {
                    context.maybePop();
                  },
                  buttonColor: primaryTeal.withOpacity(0.7),
                  text: 'My Code',
                ),
                h12,
                Tm8MainButtonWidget(
                  onTap: () {
                    context.maybePop();
                    context.maybePop();
                  },
                  buttonColor: achromatic500.withOpacity(0.7),
                  text: 'Cancel',
                ),
                h20,
              ],
            ),
          ),
        ),
      ),
    );
  }
}
