import 'package:flutter/widgets.dart';

class Responsive {
  Responsive._();

  static const double mobileBreakpoint = 600;
  static const double tabletBreakpoint = 820;
  static const double desktopBreakpoint = 1200;

  static double widthOf(BuildContext context) {
    return MediaQuery.sizeOf(context).width;
  }

  static bool isMobile(BuildContext context) {
    return widthOf(context) < mobileBreakpoint;
  }

  static bool useTwoColumnLayout(BuildContext context) {
    return widthOf(context) >= tabletBreakpoint;
  }

  static double pagePaddingForWidth(double width) {
    if (width >= desktopBreakpoint) return 40;
    if (width >= mobileBreakpoint) return 28;
    return 20;
  }

  static double contentMaxWidth(double width) {
    if (width >= desktopBreakpoint) return 1120;
    if (width >= mobileBreakpoint) return 900;
    return 560;
  }
}
