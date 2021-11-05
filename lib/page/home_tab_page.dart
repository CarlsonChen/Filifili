import 'package:bilibili/Util/color.dart';
import 'package:bilibili/http/core/hi_error.dart';
import 'package:bilibili/http/dao/home_dao.dart';
import 'package:bilibili/http/request/home_request.dart';
import 'package:bilibili/model/home_tab_mo.dart';
import 'package:bilibili/wiget/cs_banner.dart';
import 'package:bilibili/wiget/video_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class HomeTabPage extends StatefulWidget {
  final String catagoryName;
  final List<BannerMo>? bannerList;

  const HomeTabPage({Key? key, required this.catagoryName, this.bannerList})
      : super(key: key);

  @override
  _HomeTabPageState createState() => _HomeTabPageState();
}

class _HomeTabPageState extends State<HomeTabPage>
    with AutomaticKeepAliveClientMixin {
  List<VideoMo> videoList = [];
  int pageIndex = 1;
  int pageSize = 10;
  bool loading = false;
  bool hasMore = true;
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _loadData();
    _scrollController.addListener(() {
      var dis = _scrollController.position.maxScrollExtent -
          _scrollController.position.pixels;
      if (dis < 300 && !loading && hasMore) {
        pageIndex++;
        _loadData(loadMore: true);
      }
    });
    // print
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: RefreshIndicator(
        color: primary,
        child: MediaQuery.removePadding(
          context: context,
          removeTop: true,
          child: _cardList(),
        ),
        onRefresh: _loadData,
      ),
    );
  }

  _banner() {
    return CsBanner(widget.bannerList!);
  }

  Future _loadData({loadMore = false}) async {
    loading = true;
    print('loadingMore = ${loadMore}');
    if (!loadMore) {
      pageIndex = 1;
    }
    try {
      HomeMo result = await HomeDao.getHomeData(widget.catagoryName,
          pageIndex: pageIndex, pageSize: pageSize);
      setState(() {
        if (pageIndex == 1) {
          videoList.clear();
          hasMore = true;
          videoList = result.videoList;
        } else {
          hasMore = result.videoList.length >= pageSize;
          videoList = [...videoList, ...result.videoList];
        }
        print('result---${videoList.length}');
      });

      Future.delayed(const Duration(seconds: 1), () {
        loading = false;
      });
    } on HiNetError catch (e) {
      print(e);
      loading = false;
    } catch (e) {
      loading = false;
      print(e);
    }
  }

  @override
  bool get wantKeepAlive => true;

  _cardList() {
    const int crossCount = 2;

    return StaggeredGridView.countBuilder(
        controller: _scrollController,
        itemCount:
            widget.bannerList == null ? videoList.length : videoList.length + 1,
        crossAxisCount: crossCount,
        padding: const EdgeInsets.only(left: 8, right: 8, top: 8),
        mainAxisSpacing: 8,
        crossAxisSpacing: 8,
        itemBuilder: (BuildContext context, int index) {
          if (widget.bannerList != null && index == 0) {
            return _banner();
          }
          if (widget.bannerList != null) {
            index = index - 1;
          }
          return VideoCard(videoList[index]);
        },
        staggeredTileBuilder: (int index) {
          if (widget.bannerList != null && index == 0) {
            return const StaggeredTile.fit(crossCount);
          } else {
            return const StaggeredTile.fit(1);
          }
        });
  }
}
