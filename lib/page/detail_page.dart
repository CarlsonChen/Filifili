import 'dart:io';

import 'package:bilibili/Util/color.dart';
import 'package:bilibili/Util/measure.dart';
import 'package:bilibili/Util/view_util.dart';
import 'package:bilibili/model/home_tab_mo.dart';
import 'package:bilibili/navigator/hi_navigator.dart';
import 'package:bilibili/wiget/appbar.dart';
import 'package:bilibili/wiget/cs_video_view.dart';
import 'package:bilibili/wiget/hi_tab.dart';
import 'package:bilibili/wiget/navigation_bar.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:underline_indicator/underline_indicator.dart';

class DetailPage extends StatefulWidget {
  final VideoMo? video;
  const DetailPage({Key? key, this.video}) : super(key: key);

  @override
  _DetailPageState createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> with TickerProviderStateMixin {
  List<String> tabs = ['简介', '评论128'];
  TabController? _controller;
  @override
  void initState() {
    super.initState();
    statusStyle = StatusStyle.LIGHT_CONTENT;
    //黑色状态栏，仅Android
    changeStatusBar(color: Colors.black, statusStyle: statusStyle);
    _controller = TabController(length: tabs.length, vsync: this);
  }

  @override
  void dispose() {
    _controller!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: MediaQuery.removePadding(
        context: context,
        removeTop: Platform.isIOS,
        child: Container(
          child: Column(
            children: [
              NavigationBar(
                color: Colors.black,
                statusStyle: statusStyle,
                height: statusBarHeight,
              ),
              _chwiew(),
              _setupTabbar(),
            ],
          ),
        ),
      ),
    );
  }

  _chwiew() {
    return CsVideoView(
      widget.video!.url!,
      cover: widget.video?.cover,
      overlayUI: videoAppBar(),
    );
  }

  _tabbar() {
    return HiTab(
      tabs.map<Tab>((name) {
        return Tab(
          text: name,
        );
      }).toList(),
      controller: _controller,
    );
  }

  _setupTabbar() {
    return Material(
      elevation: 3,
      shadowColor: Colors.grey,
      child: Container(
        height: 39,
        padding: const EdgeInsets.only(left: 20, right: 20),
        color: mainWhite,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _tabbar(),
            const Icon(Icons.live_tv_rounded, color: Colors.grey, size: 20),
          ],
        ),
      ),
    );
  }
}
