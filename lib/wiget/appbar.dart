
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

appBar(String title,String rightTitle,VoidCallback? rightCallBack){
  return AppBar(
    title: Text(title,style: TextStyle(fontSize: 18),),
    centerTitle: false,
    leading: BackButton(),
    actions: [
      InkWell(
        onTap: rightCallBack,
        child: Container(
          padding: EdgeInsets.only(right: 15),

          child: Text(rightTitle,style: TextStyle(fontSize: 18, color: Colors.grey[500]),textAlign: TextAlign.center,),
          alignment: Alignment.center,
        ),
      )
    ],
  );
}