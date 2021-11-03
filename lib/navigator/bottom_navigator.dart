import 'package:bilibili/Util/color.dart';
import 'package:bilibili/navigator/hi_navigator.dart';
import 'package:bilibili/page/favorite_page.dart';
import 'package:bilibili/page/home_page.dart';
import 'package:bilibili/page/mine_page.dart';
import 'package:bilibili/page/ranking_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BottomNavigator extends StatefulWidget {
  const BottomNavigator({Key? key}) : super(key: key);

  @override
  _BottomNavigatorState createState() => _BottomNavigatorState();
}

class _BottomNavigatorState extends State<BottomNavigator> {
  final Color _defaultColor = Colors.grey;
  final Color _activeColor = primary;
  var _currentIndex = 0;
  bool _hasBuild = false;
  static int _initialPage = 0;
  late List<Widget> _pages;
  final PageController _controller = PageController(initialPage: _initialPage);

  @override
  Widget build(BuildContext context) {
    _pages = [
      HomePage(onJumpTo: (index) => _onJumpTo(index)),
      RankingPage(),
      FavoritePage(),
      MinePage(),
    ];

    if (!_hasBuild) {
      HiNavigator.getInstance()
          .onBottomTabChange(_initialPage, _pages[_initialPage]);
      _hasBuild = true;
    }

    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        type: BottomNavigationBarType.fixed,
        selectedItemColor: _activeColor,
        items: [
          setupItem('首页', Icons.home),
          setupItem('排行', Icons.local_fire_department),
          setupItem('收藏', Icons.favorite),
          setupItem('我的', Icons.live_tv),
        ],
        onTap: (index) => _onJumpTo(index),
      ),
      body: PageView(
        controller: _controller,
        physics: NeverScrollableScrollPhysics(),
        // onPageChanged: (index) => _onJumpTo(index, pageChange: true),
        children: _pages,
      ),
    );
  }

  setupItem(String title, IconData icon) {
    return BottomNavigationBarItem(
      icon: Icon(icon, color: _defaultColor),
      activeIcon: Icon(
        icon,
        color: _activeColor,
      ),
      label: title,
    );
  }

  _onJumpTo(int index, {pageChange = false}) {
    if (!pageChange) {
      //让PageView展示对应tab
      _controller.jumpToPage(index);
    }
    // else {
    HiNavigator.getInstance().onBottomTabChange(index, _pages[index]);
    // }
    setState(() {
      //控制选中第一个tab
      _currentIndex = index;
    });
  }
}
