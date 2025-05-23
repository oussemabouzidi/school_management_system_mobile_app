import 'package:flutter/src/widgets/navigator.dart';
import 'package:get/get.dart';
import 'package:my_app3/shared/SharedPrefsService.dart';

class LoginMiddleware extends GetMiddleware {
  Future<RouteSettings?> redirectFuture(String? route) async {
    final userId = await SharedPrefsService.getUserId();
    final userRole = await SharedPrefsService.getUserRole();

    if (userId != null && userRole != null) {
      return RouteSettings(name: '/wrapper');
    }
    return null;
  }
}
