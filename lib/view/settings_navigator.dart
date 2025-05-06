import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_app3/view/change_password.dart';
import 'package:my_app3/view/languages.dart';
import 'package:my_app3/view/polices.dart';
import 'package:my_app3/view/settings.dart';
// Add other subpages you want to navigate to from setting

class SettingsNavigator extends StatelessWidget {
  const SettingsNavigator({super.key});

  @override
  Widget build(BuildContext context) {
    return Navigator(
      key: Get.nestedKey(2), // Nested key for setting tab
      initialRoute: '/setting/main',
      onGenerateRoute: (settings) {
        switch (settings.name) {
          case '/setting/main':
            return MaterialPageRoute(builder: (_) => Settings());
          case '/setting/language':
            return MaterialPageRoute(builder: (_) => Languages());
          case '/setting/change_password':
            return MaterialPageRoute(builder: (_) => ChangePassword());
          case '/setting/police':
            return MaterialPageRoute(builder: (_) => Polices());
          default:
            return MaterialPageRoute(builder: (_) => Settings());
        }
      },
    );
  }
}
