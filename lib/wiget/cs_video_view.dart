import 'package:bilibili/Util/color.dart';
import 'package:bilibili/Util/measure.dart';
import 'package:bilibili/Util/view_util.dart';
import 'package:chewie/chewie.dart' hide MaterialControls;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:orientation/orientation.dart';
import 'package:video_player/video_player.dart';

import 'hi_video_controls.dart';

class CsVideoView extends StatefulWidget {
  final String url;
  final String? cover;
  final bool autoPlay;
  final bool looping;
  final double aspectRatio;
  final Widget? overlayUI;

  const CsVideoView(
    this.url, {
    Key? key,
    this.cover,
    this.autoPlay = false,
    this.looping = false,
    this.aspectRatio = 16 / 9,
    this.overlayUI,
  }) : super(key: key);

  @override
  _CsVideoViewState createState() => _CsVideoViewState();
}

class _CsVideoViewState extends State<CsVideoView> {
  late ChewieController _chewieController;
  late VideoPlayerController _videoPlayerController;

  //封面

  get _placeholder => FractionallySizedBox(
        widthFactor: 1,
        child:
            widget.cover == null ? Container() : cachedWebImage(widget.cover!),
      );

  //进度条颜色配置
  get _progressColors => ChewieProgressColors(
        playedColor: primary,
        handleColor: primary,
        backgroundColor: Colors.grey,
        bufferedColor: primary[50]!,
      );
  @override
  void initState() {
    super.initState();

    _videoPlayerController = VideoPlayerController.network(widget.url);
    _chewieController = ChewieController(
        videoPlayerController: _videoPlayerController,
        aspectRatio: widget.aspectRatio,
        autoPlay: widget.autoPlay,
        looping: widget.looping,
        placeholder: _placeholder,
        allowMuting: false,
        allowPlaybackSpeedChanging: false,
        customControls: MaterialControls(
          showLoadingOnInitialize: false,
          showBigPlayIcon: false,
          bottomGradient: blackLinearGradient(),
          overlayUI: widget.overlayUI,
        ),
        materialProgressColors: _progressColors);
    //fix iOS无法正常退出全屏播放问题
    _chewieController.addListener(_fullScreenListener);
  }

  @override
  void dispose() {
    _videoPlayerController.dispose();
    _chewieController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var height = screenWidth / widget.aspectRatio;

    var width = screenWidth;

    return Container(
      width: width,
      height: height,
      child: Chewie(
        controller: _chewieController,
      ),
      color: Colors.grey,
    );
  }

  void _fullScreenListener() {
    Size size = MediaQuery.of(context).size;
    if (size.width > size.height) {
      OrientationPlugin.forceOrientation(DeviceOrientation.portraitUp);
    }
  }
}
