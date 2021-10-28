import 'package:bilibili/Util/string_util.dart';
import 'package:bilibili/Util/toast.dart';
import 'package:bilibili/http/core/hi_error.dart';
import 'package:bilibili/http/dao/login_dao.dart';
import 'package:bilibili/navigator/cs_navigator.dart';
import 'package:bilibili/wiget/appbar.dart';
import 'package:bilibili/wiget/login_button.dart';
import 'package:bilibili/wiget/login_effect.dart';
import 'package:bilibili/wiget/login_input.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  bool _protected = false;
  String? _userName;
  String? _password;
  bool enabled = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: appBar('登录', '注册', () {
          print('前往登录');
          CsNavigator.getShareInstance().onJumpTo(RouteStatus.login);
        }),
        body: ListView(
          children: [
            LoginEffect(protected: _protected),
            LoginInput(
              '用户名',
              '请输入用户名',
              onChanged: (text) {
                _userName = text;
                inputChanged(text);
              },
            ),
            LoginInput(
              '密码',
              '请输入密码',
              onChanged: (text) {
                _password = text;
                inputChanged(text);
              },
              obscureText: true,
              lineStretch: true,
              focusChanged: (focus) {
                setState(() {
                  _protected = focus;
                });
              },
            ),
            Padding(
              padding: EdgeInsets.only(top: 50, left: 10, right: 10),
              child: LoginButton(
                '登录',
                enabled: enabled,
                onPress: loginBtnClick,
              ),
            ),
          ],
        ));
  }

  loginBtnClick() async {
    try {
      var result = await LoginDao.login(_userName!, _password!);
      showToast(result['msg']);
      CsNavigator.getShareInstance().onJumpTo(RouteStatus.home);
    } on HiNetError catch (e) {
      showWarningToast(e.message);
    }
  }

  inputChanged(String text) {
    bool _enabled = false;
    if (isNotEmpty(_userName) && isNotEmpty(_password)) {
      _enabled = true;
    } else {
      _enabled = false;
    }
    setState(() {
      enabled = _enabled;
    });
  }
}
