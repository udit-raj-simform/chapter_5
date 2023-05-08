import 'package:flutter/material.dart';

mixin Constants {
  static final MediaQueryData _mediaQueryData =
      MediaQueryData.fromWindow(WidgetsBinding.instance.window);
  static final Size size = _mediaQueryData.size;

  static final deviceHeight = size.height;
  static final deviceWidth = size.width;
  static final scaffoldHeight =
      deviceHeight - kToolbarHeight - kBottomNavigationBarHeight;

  static const paddingAll = EdgeInsets.all(20.0);
  static const paddingSym =
      EdgeInsets.symmetric(horizontal: 12.0, vertical: 15.0);
  static const marginAll = EdgeInsets.all(20.0);
  static const marginSym =
      EdgeInsets.symmetric(horizontal: 24.0, vertical: 15.0);
}
