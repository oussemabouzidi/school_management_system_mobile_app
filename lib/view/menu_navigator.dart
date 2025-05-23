import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_app3/view/activite.dart';
import 'package:my_app3/view/behavior.dart';
import 'package:my_app3/view/cantine.dart';
import 'package:my_app3/view/course.dart';
import 'package:my_app3/view/despline_2.dart';
import 'package:my_app3/view/homework.dart';
import 'package:my_app3/view/homework_menu.dart';
import 'package:my_app3/view/livres.dart';
import 'package:my_app3/view/matiere_course.dart';
import 'package:my_app3/view/menu_2.dart';
import 'package:my_app3/view/despline.dart';
import 'package:my_app3/view/notes.dart';
import 'package:my_app3/view/payement.dart';
import 'package:my_app3/view/reunion.dart';
import 'package:my_app3/view/savoir_plus.dart';
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
            return GetPageRoute(page: () => Menu2());
          case '/menu/despline':
            return GetPageRoute(page: () => Despline());
          case '/menu/despline_mounth':
            return GetPageRoute(page: () => Despline2());
          case '/menu/notes':
            return GetPageRoute(page: () => Notes());
          case '/menu/homework':
            return GetPageRoute(page: () => HomeworkMenu());
          case '/menu/homework_details':
            final args = settings.arguments
                as Map<String, dynamic>?; // 👈 grab arguments manually
            return GetPageRoute(
              page: () => Homework(arguments: args),
            );
          case '/menu/schedule':
            return GetPageRoute(page: () => Schedule());
          case '/menu/paiement':
            return GetPageRoute(page: () => Payement());
          case '/menu/cantine':
            return GetPageRoute(page: () => Cantine());
          case '/menu/behavior':
            return GetPageRoute(page: () => Behavior());
          case '/menu/actualite':
            return GetPageRoute(page: () => Activite());
          case '/menu/savoir_plus':
            return GetPageRoute(page: () => SavoirPlus());
          case '/menu/livres':
            return GetPageRoute(page: () => Livres());
          case '/menu/reunion':
            return GetPageRoute(page: () => ReunionScreen());
          case '/menu/course_matieres':
            return GetPageRoute(page: () => MatiereCourse());
          case '/menu/course_details':
            final args = settings.arguments as Map<String, dynamic>?;
            return GetPageRoute(page: () => CourseScreen(arguments: args));
          default:
            return GetPageRoute(page: () => Menu2());
        }
      },
    );
  }
}
