import 'dart:io';

import 'package:bilibili/Util/color.dart';
import 'package:bilibili/Util/measure.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

enum BrightMode { DARKMODE, LIGHTMODE }

class NavigationBar extends StatelessWidget {
  ///默认高度44
  final double height;

  ///默认暗黑模式
  final BrightMode mode;

  ///默认颜色白色
  final Color color;

  ///子控件
  final Widget child;

  const NavigationBar(
      {Key? key,
      this.height = 44,
      this.mode = BrightMode.DARKMODE,
      this.color = mainWhite,
        required this.child,
      })
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    _initStatusBar();
    return Container(
      width: screenWidth,
      height: height + statusBarHeight,
      padding: EdgeInsets.only(top: statusBarHeight),
      decoration: BoxDecoration(color: color),
      child: child,
    );
  }

  void _initStatusBar() {
    //沉浸式状态栏样式
    var brightness;
    if (Platform.isIOS) {
      brightness = BrightMode == BrightMode.LIGHTMODE
          ? Brightness.dark
          : Brightness.light;
    } else {
      brightness = BrightMode == BrightMode.LIGHTMODE
          ? Brightness.light
          : Brightness.dark;
    }
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light.copyWith(
      statusBarColor: Colors.transparent,
      statusBarBrightness: brightness,
      statusBarIconBrightness: brightness,
    ));
  }
}
