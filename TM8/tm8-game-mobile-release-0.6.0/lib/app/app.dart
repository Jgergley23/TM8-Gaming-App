import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tm8/app/router/router.dart';
import 'package:tm8/app/services/service_locator.dart';
import 'package:tm8/app/theme/tm8_game_mobile_theme.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: sl.allReady(timeout: const Duration(milliseconds: 500)),
      builder: (context, widget) {
        FlutterNativeSplash.remove();
        return ScreenUtilInit(
          designSize: const Size(360, 800),
          builder: (context, child) {
            return LayoutBuilder(
              builder: (context, con) {
                return MaterialApp.router(
                  debugShowCheckedModeBanner: false,
                  routerDelegate: sl<AppRouter>().delegate(),
                  routeInformationParser: sl<AppRouter>().defaultRouteParser(),
                  theme: Tm8GameMobileTheme.dark,
                );
              },
            );
          },
        );
      },
    );
  }
}
