import 'package:flutter/material.dart';
import 'package:my_app3/Exames.dart';
import 'package:my_app3/MyAccount.dart';
import 'package:my_app3/activite.dart';
import 'package:my_app3/behavior.dart';
import 'package:my_app3/cantine.dart';
import 'package:my_app3/change_password.dart';
import 'package:my_app3/change_password2.dart';
import 'package:my_app3/chatbot.dart';
import 'package:my_app3/despline.dart';
import 'package:my_app3/despline_2.dart';
import 'package:my_app3/download.dart';
import 'package:my_app3/forgot_password.dart';
import 'package:my_app3/forgot_password_2.dart';
import 'package:my_app3/home.dart';
import 'package:my_app3/homework.dart';
import 'package:my_app3/homework_menu.dart';
import 'package:my_app3/languages.dart';
import 'package:my_app3/login.dart';
import 'package:my_app3/menu.dart';
import 'package:my_app3/menu_2.dart';
import 'package:my_app3/notes.dart';
import 'package:my_app3/payement.dart';
import 'package:my_app3/presence.dart';
import 'package:my_app3/schedule.dart';
import 'package:my_app3/settings.dart';
import 'package:my_app3/notification_screen.dart';

class Myapp extends StatefulWidget {
  const Myapp({super.key});
  @override
  State<Myapp> createState() => _MyappState();
}

class _MyappState extends State<Myapp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Home(),
      routes: {
        "home": (context) => Home(),
        "activite": (context) => Activite(),
        "change_password": (context) => ChangePassword(),
        "change_password_2": (context) => ChangePassword2(),
        "chatbot": (context) => Chatbot(),
        "despline_2": (context) => Despline2(),
        "despline": (context) => Despline(),
        "download": (context) => Download(),
        "exames": (context) => Exames(),
        "forgot_password": (context) => ForgotPassword(),
        "forgot_password_2": (context) => ForgotPassword2(),
        "languages": (context) => Languages(),
        "login": (context) => Login(),
        "menu_2": (context) => Menu(),
        "myaccount": (context) => Myaccount(),
        "notes": (context) => Notes(),
        "presence": (context) => Presence(),
        "schedule": (context) => Schedule(),
        "settings": (context) => Settings(),
        "notification": (context) => NotificationScreen(),
        "menu": (context) => Menu2(),
        "cantine": (context) => Cantine(),
        "homework_menu": (context) => HomeworkMenu(),
        "homework": (context) => Homework(),
        "payment": (context) => Payement(),
        "behavior": (context) => Behavior(),
      },
    );
  }
}
