import 'package:bilibili/Util/format_util.dart';
import 'package:bilibili/Util/measure.dart';
import 'package:bilibili/Util/view_util.dart';
import 'package:bilibili/model/home_tab_mo.dart';
import 'package:bilibili/navigator/hi_navigator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';

class VideoCard extends StatelessWidget {
  final VideoMo model;

  const VideoCard(this.model, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        HiNavigator.getInstance()
            .onJumpTo(RouteStatus.detail, args: {"VideoMo": model});
      },
      child: Card(
        margin: EdgeInsets.zero,
        child: SizedBox(
          height: 200,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(6),
            child: Column(
              children: [
                _topImage(),
                _bottomText(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  ///封面信息
  _topImage() {
    return Stack(
      children: [
        cachedWebImage(
          model.cover,
          width: (screenWidth - 16 - 8) * 0.5,
          height: 120,
        ),
        Positioned(
          left: 0,
          bottom: 0,
          right: 0,
          child: Container(
              padding: const EdgeInsets.only(left: 8, right: 8),
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.black54, Colors.transparent],
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                ),
              ),
              child: Padding(
                padding: EdgeInsets.only(bottom: 5),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _iconText(Icons.ondemand_video, countFormat(model.view)),
                    _iconText(Icons.favorite_border, countFormat(model.like)),
                    _iconText(null, durationTransform(model.duration)),
                  ],
                ),
              )),
        )
      ],
    );
  }

  ///视频信息
  _bottomText() {
    return Container(
      padding: EdgeInsets.only(top: 8, left: 5, right: 5, bottom: 5),
      alignment: Alignment.topLeft,
      height: 80,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            model.title,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          _ownerInfo(),
        ],
      ),
    );
  }

  ///作者信息
  _ownerInfo() {
    return Row(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: cachedWebImage(model.owner!.face, width: 24, height: 24),
        ),
        const SizedBox(
          width: 8,
        ),
        Expanded(child: Text(model.owner!.name)),
        const Icon(
          Icons.more_vert_sharp,
          size: 15,
          color: Colors.grey,
        )
      ],
    );
  }

  _iconText(IconData? iconData, String count) {
    return Row(
      children: [
        if (iconData != null) Icon(iconData, color: Colors.white, size: 12),
        Padding(
            padding: const EdgeInsets.only(left: 3),
            child: Text(count,
                style: const TextStyle(color: Colors.white, fontSize: 10)))
      ],
    );
  }
}
