import 'package:bilibili/wiget/login_input.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class TextInput extends StatefulWidget {
  const TextInput({Key? key}) : super(key: key);

  @override
  _TextInputState createState() => _TextInputState();
}

class _TextInputState extends State<TextInput> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LoginInput('用户名', '请输入用户名',
      onChanged: (String text){
        print(text);
      },
        obscureText: true,
        inputType: TextInputType.phone,
      ),
    );
  }
}
