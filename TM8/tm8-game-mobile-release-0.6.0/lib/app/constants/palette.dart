import 'package:flutter/material.dart';

// Primary Colors
Color primaryTeal = const Color(0xFF007DB2);
Color primaryTealHover = const Color(0xFF005D96);
Color primaryTealText = const Color(0xFF00A2BF);

// Background Colors
LinearGradient backgroundColor = const LinearGradient(
  begin: Alignment(-0.5, -0.5),
  end: Alignment(0.5, 0.7),
  colors: [
    // Color.fromRGBO(49, 60, 105, 1), old color
    Color.fromRGBO(50, 70, 124, 1),
    // Color.fromRGBO(26, 33, 59, 1), old color
    Color.fromRGBO(27, 37, 69, 1),
  ],
);
Color adminBackgroundColor = const Color(0xFF191C24);

// Achromatic Colors
Color achromatic800 = const Color(0xFF202430);
Color achromatic700 = const Color(0xFF1D2338);
Color achromatic600 = const Color(0xFF2B3347);
Color achromatic500 = const Color(0xFF414E6C);
Color achromatic400 = const Color(0xFF525F83);
Color achromatic300 = const Color(0xFF7D889C);
Color achromatic200 = const Color(0xFFB9B5C4);
Color achromatic100 = const Color(0xFFFAFBFC);

// States Colors
Color errorColor = const Color(0xFFE8617A);
Color errorTextColor = const Color(0xFFE14058);
Color errorSurfaceColor = const Color(0xFFE8617A).withOpacity(0.17);
Color successColor = const Color(0xFF47BF85);
Color successSurfaceColor = const Color(0xFF47BF85).withOpacity(0.17);
Color warningColor = const Color(0xFFEB8154);
Color warningSurfaceColor = const Color(0xFFD4754C).withOpacity(0.17);
Color shadowColor = const Color(0xFF121419);
Color glassEffectColor = const Color(0xFF2C394D);
Color overlayColor = const Color.fromRGBO(0, 0, 0, 0.4);
Color ellipseColor = const Color(0xFF7D45FF).withOpacity(0.4);
Color backgroundColorOpacity = const Color.fromRGBO(42, 47, 58, 0.6);

LinearGradient gameTextShadowColor = const LinearGradient(
  begin: Alignment.bottomCenter,
  end: Alignment.topCenter,
  colors: [
    Color.fromRGBO(0, 0, 0, 0.8),
    Color.fromRGBO(0, 0, 0, 0.5),
    Color.fromRGBO(0, 0, 0, 0.25),
    Color.fromRGBO(0, 0, 0, 0.001),
  ],
);
