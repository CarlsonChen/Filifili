import 'package:bilibili/Util/color.dart';
import 'package:bilibili/navigator/hi_navigator.dart';
import 'package:bilibili/page/home_tab_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:underline_indicator/underline_indicator.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with AutomaticKeepAliveClientMixin, SingleTickerProviderStateMixin {
  var listener;
  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: tabs.length, vsync: this);
    HiNavigator.getInstance().addListener(this.listener = (current, pre) {
      print('几次');
      if (widget == current.page || current.page is HomePage) {
        print('打开了首页:onResume');
      } else if (widget == pre?.page || pre?.page is HomePage) {
        print('首页:onPause');
      }
    });
  }

  void dispose() {
    _tabController.dispose();
    HiNavigator.getInstance().removeListener(this.listener);
    super.dispose();
  }

  late TabController _tabController;
  var tabs = ["推荐", "热门", "追播", "影视", "搞笑", "日常", "综合", "手机游戏", "短片·手书·配音"];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          color: mainWhite,
          child: Column(
            children: [
              Container(
                color: mainWhite,
                child: Padding(
                  padding: const EdgeInsets.only(top: 50),
                  child: _tabbarWidget(),
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              Expanded(
                  child: TabBarView(
                children: _tabPage(tabs),
                controller: _tabController,
              )),
            ],
          )),
    );
  }

  @override
  bool get wantKeepAlive => true;

  _tabs(List<String> tabs) {
    return tabs.map<Tab>((title) {
      return Tab(
        text: title,
        iconMargin: const EdgeInsets.only(left: 5, right: 5),
      );
    }).toList();
  }

  _tabPage(List<String> tabs) {
    return tabs.map((name) {
      return HomeTabPage(name: name);
    }).toList();
  }

  _tabbarWidget() {
    return TabBar(
      tabs: _tabs(tabs),
      controller: _tabController,
      isScrollable: true,
      labelColor: Colors.black,
      labelStyle: const TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
      unselectedLabelStyle: const TextStyle(fontSize: 15),
      indicator: const UnderlineIndicator(
        borderSide: BorderSide(width: 3, color: primary),
        insets: EdgeInsets.only(left: 15, right: 15),
        strokeCap: StrokeCap.round,
      ),
    );
  }
}
