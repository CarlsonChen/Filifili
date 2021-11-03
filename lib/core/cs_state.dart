import 'package:flutter/cupertino.dart';

abstract class CsState<T extends StatefulWidget> extends State<T> {
  @override
  void setState(VoidCallback fn) {
    if (mounted) {
      //页面存在
      super.setState(fn);
    } else {
      print('${toString()} 页面已销毁');
    }
  }
}
