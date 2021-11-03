import 'package:bilibili/http/core/hi_error.dart';
import 'package:bilibili/http/dao/home_dao.dart';
import 'package:bilibili/http/request/home_request.dart';
import 'package:bilibili/model/home_tab_mo.dart';
import 'package:bilibili/wiget/cs_banner.dart';
import 'package:bilibili/wiget/video_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class HomeTabPage extends StatefulWidget {
  final String catagoryName;
  final List<BannerMo>? bannerList;

  const HomeTabPage({Key? key, required this.catagoryName, this.bannerList})
      : super(key: key);

  @override
  _HomeTabPageState createState() => _HomeTabPageState();
}

class _HomeTabPageState extends State<HomeTabPage> {
  List<VideoMo> videoList = [];
  int pageIndex = 1;

  @override
  void initState() {
    super.initState();
    _loadData();
    // print
  }

  @override
  Widget build(BuildContext context) {
    const int crossCount = 2;
    return Scaffold(
        body: MediaQuery.removePadding(
            context: context,
            removeTop: true,
            child: StaggeredGridView.countBuilder(
                itemCount: videoList.length,
                crossAxisCount: crossCount,
                itemBuilder: (BuildContext context, int index) {
                  if (widget.bannerList != null && index == 0) {
                    return _banner();
                  }
                  return VideoCard(videoList[index]);
                },
                staggeredTileBuilder: (int index) {
                  if (widget.bannerList != null && index == 0) {
                    return const StaggeredTile.fit(crossCount);
                  } else {
                    return const StaggeredTile.fit(1);
                  }
                })));
  }

  _banner() {
    return Padding(
      padding: const EdgeInsets.only(left: 8, right: 8),
      child: CsBanner(widget.bannerList!),
    );
  }

  void _loadData() async {
    try {
      HomeMo result =
          await HomeDao.getHomeData('动物圈', pageIndex: pageIndex, pageSize: 30);
      if (result.videoList.isNotEmpty) {
        setState(() {
          videoList = result.videoList;
        });
      }
    } on HiNetError catch (e) {
    } catch (e) {}
  }
}
