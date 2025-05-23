import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_app3/view/MyAccount.dart';
import 'package:my_app3/view/change_password.dart';
import 'package:my_app3/view/modifier_profile.dart';
// Add other subpages you want to navigate to from setting

class MyAccountNavigator extends StatelessWidget {
  const MyAccountNavigator({super.key});

  @override
  Widget build(BuildContext context) {
    return Navigator(
      key: Get.nestedKey(3), // Nested key for setting tab
      initialRoute: '/myaccount/main',
      onGenerateRoute: (settings) {
        switch (settings.name) {
          case '/myaccount/main':
            return MaterialPageRoute(builder: (_) => Myaccount());
          case '/myaccount/update_profile':
            final args =
                settings.arguments as int; // 👈 grab arguments manually
            return GetPageRoute(
              page: () => ModifierProfil(
                studentId: args,
              ),
            );
          //return MaterialPageRoute(builder: (_) => ModifierProfil());
          case '/myaccount/change_password':
            return MaterialPageRoute(builder: (_) => ChangePassword());
          default:
            return MaterialPageRoute(builder: (_) => Myaccount());
        }
      },
    );
  }
}
