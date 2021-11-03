import 'package:bilibili/model/home_tab_mo.dart';
import 'package:bilibili/navigator/hi_navigator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DetailPage extends StatefulWidget {
  final VideoMo? video;
  const DetailPage({Key? key, this.video}) : super(key: key);

  @override
  _DetailPageState createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        child: Center(
          child: MaterialButton(
            onPressed: () {
              print('返回');
              HiNavigator.getInstance().onJumpTo(RouteStatus.home);
            },
            child: Text('详情:${widget.video?.vid}'),
          ),
        ),
      ),
    );
  }
}
