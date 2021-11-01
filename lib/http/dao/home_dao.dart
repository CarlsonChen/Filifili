import 'package:bilibili/http/core/hi_net.dart';
import 'package:bilibili/http/dao/login_dao.dart';
import 'package:bilibili/http/request/base_request.dart';
import 'package:bilibili/http/request/home_request.dart';

class HomeDao {
  static getHomeData(String pathStr, int pageIndex, int pageSize) async {
    HomeRequest request = HomeRequest();
    request.pathParams = pathStr;
    request.add('pageIndex', pageIndex).add('pageSize', pageSize);
    print('header:${request.header}');
    var result = await HiNet.getInstance().fire(request);
    print(result);
  }
}
