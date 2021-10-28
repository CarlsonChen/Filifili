import 'package:bilibili/page/detail_page.dart';
import 'package:bilibili/page/home_page.dart';
import 'package:bilibili/page/login_page.dart';
import 'package:bilibili/page/register_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

///创建页面
warpPage(Widget child) {
  return MaterialPage(child: child, key: ValueKey(child.hashCode));
}

///路由状态（page的标识）
enum RouteStatus {
  login,
  registration,
  home,
  detail,
  unknown,
}

///查询页面在路由栈中的位置
int getRouteStackIndex(List<MaterialPage> pages, RouteStatus status) {
  for (int i = 0; i < pages.length; i++) {
    MaterialPage page = pages[i];
    if (getStatus(page) == status) {
      return i;
    }
  }
  return -1; //不在栈中
}

///根据页面查询路由状态(绑带page&routeStatus）
RouteStatus getStatus(MaterialPage page) {
  //login
  if (page.child is LoginPage) {
    return RouteStatus.login;
  }
  //registor
  if (page.child is RegisterPage) {
    return RouteStatus.registration;
  }

  if (page.child is HomePage) {
    return RouteStatus.home;
  }

  if (page.child is DetailPage) {
    return RouteStatus.detail;
  }

  return RouteStatus.unknown;
}

class CsNavigator {}
