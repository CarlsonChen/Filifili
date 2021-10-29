import 'package:bilibili/Util/color.dart';
import 'package:bilibili/Util/string_util.dart';
import 'package:bilibili/Util/toast.dart';
import 'package:bilibili/http/core/hi_error.dart';
import 'package:bilibili/http/core/hi_net.dart';
import 'package:bilibili/http/dao/login_dao.dart';
import 'package:bilibili/http/request/base_request.dart';
import 'package:bilibili/http/request/regist_request.dart';
import 'package:bilibili/main.dart';
import 'package:bilibili/navigator/hi_navigator.dart';
// import 'package:bilibili/navigator/cs_navigator.dart';
import 'package:bilibili/wiget/appBar.dart';
import 'package:bilibili/wiget/login_button.dart';
import 'package:bilibili/wiget/login_effect.dart';
import 'package:bilibili/wiget/login_input.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool _protected = false;
  String? userName; //用户名
  bool loginEnable = false; //按钮默认无法点击
  String? password; //密码
  String? rePassword; //二次密码
  String? imoocId;
  String? orderId;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: mainWhite,
      appBar: appBar('注册', '登录', () {
        HiNavigator.getInstance().onJumpTo(RouteStatus.registration);
      }),
      body: ListView(
        children: [
          LoginEffect(protected: _protected),
          LoginInput(
            '用户名',
            '请输入用户名',
            onChanged: (text) {
              userName = text;
              _registBtnEnable();
            },
          ),
          LoginInput(
            '密    码',
            '请输入密码',
            onChanged: (text) {
              password = text;
              _registBtnEnable();
            },
            focusChanged: (focus) {
              _protected = focus;
              setState(() {});
            },
            obscureText: true,
          ),
          LoginInput(
            '确认密码',
            '请再次输入密码',
            onChanged: (text) {
              rePassword = text;
              _registBtnEnable();
            },
            focusChanged: (focus) {
              _protected = focus;
              setState(() {});
            },
            obscureText: true,
          ),
          LoginInput(
            '某刻ID',
            '请输入某刻ID',
            onChanged: (text) {
              imoocId = text;
              _registBtnEnable();
            },
          ),
          LoginInput(
            '订单号',
            '请输入订单号后4位',
            onChanged: (text) {
              orderId = text;
              _registBtnEnable();

              print(text);
            },
            inputType: TextInputType.number,
            lineStretch: true,
          ),
          Padding(
            padding: EdgeInsets.only(top: 50, left: 15, right: 15),
            child: LoginButton(
              '注册',
              enabled: loginEnable,
              onPress: _registBtnClick,
            ),
          ),
        ],
      ),
    );
  }

  void _registBtnEnable() {
    bool btnEnable = false;
    if (isNotEmpty(userName) &&
        isNotEmpty(password) &&
        isNotEmpty(rePassword) &&
        isNotEmpty(imoocId) &&
        isNotEmpty(orderId)) {
      btnEnable = true;
    }
    setState(() {
      loginEnable = btnEnable;
    });
  }

  void _registBtnClick() async {
    String? tips;
    if (rePassword != password) {
      tips = '两次密码输入不同';
    } else if (orderId!.length != 4) {
      tips = '订单号长度不符';
    }
    if (tips != null) {
      showWarningToast(tips);
      return;
    }
    try {
      var result =
          await LoginDao.register(userName!, password!, orderId!, imoocId!);
      showToast(result['msg']);
      HiNavigator.getInstance().onJumpTo(RouteStatus.registration);
    } on HiNetError catch (e) {
      showWarningToast(e.toString());
    }
  }
}

class BiliRoutePath {
  final String location;

  BiliRoutePath.home() : location = "/";

  BiliRoutePath.detail() : location = "";
}
