import 'package:bilibili/http/dao/home_dao.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomeTabPage extends StatefulWidget {
  final String name;
  const HomeTabPage({Key? key, required this.name}) : super(key: key);

  @override
  _HomeTabPageState createState() => _HomeTabPageState();
}

class _HomeTabPageState extends State<HomeTabPage> {
  @override
  void initState() {
    super.initState();
    // print
    _loadData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey,
      body: Center(
        child: Text(widget.name),
      ),
    );
  }

  Future _loadData() async {
    var result = await HomeDao.getHomeData('推荐', 1, 10);
  }
}
