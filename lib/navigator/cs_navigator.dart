import 'package:bilibili/page/detail_page.dart';
import 'package:bilibili/page/home_page.dart';
import 'package:bilibili/page/login_page.dart';
import 'package:bilibili/page/register_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

typedef RouteChangeListener(RouteStatusInfo current, RouteStatusInfo? pre);

///路由信息
class RouteStatusInfo {
  final RouteStatus routeStatus;
  final Widget page;

  RouteStatusInfo(this.routeStatus, this.page);
}

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

class CsNavigator extends _RouteJumpListener {
  //单例
  static CsNavigator? _shareInstance;

  CsNavigator._();

  static CsNavigator getShareInstance() {
    return _shareInstance ?? CsNavigator._();
  }

  RouteJumpListener? _routeJump;
  List<RouteChangeListener> _listeners = [];
  RouteStatusInfo? _current;

  //首页底部tab
  RouteStatusInfo? _bottomTab;

  ///首页底部tab切换监听
  void onBottomTabChange(int index, Widget page) {
    _bottomTab = RouteStatusInfo(RouteStatus.home, page);
    _notify(_bottomTab!);
  }

  ///注册路由跳转逻辑
  void registerRouteJump(RouteJumpListener routeJumpListener) {
    this._routeJump = routeJumpListener;
  }

  ///监听路由页面跳转
  void addListener(RouteChangeListener listener) {
    if (!_listeners.contains(listener)) {
      print('添加监听');
      _listeners.add(listener);
    }
  }

  ///移除监听
  void removeListener(RouteChangeListener listener) {
    _listeners.remove(listener);
  }

  @override
  void onJumpTo(RouteStatus routeStatus, {Map? args}) {
    _routeJump?.onJumpTo(routeStatus, args: args);
  }

  ///通知路由页面变化
  void notify(List<MaterialPage> currentPages, List<MaterialPage> prePages) {
    print('是否有变化');
    if (currentPages == prePages) return;
    var current =
        RouteStatusInfo(getStatus(currentPages.last), currentPages.last.child);
    _notify(current);
  }

  void _notify(RouteStatusInfo current) {
    // if (current.page is BottomNavigator && _bottomTab != null) {
    //   //如果打开的是首页，则明确到首页具体的tab
    //   current = _bottomTab!;
    // }
    print('hi_navigator:current:${current.page}');
    print('hi_navigator:pre:${_current?.page}');
    _listeners.forEach((listener) {
      listener(current, _current);
    });
    _current = current;
  }
}

///抽象类供HiNavigator实现
abstract class _RouteJumpListener {
  void onJumpTo(RouteStatus routeStatus, {Map args});
}

typedef OnJumpTo = void Function(RouteStatus routeStatus, {Map? args});

///定义路由跳转逻辑要实现的功能
class RouteJumpListener {
  final OnJumpTo onJumpTo;

  RouteJumpListener({required this.onJumpTo});
}
