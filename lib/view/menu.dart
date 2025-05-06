import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:crystal_navigation_bar/crystal_navigation_bar.dart';
import 'package:iconly/iconly.dart';
import 'package:badges/badges.dart' as badges;

class Menu extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
      backgroundColor: Color(0xFFF5F5F5),
      extendBody: true,
      appBar: PreferredSize(
          preferredSize:
              Size.fromHeight(70.0), // You can set the height of the AppBar
          child: ClipRRect(
            borderRadius: BorderRadius.only(
                bottomLeft:
                    Radius.circular(15), // Adjust the left bottom corner
                bottomRight:
                    Radius.circular(15), // Adjust the right bottom corner
                topLeft: Radius.circular(15),
                topRight: Radius.circular(15)),
            child: AppBar(
              title: Row(
                children: [
                  Expanded(
                    flex: 2,
                    child: Container(
                        padding: EdgeInsets.only(left: 40.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Adem ben Ammar',
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.bold),
                            ),
                            SizedBox(height: 8),
                            Text(
                              '7eme b 7',
                              style: TextStyle(fontSize: 14),
                            )
                          ],
                        )),
                  ),
                  badges.Badge(
                      badgeContent: Text(
                        '3',
                        style: TextStyle(color: Colors.white, fontSize: 10),
                      ),
                      badgeStyle: badges.BadgeStyle(
                        badgeColor: Colors.red,
                        padding: EdgeInsets.all(6),
                      ),
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.of(context).pushNamed("notification");
                        },
                        style: ElevatedButton.styleFrom(
                          elevation: 0,
                          padding: EdgeInsets.zero,
                          backgroundColor: Colors.transparent,
                          shadowColor: Colors.transparent,
                          surfaceTintColor: Colors.transparent,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.zero),
                        ),
                        child: HugeIcon(
                          icon: HugeIcons.strokeRoundedNotification03,
                          color: Colors.white,
                          size: 40.0,
                        ),
                      )),
                  ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).pushReplacementNamed("myaccount");
                      },
                      style: ElevatedButton.styleFrom(
                        elevation: 0,
                        padding: EdgeInsets.zero,
                        backgroundColor: Colors.transparent,
                        shadowColor: Colors.transparent,
                        surfaceTintColor: Colors.transparent,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.zero),
                      ),
                      child: ClipOval(
                        child: Image.asset(
                          'images/young_happy_man.png',
                          width: 60,
                          height: 60,
                          fit: BoxFit.cover,
                        ),
                      ))
                ],
              ),
              backgroundColor: Color(0xFFF8D27B),
            ),
          )),
      body: ListView(
        children: [
          Expanded(
              child: Container(
                  padding: EdgeInsets.all(20),
                  child: ClipOval(
                    child: Image.asset(
                      'images/logo_home_page.png',
                      width: 100,
                      height: 100,
                      //fit: BoxFit.cover,
                    ),
                  ))),
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/dot_pattern_background.png'),
                fit: BoxFit.cover,
              ),
            ),
            child: SafeArea(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                child: Column(
                  children: [
                    const SizedBox(height: 10),
                    _buildMenuItem(
                        image: 'images/menu/emploi_temps.png',
                        iconColor: Colors.blue,
                        label: 'Emploi de temps',
                        backgroundColor: const Color(0xFFDCF5F5),
                        context: context),
                    const SizedBox(height: 10),
                    _buildMenuItem(
                        image: 'images/menu/disipline.png',
                        iconColor: Colors.black,
                        label: 'Discipline',
                        backgroundColor: const Color(0xFFDCF5F5),
                        context: context),
                    const SizedBox(height: 10),
                    _buildMenuItem(
                        image: 'images/menu/telechargement.png',
                        iconColor: Colors.amber,
                        label: 'Téléchargement',
                        backgroundColor: const Color(0xFFDCF5F5),
                        context: context),
                    const SizedBox(height: 10),
                    _buildMenuItem(
                        image: 'images/menu/notes.png',
                        iconColor: Colors.orange,
                        label: 'Notes',
                        backgroundColor: const Color(0xFFDCF5F5),
                        context: context),
                    const SizedBox(height: 10),
                    _buildMenuItem(
                        image: 'images/menu/cantine.png',
                        iconColor: Colors.orange,
                        label: 'Cantine',
                        backgroundColor: const Color(0xFFDCF5F5),
                        context: context),
                    const SizedBox(height: 10),
                    _buildMenuItem(
                        image: 'images/menu/actualite.png',
                        iconColor: Colors.red,
                        label: 'Actualités',
                        backgroundColor: const Color(0xFFDCF5F5),
                        hasNotification: true,
                        context: context),
                    const SizedBox(height: 10),
                    _buildMenuItem(
                        image: 'images/menu/examens.png',
                        iconColor: Colors.red,
                        label: 'Cal.Examens',
                        backgroundColor: const Color(0xFFDCF5F5),
                        context: context),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: CrystalNavigationBar(
        currentIndex: 0, // ✅ Provide a valid default value
        onTap: (index) {
          switch (index) {
            case 0:
              Navigator.of(context).pushReplacementNamed("home");
              break;
            case 1:
              Navigator.of(context).pushReplacementNamed("chatbot");
              break;
            case 2:
              //Navigator.of(context).pushReplacementNamed("menu");
              break;
            case 3:
              Navigator.of(context).pushReplacementNamed("settings");
              break;
            case 4:
              Navigator.of(context).pushReplacementNamed("myaccount");
              break;
          }
        },
        height: 10,
        // indicatorColor: Colors.blue,
        unselectedItemColor: Colors.white70,
        borderWidth: 2,
        outlineBorderColor: Colors.white,
        backgroundColor: Colors.black.withValues(alpha: 0.5),
        // boxShadow: [
        //   BoxShadow(
        //     color: Colors.black.withOpacity(0.1),
        //     blurRadius: 4,
        //     spreadRadius: 4,
        //     offset: Offset(0, 10),
        //   ),
        // ],
        items: [
          /// Home
          CrystalNavigationBarItem(
            icon: IconlyBold.home,
            unselectedIcon: IconlyLight.home,
            selectedColor: Colors.white,
          ),

          /// chatbot
          CrystalNavigationBarItem(
            icon: IconlyBold.chat,
            unselectedIcon: IconlyLight.chat,
            selectedColor: Colors.white,
          ),

          /// Add
          CrystalNavigationBarItem(
            icon: IconlyBold.category,
            unselectedIcon: IconlyLight.category,
            selectedColor: Colors.white,
          ),

          /// Search
          CrystalNavigationBarItem(
              icon: IconlyBold.setting,
              unselectedIcon: IconlyLight.setting,
              selectedColor: Colors.white),

          /// Profile
          CrystalNavigationBarItem(
            icon: IconlyBold.profile,
            unselectedIcon: IconlyLight.profile,
            selectedColor: Colors.white,
          ),
        ],
      ),
    ));
  }
}

