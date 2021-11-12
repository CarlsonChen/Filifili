import 'package:bilibili/Util/color.dart';
import 'package:bilibili/Util/measure.dart';
import 'package:bilibili/Util/toast.dart';
import 'package:bilibili/Util/view_util.dart';
import 'package:bilibili/core/cs_state.dart';
import 'package:bilibili/http/core/hi_error.dart';
import 'package:bilibili/http/dao/home_dao.dart';
import 'package:bilibili/model/home_tab_mo.dart';
import 'package:bilibili/navigator/hi_navigator.dart';
import 'package:bilibili/page/detail_page.dart';
import 'package:bilibili/page/home_tab_page.dart';
import 'package:bilibili/page/mine_page.dart';
import 'package:bilibili/wiget/navigation_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:underline_indicator/underline_indicator.dart';
import 'package:url_launcher/url_launcher.dart';

class HomePage extends StatefulWidget {
  final ValueChanged<int>? onJumpTo;

  const HomePage({Key? key, this.onJumpTo}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends CsState<HomePage>
    with AutomaticKeepAliveClientMixin, TickerProviderStateMixin {
  var listener;

  @override
  void initState() {
    super.initState();
    statusStyle = StatusStyle.DARK_CONTENT;

    _tabController = TabController(length: categoryList.length, vsync: this);
    HiNavigator.getInstance().addListener(this.listener = (current, pre) {
      if (widget == current.page || current.page is HomePage) {
        print('打开了首页:onResume');
      } else if (widget == pre?.page || pre?.page is HomePage) {
        print('首页:onPause');
      }
      //当页面返回到首页恢复首页的状态栏样式
      if (pre?.page is DetailPage && current.page is! MinePage) {
        statusStyle = StatusStyle.DARK_CONTENT;
        changeStatusBar(color: Colors.white, statusStyle: statusStyle);
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
    ScreenUtil.init(
        BoxConstraints(
            maxWidth: MediaQuery.of(context).size.width,
            maxHeight: MediaQuery.of(context).size.height),
        designSize: disignSize,
        orientation: Orientation.portrait);
    super.build(context);
    return Scaffold(
      body: Container(
          child: Column(
        children: [
          NavigationBar(
            color: mainWhite,
            statusStyle: statusStyle,
            child: _navigatorContainer(),
          ),
          _tabbarWidget(),
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
      return HomeTabPage(
        catagoryName: model.name,
        bannerList: model.name == '推荐' ? bannerList : null,
      );
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

  _navigatorContainer() {
    double margin = 15.w;
    return Padding(
      padding: EdgeInsets.only(left: 15.w, right: margin),
      child: Row(
        children: [
          InkWell(
            onTap: () {
              if (widget.onJumpTo != null) {
                widget.onJumpTo!(3);
              }
            },
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: const Image(
                image: AssetImage('images/avatar.png'),
                width: 40,
                height: 40,
              ),
            ),
          ),
          Expanded(
            child: _searchBar(),
          ),
          InkWell(
            onTap: () async {
              const url = 'http://flutter.cn';
              if (await canLaunch(url)) {
                await launch(url);
              } else {
                throw 'Could not launch $url';
              }
            },
            child: const Icon(
              Icons.explore_outlined,
              color: Colors.grey,
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: margin),
            child: const Icon(
              Icons.mail_outline,
              color: Colors.grey,
            ),
          ),
        ],
      ),
    );
  }

  _searchBar() {
    double margin = 15.w;

    return InkWell(
      onTap: () {
        print('搜索点击');
      },
      child: Padding(
        padding: EdgeInsets.only(left: margin, right: margin),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(16),
          child: Container(
            height: 32,
            color: Colors.grey[100],
            padding: EdgeInsets.only(left: margin),
            alignment: Alignment.centerLeft,
            child: const Icon(
              Icons.search,
              color: Colors.grey,
            ),
          ),
        ),
      ),
    );
  }
}
