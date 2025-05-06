import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:my_app3/view/chatbot.dart';
import 'package:my_app3/view/home.dart';
import 'package:my_app3/view/menu_navigator.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';
import 'package:my_app3/view/my_account_navigator.dart';
import 'package:my_app3/view/settings_navigator.dart';

class WrapperController extends GetxController {
  WrapperController({required this.initialIndex});
  var currentIndex = 0.obs;
  var isConnected = true.obs;
  GlobalKey<HomeState> homeKey = GlobalKey<HomeState>();
  var chatbotKey = UniqueKey().obs;
  late List<Widget> pages;
  final int initialIndex;

  void changePage(int index) {
    currentIndex.value = index;
    if (index == 0) {
      homeKey.currentState?.resetTooltip();
    }
    if (index == 1) {
      chatbotKey.value = UniqueKey();
    }
  }

  @override
  void onInit() {
    super.onInit();
    currentIndex.value = initialIndex;
    pages = [
      Home(key: homeKey),
      Chatbot(key: chatbotKey.value),
      MenuNavigator(),
      SettingsNavigator(),
      MyAccountNavigator()
    ];

    // Internet connection check with deferred reactive update
    InternetConnection().onStatusChange.listen((status) {
      Future.microtask(() {
        isConnected.value = status == InternetStatus.connected;
        checkInternetConnection();
      });
    });
  }

  void initWith(int index, bool connected) {
    currentIndex.value = index;
    isConnected.value = connected;
    checkInternetConnection();
  }

  bool shouldShowFAB() {
    return currentIndex.value == 5;
  }

  void checkInternetConnection() {
    if (isConnected.value == false) {
      Future.delayed(Duration.zero, () {
        Get.dialog(
          AlertDialog(
            title: Text("Connexion échouée"),
            content: Text(
              "Aucune connexion Internet détectée.\n"
              "Veuillez vérifier votre connexion Wi-Fi ou données mobiles, puis réessayez.",
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Get.back();
                },
                child: Text("Réessayer"),
              ),
              TextButton(
                onPressed: () {
                  Get.back();
                },
                child: Text("Fermer"),
              ),
            ],
          ),
          barrierDismissible: false,
        );
      });
    }
  }
}
