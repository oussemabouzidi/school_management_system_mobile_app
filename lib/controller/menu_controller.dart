import 'package:get/get.dart';

class MenuController extends GetxController {
  final currentRoute = '/menu/main'.obs;

  bool get shouldShowFAB => currentRoute.value == '/menu/despline';

  void updateRoute(String route) {
    currentRoute.value = route;
  }
}
