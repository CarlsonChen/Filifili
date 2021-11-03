import 'package:bilibili/Util/color.dart';
import 'package:bilibili/model/home_tab_mo.dart';
import 'package:bilibili/navigator/hi_navigator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper_null_safety/flutter_swiper_null_safety.dart';

class CsBanner extends StatelessWidget {
  final List<BannerMo> bannerList;
  final double bannerHeight;
  const CsBanner(this.bannerList, {Key? key, this.bannerHeight = 180})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: bannerHeight,
      child: _banner(),
    );
  }

  _banner() {
    return Swiper(
      autoplay: true,
      itemBuilder: (BuildContext context, int index) {
        var bannerMo = bannerList[index];
        return InkWell(
          onTap: () {
            if (bannerMo.type == 'video') {
              HiNavigator.getInstance().onJumpTo(RouteStatus.detail,
                  args: {"VideoMo": VideoMo(vid: bannerMo.url)});
            }
          },
          child: ClipRRect(
            borderRadius: BorderRadius.circular(6),
            child: Image.network(
              bannerMo.cover,
              fit: BoxFit.cover,
            ),
          ),
        );
      },
      itemCount: bannerList.length,
      pagination: const SwiperPagination(
        alignment: Alignment.bottomRight,
        builder: DotSwiperPaginationBuilder(
          activeColor: primary,
          size: 5,
          activeSize: 7,
        ),
      ),
    );
  }
}
