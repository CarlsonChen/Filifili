import 'package:bilibili/Util/color.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LoginButton extends StatelessWidget {
  final String title;
  final bool enabled;
  final VoidCallback? onPress;
  const LoginButton(this.title,{Key? key,this.onPress, this.enabled = true}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FractionallySizedBox(
          widthFactor: 1,
      child: MaterialButton(
        onPressed: enabled ? this.onPress : null,
        color: primary,
        disabledColor: primary[50],
        child: Text(title,style: TextStyle(fontSize: 16,color: Colors.white),),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
        height: 45,
      ),
    );
  }
}
