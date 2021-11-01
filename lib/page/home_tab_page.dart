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
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(widget.name),
      ),
    );
  }
}
