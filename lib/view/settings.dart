import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:my_app3/controller/wrappercontroller.dart';
import 'package:my_app3/widgets/notification_button.dart';
import 'package:my_app3/widgets/student_card.dart';

class Settings extends StatefulWidget {
  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  bool _isDarkMode = false;
  String _selectedLanguage = 'Français';
  final WrapperController wrapperController = Get.find();

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        // Top navigation bar
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 16.0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16.0),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Back button
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12.0),
                ),
                child: IconButton(
                  onPressed: () {
                    wrapperController.changePage(0);
                  },
                  icon: Icon(
                    Icons.arrow_back,
                    color: Colors.grey[700],
                  ),
                  padding: EdgeInsets.zero,
                ),
              ),

              // Settings title
              Text(
                "Paramètres",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF2D3142),
                ),
              ),

              // Notification button with badge
              NotificationButton()
            ],
          ),
        ),

        // User profile card
        // User profile card (similar to the dashboard user card)
        StudentCard(),
        // App Settings section
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(24),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 10,
                  spreadRadius: 0,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Column(
              children: [
                // Header
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Color(0xFFF6F6F6),
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(24),
                      topRight: Radius.circular(24),
                    ),
                  ),
                  child: Row(
                    children: [
                      Icon(
                        Icons.settings,
                        color: Color(0xFF2D3142),
                        size: 20,
                      ),
                      SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          'Paramètres de l\'application',
                          style: TextStyle(
                            color: Color(0xFF2D3142),
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                // Language setting
                ListTile(
                  leading: Container(
                    padding: EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Colors.blue.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Icon(Icons.language, color: Colors.blue),
                  ),
                  title: Text(
                    'Langue',
                    style: TextStyle(
                      color: Color(0xFF2D3142),
                      fontSize: 16,
                    ),
                  ),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        _selectedLanguage,
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: 14,
                        ),
                      ),
                      SizedBox(width: 8),
                      Icon(
                        Icons.arrow_forward_ios,
                        size: 16,
                        color: Colors.grey,
                      ),
                    ],
                  ),
                  onTap: () {
                    Get.toNamed("/setting/language", id: 2);
                  },
                ),
                Divider(height: 1),

                // Dark mode setting
                SwitchListTile(
                  secondary: Container(
                    padding: EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Colors.purple.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Icon(Icons.dark_mode, color: Colors.purple),
                  ),
                  title: Text(
                    'Mode sombre',
                    style: TextStyle(
                      color: Color(0xFF2D3142),
                      fontSize: 16,
                    ),
                  ),
                  value: _isDarkMode,
                  onChanged: (value) {
                    setState(() {
                      _isDarkMode = value;
                    });
                  },
                ),
                Divider(height: 1),

                // Notifications settings
                ListTile(
                  leading: Container(
                      padding: EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Colors.red.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: HugeIcon(
                          icon: HugeIcons.strokeRoundedNotification01,
                          color: Colors.redAccent)),
                  title: Text(
                    'Notifications',
                    style: TextStyle(
                      color: Color(0xFF2D3142),
                      fontSize: 16,
                    ),
                  ),
                  trailing: Icon(
                    Icons.arrow_forward_ios,
                    size: 16,
                    color: Colors.grey,
                  ),
                  onTap: () {
                    showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
                            title: Text(
                              "Notifications",
                              style: TextStyle(color: Colors.red[400]),
                            ),
                            content: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                _buildNotificationItem(
                                  title: 'Club Théâtre',
                                  description:
                                      'Le Club-Théâtre est un lieu dynamique où l\'art du théâtre prend vie',
                                  imageAsset: 'images/theatre.png',
                                  logoColor: Colors.red,
                                ),
                                SizedBox(height: 16),
                                _buildNotificationItem(
                                  title: 'Club de Foot',
                                  description:
                                      'Le Club foot est un lieu sportive',
                                  imageAsset: 'images/football.png',
                                  logoColor: Colors.black,
                                ),
                              ],
                            ),
                          );
                        });
                  },
                ),
                Divider(height: 1),

                // Font size
                ListTile(
                  leading: Container(
                    padding: EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Colors.amber.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Icon(Icons.format_size, color: Colors.amber),
                  ),
                  title: Text(
                    'Taille de police',
                    style: TextStyle(
                      color: Color(0xFF2D3142),
                      fontSize: 16,
                    ),
                  ),
                  trailing: Icon(
                    Icons.arrow_forward_ios,
                    size: 16,
                    color: Colors.grey,
                  ),
                  onTap: () {
                    Get.toNamed('/setting/police', id: 2);
                  },
                ),
              ],
            ),
          ),
        ),

        // Security section
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(24),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 10,
                  spreadRadius: 0,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Column(
              children: [
                // Header
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Color(0xFFF6F6F6),
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(24),
                      topRight: Radius.circular(24),
                    ),
                  ),
                  child: Row(
                    children: [
                      Icon(
                        Icons.security,
                        color: Color(0xFF2D3142),
                        size: 20,
                      ),
                      SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          'Sécurité',
                          style: TextStyle(
                            color: Color(0xFF2D3142),
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                // Change password
                ListTile(
                  leading: Container(
                    padding: EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Colors.green.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Icon(Icons.password, color: Colors.green),
                  ),
                  title: Text(
                    'Changer le mot de passe',
                    style: TextStyle(
                      color: Color(0xFF2D3142),
                      fontSize: 16,
                    ),
                  ),
                  trailing: Icon(
                    Icons.arrow_forward_ios,
                    size: 16,
                    color: Colors.grey,
                  ),
                  onTap: () {
                    Get.toNamed("/setting/change_password", id: 2);
                  },
                ),
                Divider(height: 1),

                // Parental controls
                ListTile(
                  leading: Container(
                    padding: EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Colors.orange.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Icon(Icons.family_restroom, color: Colors.orange),
                  ),
                  title: Text(
                    'Contrôle parental',
                    style: TextStyle(
                      color: Color(0xFF2D3142),
                      fontSize: 16,
                    ),
                  ),
                  trailing: Icon(
                    Icons.arrow_forward_ios,
                    size: 16,
                    color: Colors.grey,
                  ),
                  onTap: () {},
                ),
                Divider(height: 1),

                // Privacy settings
                ListTile(
                  leading: Container(
                    padding: EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Colors.indigo.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Icon(Icons.privacy_tip, color: Colors.indigo),
                  ),
                  title: Text(
                    'Confidentialité',
                    style: TextStyle(
                      color: Color(0xFF2D3142),
                      fontSize: 16,
                    ),
                  ),
                  trailing: Icon(
                    Icons.arrow_forward_ios,
                    size: 16,
                    color: Colors.grey,
                  ),
                  onTap: () {},
                ),
              ],
            ),
          ),
        ),

        // About & Support section
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(24),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 10,
                  spreadRadius: 0,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Column(
              children: [
                // Header
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Color(0xFFF6F6F6),
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(24),
                      topRight: Radius.circular(24),
                    ),
                  ),
                  child: Row(
                    children: [
                      Icon(
                        Icons.info,
                        color: Color(0xFF2D3142),
                        size: 20,
                      ),
                      SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          'À propos et support',
                          style: TextStyle(
                            color: Color(0xFF2D3142),
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                // Help & Support
                ListTile(
                  leading: Container(
                    padding: EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Colors.teal.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Icon(Icons.help, color: Colors.teal),
                  ),
                  title: Text(
                    'Aide et support',
                    style: TextStyle(
                      color: Color(0xFF2D3142),
                      fontSize: 16,
                    ),
                  ),
                  trailing: Icon(
                    Icons.arrow_forward_ios,
                    size: 16,
                    color: Colors.grey,
                  ),
                  onTap: () {},
                ),
                Divider(height: 1),

                // Terms & Conditions
                ListTile(
                  leading: Container(
                    padding: EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Colors.blueGrey.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Icon(Icons.description, color: Colors.blueGrey),
                  ),
                  title: Text(
                    'Conditions générales',
                    style: TextStyle(
                      color: Color(0xFF2D3142),
                      fontSize: 16,
                    ),
                  ),
                  trailing: Icon(
                    Icons.arrow_forward_ios,
                    size: 16,
                    color: Colors.grey,
                  ),
                  onTap: () {},
                ),
                Divider(height: 1),

                // Logout button
                ListTile(
                  leading: Container(
                    padding: EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Colors.red.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Icon(Icons.logout, color: Colors.red),
                  ),
                  title: Text(
                    'Déconnexion',
                    style: TextStyle(
                      color: Color(0xFF2D3142),
                      fontSize: 16,
                    ),
                  ),
                  trailing: Icon(
                    Icons.arrow_forward_ios,
                    size: 16,
                    color: Colors.grey,
                  ),
                  onTap: () {
                    showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            title: Text("Logout"),
                            content: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                    "Souhaitez-vous vraiment vous déconnecter ?"),
                                SizedBox(
                                  height: 30,
                                ),
                                Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                        elevation: 0,
                                        padding:
                                            EdgeInsets.symmetric(vertical: 16),
                                        backgroundColor: Colors.transparent,
                                        shadowColor: Colors.transparent,
                                        surfaceTintColor: Colors.transparent,
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(20)),
                                      ),
                                      onPressed: () {
                                        Get.back();
                                      },
                                      child: Container(
                                        decoration: BoxDecoration(
                                            color: Color(0xFF9ECAFF),
                                            borderRadius:
                                                BorderRadius.circular(15)),
                                        height: 30,
                                        width: 50,
                                        child: Center(child: Text("Non")),
                                      ),
                                    ),
                                    SizedBox(
                                      width: 20,
                                    ),
                                    ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                          elevation: 0,
                                          padding: EdgeInsets.symmetric(
                                              vertical: 16),
                                          backgroundColor: Colors.transparent,
                                          shadowColor: Colors.transparent,
                                          surfaceTintColor: Colors.transparent,
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(20)),
                                        ),
                                        onPressed: () {},
                                        child: Container(
                                          decoration: BoxDecoration(
                                              color: Color(0xFFFF8CA1),
                                              borderRadius:
                                                  BorderRadius.circular(15)),
                                          width: 50,
                                          height: 30,
                                          child: Center(
                                            child: Text("Oui"),
                                          ),
                                        )),
                                  ],
                                )
                              ],
                            ),
                          );
                        });
                  },
                ),
              ],
            ),
          ),
        ),

        // App version info
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Center(
            child: Text(
              'Version 1.0.0',
              style: TextStyle(
                color: Colors.grey,
                fontSize: 14,
              ),
            ),
          ),
        ),

        // Bottom space for navigation bar
        SizedBox(height: 80),
      ],
    );
  }
}

Widget _buildNotificationItem({
  required String title,
  required String description,
  required String imageAsset,
  required Color logoColor,
}) {
  return Container(
    padding: EdgeInsets.all(12),
    decoration: BoxDecoration(
      color: logoColor.withOpacity(0.1),
      borderRadius: BorderRadius.circular(15),
    ),
    width: 280,
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CircleAvatar(
          backgroundColor: logoColor,
          radius: 24,
          child: Padding(
            padding: const EdgeInsets.all(4.0),
            child: Image.asset(
              imageAsset,
              fit: BoxFit.contain,
            ),
          ),
        ),
        SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  )),
              SizedBox(height: 4),
              Text(
                description,
                style: TextStyle(fontSize: 13, color: Colors.black87),
              ),
            ],
          ),
        )
      ],
    ),
  );
}