Widget _buildMenuItem({
  required String image,
  required Color iconColor,
  required String label,
  required Color backgroundColor,
  required BuildContext context,
  bool hasNotification = false,
}) {
  return ElevatedButton(
      onPressed: () {
        switch (label) {
          case 'Emploi de temps':
            Navigator.of(context).pushNamed("schedule");
            break;
          case 'Discipline':
            Navigator.of(context).pushNamed("despline");
            break;
          case 'Téléchargement':
            Navigator.of(context).pushNamed("download");
            break;
          case 'Notes':
            Navigator.of(context).pushNamed("notes");
            break;
          case 'Cantine':
            Navigator.of(context).pushNamed("schedule");
            break;
          case 'Actualités':
            Navigator.of(context).pushNamed("activite");
            break;
          case 'Cal.Examens':
            Navigator.of(context).pushNamed("exames");
            break;
        }
      },
      style: ElevatedButton.styleFrom(
        elevation: 0,
        padding: EdgeInsets.zero,
        backgroundColor: Colors.transparent,
        shadowColor: Colors.transparent,
        surfaceTintColor: Colors.transparent,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.zero),
      ),
      child: Container(
        height: 70,
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Row(
          children: [
            const SizedBox(width: 16),
            Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                color: const Color(0xFFE0FFE0),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Stack(
                children: [
                  Center(
                    child: Image.asset(
                      image,
                      width: 70,
                      height: 70,
                      fit: BoxFit.contain,
                    ),
                  ),
                  if (hasNotification)
                    Positioned(
                      top: 5,
                      right: 5,
                      child: Container(
                        width: 10,
                        height: 10,
                        decoration: const BoxDecoration(
                          color: Colors.red,
                          shape: BoxShape.circle,
                        ),
                      ),
                    ),
                ],
              ),
            ),
            const SizedBox(width: 16),
            Text(
              label,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: Color(0xFF2E3D5C),
              ),
            ),
          ],
        ),
      ));
}
