import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LoginEffect extends StatefulWidget {
  final bool protected;
  const LoginEffect({Key? key, required this.protected}) : super(key: key);

  @override
  _LoginEffectState createState() => _LoginEffectState();
}

class _LoginEffectState extends State<LoginEffect> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 10),
      decoration: BoxDecoration(
        border: Border(bottom: BorderSide(color: Colors.grey[300]!)),
        color: Colors.grey[100],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _image(true),
          Image(height: 90, width: 90, image: AssetImage('images/logo.png')),
          _image(false),
        ],
      ),
    );
  }

  _image(bool left) {
    var leftImg = widget.protected ? 'images/head_left_protect.png' : 'images/head_left.png';
    var rightImg = widget.protected ? 'images/head_right_protect.png' : 'images/head_right.png';
    return Image(height: 90,image: AssetImage(left ? leftImg : rightImg),);
  }
}


