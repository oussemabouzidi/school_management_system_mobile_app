import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_app3/view/activite.dart';
import 'package:my_app3/view/behavior.dart';
import 'package:my_app3/view/cantine.dart';
import 'package:my_app3/view/despline_2.dart';
import 'package:my_app3/view/homework.dart';
import 'package:my_app3/view/homework_menu.dart';
import 'package:my_app3/view/menu_2.dart';
import 'package:my_app3/view/despline.dart';
import 'package:my_app3/view/notes.dart';
import 'package:my_app3/view/payement.dart';
import 'package:my_app3/view/schedule.dart';
// Add other subpages you want to navigate to from Menu

class MenuNavigator extends StatelessWidget {
  const MenuNavigator({super.key});

  @override
  Widget build(BuildContext context) {
    return Navigator(
      key: Get.nestedKey(1), // Nested key for Menu tab
      initialRoute: '/menu/main',
      onGenerateRoute: (settings) {
        switch (settings.name) {
          case '/menu/main':
            return MaterialPageRoute(builder: (_) => Menu2());
          case '/menu/despline':
            return MaterialPageRoute(builder: (_) => Despline());
          case '/menu/despline_mounth':
            return MaterialPageRoute(builder: (_) => Despline2());
          case '/menu/notes':
            return MaterialPageRoute(builder: (_) => Notes());
          case '/menu/homework':
            return MaterialPageRoute(builder: (_) => HomeworkMenu());
          case '/menu/homework/details':
            return MaterialPageRoute(builder: (_) => Homework());
          case '/menu/schedule':
            return MaterialPageRoute(builder: (_) => Schedule());
          case '/menu/paiement':
            return MaterialPageRoute(builder: (_) => Payement());
          case '/menu/cantine':
            return MaterialPageRoute(builder: (_) => Cantine());
          case '/menu/behavior':
            return MaterialPageRoute(builder: (_) => Behavior());
          case '/menu/actualite':
            return MaterialPageRoute(builder: (_) => Activite());
          default:
            return MaterialPageRoute(builder: (_) => Menu2());
        }
      },
    );
  }
}
