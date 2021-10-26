import 'dart:ui';

import 'package:bilibili/Util/color.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LoginInput extends StatefulWidget {
  final String title;
  final String hint;
  final ValueChanged<String>? onChanged;
  final ValueChanged<bool>? focusChanged;
  final bool lineStretch;
  final bool obscureText;
  final TextInputType? inputType;

  const LoginInput(this.title,this.hint,{Key? key, this.onChanged, this.focusChanged, this.lineStretch = false, this.obscureText = false, this.inputType}) : super(key: key);

  @override
  _LoginInputState createState() => _LoginInputState();
}

class _LoginInputState extends State<LoginInput> {
  final _focusNode = FocusNode();
  @override
  void initState() {

    super.initState();
    _focusNode.addListener(() {
      if(widget.focusChanged != null) {
        widget.focusChanged!(_focusNode.hasFocus);
      }
    });
  }
  @override
  void dispose() {
    // TODO: implement dispose
    _focusNode.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.only(left: 10),
                width: 100,
                child: Text(widget.title,style: const TextStyle(fontSize: 16)),
              ),
              _input(),
            ],
          ),
        Container(
          padding: EdgeInsets.only(left: widget.lineStretch ? 0 : 15),
          child: const Divider(
            height: 1,
            thickness: 0.5,
          ),
        )
      ],
    );
  }

  _input() {
    return Expanded(
      child: TextField(
        onChanged: widget.onChanged,
        obscureText: widget.obscureText,
        keyboardType: widget.inputType,
        // autofocus: widget.obscureText,
        style: TextStyle(fontSize: 16,fontWeight: FontWeight.w300),
        cursorColor: primary,
        focusNode: _focusNode,
        decoration: InputDecoration(
          border: InputBorder.none,
          contentPadding: EdgeInsets.only(left: 20,right: 20),
            hintText: widget.hint,
          hintStyle: TextStyle(color:Colors.grey,fontSize: 15),
        ),
      ),
    );
  }
}

