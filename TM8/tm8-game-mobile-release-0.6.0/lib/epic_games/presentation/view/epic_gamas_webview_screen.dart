import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:tm8/app/constants/constants.dart';
import 'package:tm8/app/widgets/tm8_body_container_widget.dart';
import 'package:tm8/app/widgets/tm8_main_app_bar_widget.dart';
import 'package:webview_flutter/webview_flutter.dart';

@RoutePage() //EpicGamesWebViewRoute.page
class EpicGamesWebViewScreen extends StatefulWidget {
  const EpicGamesWebViewScreen({super.key, required this.controller});

  final WebViewController controller;

  @override
  State<EpicGamesWebViewScreen> createState() => _EpicGamesWebViewScreenState();
}

class _EpicGamesWebViewScreenState extends State<EpicGamesWebViewScreen> {
  @override
  Widget build(BuildContext context) {
    return Tm8BodyContainerWidget(
      child: Scaffold(
        body: Column(
          children: [
            const Tm8MainAppBarWidget(
              leading: true,
              title: 'Epic Games',
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              spaceBetween: true,
            ),
            h24,
            Expanded(child: WebViewWidget(controller: widget.controller)),
          ],
        ),
      ),
    );
  }
}
