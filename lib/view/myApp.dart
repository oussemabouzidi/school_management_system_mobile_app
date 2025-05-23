import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_app3/view/Exames.dart';
import 'package:my_app3/view/MyAccount.dart';
import 'package:my_app3/view/activite.dart';
import 'package:my_app3/view/behavior.dart';
import 'package:my_app3/view/cantine.dart';
import 'package:my_app3/view/change_password.dart';
import 'package:my_app3/view/change_password2.dart';
import 'package:my_app3/view/chatbot.dart';
import 'package:my_app3/view/despline.dart';
import 'package:my_app3/view/despline_2.dart';
import 'package:my_app3/view/download.dart';
import 'package:my_app3/view/forgot_password.dart';
import 'package:my_app3/view/forgot_password_2.dart';
import 'package:my_app3/view/home.dart';
import 'package:my_app3/view/homework.dart';
import 'package:my_app3/view/homework_menu.dart';
import 'package:my_app3/view/languages.dart';
import 'package:my_app3/view/login.dart';
import 'package:my_app3/view/menu.dart';
import 'package:my_app3/view/menu_2.dart';
import 'package:my_app3/view/notes.dart';
import 'package:my_app3/view/payement.dart';
import 'package:my_app3/view/polices.dart';
import 'package:my_app3/view/presence.dart';
import 'package:my_app3/view/schedule.dart';
import 'package:my_app3/view/settings.dart';
import 'package:my_app3/view/notification_screen.dart';
import 'package:my_app3/view/wrapper.dart';

class Myapp extends StatefulWidget {
  const Myapp({super.key});
  @override
  State<Myapp> createState() => _MyappState();
}

class _MyappState extends State<Myapp> {
  bool isConnected = false;
  StreamSubscription? _netConStreamSub;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _netConStreamSub?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      theme: ThemeData.light(),
      initialRoute: "/login",
      getPages: [
        GetPage(name: "/login", page: () => Login()),
        GetPage(name: "/wrapper", page: () => Wrapper()),
        GetPage(name: "/home", page: () => Home()),
        GetPage(name: "/activite", page: () => Activite()),
        GetPage(name: "/change_password", page: () => ChangePassword()),
        GetPage(name: "/change_password_2", page: () => ChangePassword2()),
        GetPage(name: "/chatbot", page: () => Chatbot()),
        GetPage(name: "/despline_2", page: () => Despline2()),
        GetPage(name: "/despline", page: () => Despline()),
        GetPage(name: "/download", page: () => Download()),
        GetPage(name: "/exames", page: () => Exames()),
        GetPage(name: "/forgot_password", page: () => ForgotPassword()),
        GetPage(name: "/forgot_password_2", page: () => ForgotPassword2()),
        GetPage(name: "/languages", page: () => Languages()),
        GetPage(name: "/login", page: () => Login()),
        GetPage(name: "/menu_2", page: () => Menu()),
        GetPage(name: "/myaccount", page: () => Myaccount()),
        GetPage(name: "/notes", page: () => Notes()),
        GetPage(name: "/presence", page: () => Presence()),
        GetPage(name: "/schedule", page: () => Schedule()),
        GetPage(name: "/settings", page: () => Settings()),
        GetPage(name: "/notification", page: () => NotificationScreen()),
        GetPage(name: "/menu", page: () => Menu2()),
        GetPage(name: "/cantine", page: () => Cantine()),
        GetPage(name: "/homework_menu", page: () => HomeworkMenu()),
        GetPage(name: "/homework", page: () => Homework()),
        GetPage(name: "/payment", page: () => Payement()),
        GetPage(name: "/behavior", page: () => Behavior()),
        GetPage(name: "/polices", page: () => Polices()),
      ],
    );
  }
}
