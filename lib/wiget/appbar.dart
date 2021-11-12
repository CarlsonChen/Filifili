import 'package:bilibili/Util/color.dart';
import 'package:bilibili/Util/log_utils.dart';
import 'package:bilibili/Util/view_util.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

appBar(String title, String rightTitle, VoidCallback? rightCallBack) {
  return AppBar(
    title: Text(
      title,
      style: TextStyle(fontSize: 18),
    ),
    centerTitle: false,
    leading: BackButton(),
    actions: [
      InkWell(
        onTap: rightCallBack,
        child: Container(
          padding: EdgeInsets.only(right: 15),
          child: Text(
            rightTitle,
            style: TextStyle(fontSize: 18, color: Colors.grey[500]),
            textAlign: TextAlign.center,
          ),
          alignment: Alignment.center,
        ),
      )
    ],
  );
}

videoAppBar() {
  return Container(
    padding: const EdgeInsets.only(left: 8, right: 8),
    decoration: BoxDecoration(
      gradient: blackLinearGradient(fromTop: true),
    ),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const BackButton(
          color: mainWhite,
        ),
        Row(
          children: [
            InkWell(
              child: const Icon(Icons.live_tv_rounded,
                  color: Colors.white, size: 20),
              onTap: () {
                LogUtils.d('小电视点击');
              },
            ),
            Padding(
              padding: const EdgeInsets.only(left: 12),
              child: InkWell(
                onTap: () {
                  LogUtils.d('更多点击');
                },
                child: const Icon(Icons.more_vert_rounded,
                    color: Colors.white, size: 20),
              ),
            )
          ],
        )
      ],
    ),
  );
}
