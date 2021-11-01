import 'package:bilibili/Util/color.dart';
import 'package:bilibili/Util/toast.dart';
import 'package:bilibili/http/core/hi_error.dart';
import 'package:bilibili/http/dao/home_dao.dart';
import 'package:bilibili/model/home_tab_mo.dart';
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
    with AutomaticKeepAliveClientMixin, TickerProviderStateMixin {
  var listener;
  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: categoryList.length, vsync: this);
    HiNavigator.getInstance().addListener(this.listener = (current, pre) {
      print('几次');
      if (widget == current.page || current.page is HomePage) {
        print('打开了首页:onResume');
      } else if (widget == pre?.page || pre?.page is HomePage) {
        print('首页:onPause');
      }
    });

    _loadData();
  }

  void dispose() {
    _tabController.dispose();
    HiNavigator.getInstance().removeListener(this.listener);
    super.dispose();
  }

  late TabController _tabController;
  // var tabs = ["推荐", "热门", "追播", "影视", "搞笑", "日常", "综合", "手机游戏", "短片·手书·配音"];
  List<BannerMo> bannerList = [];
  List<CategoryMo> categoryList = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
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
            children: _tabPage(categoryList),
            controller: _tabController,
          )),
        ],
      )),
    );
  }

  @override
  bool get wantKeepAlive => true;

  _tabs(List<CategoryMo> tabs) {
    return tabs.map<Tab>((model) {
      return Tab(
        text: model.name,
        iconMargin: const EdgeInsets.only(left: 5, right: 5),
      );
    }).toList();
  }

  _tabPage(List<CategoryMo> tabs) {
    return tabs.map((model) {
      return HomeTabPage(name: model.name);
    }).toList();
  }

  _tabbarWidget() {
    return TabBar(
      tabs: _tabs(categoryList),
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

  _loadData() async {
    try {
      HomeMo result = await HomeDao.getHomeData('推荐');
      if (result.categoryList != null) {
        _tabController =
            TabController(length: result.categoryList!.length, vsync: this);
      }
      setState(() {
        categoryList = result.categoryList ?? [];
        bannerList = result.bannerList ?? [];
      });
    } on HiNetError catch (e) {
      showWarningToast(e.message);
    }
  }
}
