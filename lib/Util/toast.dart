import 'package:bilibili/Util/color.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

void showWarningToast(String text){
  Fluttertoast.showToast(
      msg: text,
      backgroundColor: Colors.red,
    gravity: ToastGravity.CENTER,
  );
}

void showToast(String text) {
  Fluttertoast.showToast(
      msg: text,
    toastLength:  Toast.LENGTH_LONG,
    gravity: ToastGravity.CENTER,
    backgroundColor: primary,
  );
}