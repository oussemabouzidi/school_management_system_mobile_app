import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:crystal_navigation_bar/crystal_navigation_bar.dart';
import 'package:iconly/iconly.dart';
import 'package:badges/badges.dart' as badges;

class Presence extends StatelessWidget {
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
                    ClipOval(
                        child: Container(
                            decoration: BoxDecoration(color: Colors.grey[700]),
                            width: 35,
                            height: 35,
                            child: ElevatedButton(
                              onPressed: () {
                                Navigator.of(context).pop();
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
                                  icon: Icons.arrow_back_ios,
                                  color: Colors.white),
                            ))),
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
                          Navigator.of(context)
                              .pushReplacementNamed("myaccount");
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
            SizedBox(
              height: 100,
            ),
            Container(
              decoration: BoxDecoration(color: Colors.white),
              width: 100,
              child: Column(children: [
                Image.asset('images/presence2.png'),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 30),
                  child: Text(
                    "Votre présence est marqué",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 10),
                  child: Align(
                    alignment: Alignment.center,
                    child: Container(
                      child: Image.asset("images/done.png"),
                    ),
                  ),
                )
              ]),
            )
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
                Navigator.of(context).pushReplacementNamed("menu");
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
      ),
    );
  }
}
