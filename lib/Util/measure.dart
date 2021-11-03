import 'dart:ui';

import 'package:flutter_screenutil/flutter_screenutil.dart';

///设计稿尺寸
const Size disignSize = Size(360, 690);

///状态栏高度
final statusBarHeight = ScreenUtil().statusBarHeight;

///底部安全区高度
final bottomBarHeight = ScreenUtil().bottomBarHeight;

///屏幕宽度
final screenWidth = ScreenUtil().screenWidth;

///屏幕高度
final screenHeight = ScreenUtil().screenHeight;

/// 实际宽度设计稿宽度的比例,可以直接使用  xx.w,比如 15.w,就是15乘以宽度比
final scaleWidth = ScreenUtil().scaleWidth;
