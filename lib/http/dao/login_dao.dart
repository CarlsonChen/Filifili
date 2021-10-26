import 'package:bilibili/db/hi_cache.dart';
import 'package:bilibili/http/core/hi_net.dart';
import 'package:bilibili/http/request/base_request.dart';
import 'package:bilibili/http/request/login_request.dart';
import 'package:bilibili/http/request/regist_request.dart';

class LoginDao {
  static const BOARDING_PASS = "BOARDING_PASS";

  static login(String userName, String password) {
    return _send(userName, password);
  }

  static register(
      String userName, String password, String orderId, String imoocId) {
    return _send(userName, password, orderID: orderId, imoocId: imoocId);
  }

  static _send(String uerName, String password,
      {String? orderID, String? imoocId}) async {
    BaseRequest request;
    if (orderID == null && imoocId == null) {
      request = LoginRequest();
    } else {
      request = RegistRequest();
    }
    request
        .add('userName', uerName)
        .add('password', password)
        .add('orderId', orderID ?? '')
        .add('imoocId', imoocId ?? '');
    var result = await HiNet.getInstance().fire(request);
    if (result['code'] == 0 && result['data'] != null) {
      HiCache.getInstance().setString(BOARDING_PASS, result['data']);
    }
    return result;
  }

  static String getBoardingPass() {
    return HiCache.getInstance().get(BOARDING_PASS);
  }
}
