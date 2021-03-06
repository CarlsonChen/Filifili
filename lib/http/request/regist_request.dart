import 'package:bilibili/http/request/base_request.dart';

class RegistRequest extends BaseRequest {
  @override
  HttpMethod httpMethod() {
    return HttpMethod.POST;
  }

  @override
  bool needLogin() {
    return false;
  }

  @override
  String path() {
    return "uapi/user/registration";
  }

}