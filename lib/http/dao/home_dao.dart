import 'package:bilibili/http/core/hi_net.dart';
import 'package:bilibili/http/dao/login_dao.dart';
import 'package:bilibili/http/request/base_request.dart';
import 'package:bilibili/http/request/home_request.dart';
import 'package:bilibili/model/home_tab_mo.dart';

class HomeDao {
  static getHomeData(String pathStr,
      {int pageIndex = 1, int pageSize = 10}) async {
    HomeRequest request = HomeRequest();
    request.pathParams = pathStr;
    request.add('pageIndex', pageIndex).add('pageSize', pageSize);
    var result = await HiNet.getInstance().fire(request);
    return HomeMo.fromJson(result['data']);
  }
}
