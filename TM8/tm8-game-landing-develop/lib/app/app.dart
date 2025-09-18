import 'package:beamer/beamer.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tm8l/app/router/router.dart';
import 'package:tm8l/app/services/service_locator.dart';
import 'package:tm8l/app/theme/tm8l_theme.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: sl.allReady(timeout: const Duration(milliseconds: 500)),
      builder: (context, widget) {
        // FlutterNativeSplash.remove();
        return ScreenUtilInit(
          designSize: const Size(360, 800),
          builder: (context, child) {
            return LayoutBuilder(
              builder: (context, con) {
                return MaterialApp.router(
                  scrollBehavior: MyCustomScrollBehavior(),
                  debugShowCheckedModeBanner: false,
                  routerDelegate: sl<AppRouter>().routerDelegate,
                  routeInformationParser: BeamerParser(),
                  theme: Tm8GameLandingTheme.dark,
                  // localizationsDelegates: const [
                  //   AppLocalizations.delegate,
                  //   GlobalMaterialLocalizations.delegate,
                  //   FormBuilderLocalizations.delegate,
                  // ],
                  // supportedLocales: AppLocalizations.supportedLocales,
                );
              },
            );
          },
        );
      },
    );
  }
}

class MyCustomScrollBehavior extends MaterialScrollBehavior {
  // Override behavior methods and getters like dragDevices
  @override
  Set<PointerDeviceKind> get dragDevices => {
        PointerDeviceKind.touch,
        PointerDeviceKind.mouse,
      };
}
