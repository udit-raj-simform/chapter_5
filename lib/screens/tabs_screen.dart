import 'package:chapter_5/tabs/android.dart';
import 'package:chapter_5/tabs/ios.dart';
import 'package:flutter/material.dart';

class TabsScreen extends StatelessWidget {
  TabsScreen({Key? key, required this.tabIndex}) : super(key: key);
  final int tabIndex;

  List<Widget> tabScreens = const <Widget>[AndroidScreen(), IOSScreen()];

  @override
  Widget build(BuildContext context) {
    return tabScreens[tabIndex];
  }
}
