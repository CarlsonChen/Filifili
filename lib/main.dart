import 'package:bilibili/Util/color.dart';
import 'package:bilibili/Util/toast.dart';
import 'package:bilibili/db/hi_cache.dart';
import 'package:bilibili/http/dao/login_dao.dart';
import 'package:bilibili/model/video_model.dart';
import 'package:bilibili/navigator/cs_navigator.dart';
import 'package:bilibili/page/detail_page.dart';
import 'package:bilibili/page/home_page.dart';
import 'package:bilibili/page/login_page.dart';
import 'package:bilibili/page/register_page.dart';
import 'package:bilibili/page/test_input.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<HiCache>(
      future: HiCache.preInit(),
      builder: (BuildContext context, AsyncSnapshot<HiCache> snapshot) {
        var widget = snapshot.connectionState == ConnectionState.done
            ? Router(routerDelegate: BiliRouteDelegate())
            : const Scaffold(
                body: Center(
                  child: CircularProgressIndicator(),
                ),
              );
        return MaterialApp(
          home: widget,
          theme: ThemeData(primarySwatch: mainWhite),
        );
      },
    );
  }
}

class BiliRouteDelegate extends RouterDelegate<BiliRoutePath>
    with ChangeNotifier, PopNavigatorRouterDelegateMixin {
  final GlobalKey<NavigatorState> navigatorKey;

  //为Navigator设置一个key，必要的时候可以通过navigatorKey.currentState来获取到NavigatorState对象
  BiliRouteDelegate() : navigatorKey = GlobalKey<NavigatorState>() {}

  RouteStatus _routeStatus = RouteStatus.home;
  List<MaterialPage> pages = [];
  VideoModel? model;

  // BiliRoutePath? path;

  @override
  Widget build(BuildContext context) {
    int index = getRouteStackIndex(pages, _routeStatus);
    var tempPages = pages;
    //如果在栈中,则清除这个页面和上面所有页面，重新添加此页面到栈顶
    if (index != -1) {
      tempPages = tempPages.sublist(0, index);
    }
    var page;
    switch (_routeStatus) {
      case RouteStatus.home:
        tempPages.clear();
        page = warpPage(const HomePage());
        break;
      case RouteStatus.detail:
        page = warpPage(DetailPage());
        break;
      case RouteStatus.login:
        page = warpPage(LoginPage());
        break;
      case RouteStatus.registration:
        page = warpPage(RegisterPage());
        break;
    }
    tempPages = [...tempPages, page];
    //通知路由栈发生改变
    pages = tempPages;

    return WillPopScope(
      //fix Android物理返回键，无法返回上一页问题@https://github.com/flutter/flutter/issues/66349
      onWillPop: () async =>
          !(await navigatorKey.currentState?.maybePop() ?? false),
      child: Navigator(
        key: navigatorKey,
        pages: pages,
        onPopPage: (route, result) {
          if (route.settings is MaterialPage) {
            //登录页未登录返回拦截
            if ((route.settings as MaterialPage).child is LoginPage) {
              if (!hasLogin) {
                showWarningToast("请先登录");
                return false;
              }
            }
          }
          if (!route.didPop(result)) {
            return false;
          }
          pages.removeLast();
          return true;
        },
      ),
    );
  }

  RouteStatus get routeStatus {
    if (_routeStatus != RouteStatus.registration && !hasLogin) {
      return _routeStatus = RouteStatus.login;
    } else if (model != null) {
      return _routeStatus = RouteStatus.detail;
    } else {
      return _routeStatus;
    }
  }

  bool get hasLogin => LoginDao.getBoardingPass() != null;

  @override
  Future<void> setNewRoutePath(BiliRoutePath configuration) async {}
}

class BiliRoutePath {
  final String location;

  BiliRoutePath.home() : location = "/";

  BiliRoutePath.detail() : location = "/detail";
}
