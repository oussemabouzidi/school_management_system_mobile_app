import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:crystal_navigation_bar/crystal_navigation_bar.dart';
import 'package:iconly/iconly.dart';
import 'package:badges/badges.dart' as badges;

class Exames extends StatelessWidget {
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
            Padding(
              padding: EdgeInsets.symmetric(vertical: 30),
              child: Container(
                alignment: Alignment.topCenter,
                child: Text("Calendrier des examens",
                    style: TextStyle(color: Colors.blue, fontSize: 20)),
              ),
            ),
            Container(
              child: ClassScheduleWidget(),
            ),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {},
          backgroundColor: Color(0xFF12B264),
          shape: CircleBorder(),
          child: Icon(
            Icons.picture_as_pdf,
            color: Colors.white,
          ),
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

class ClassScheduleWidget extends StatelessWidget {
  // You can pass this list from your parent widget if needed
  final List<ClassItem> classes = [
    ClassItem(
      date: "1",
      month: "JAN",
      subject: "Science",
      day: "Monday",
      time: "09:00 AM",
      dayColor: Colors.pink[300]!,
    ),
    ClassItem(
      date: "1",
      month: "JAN",
      subject: "English",
      day: "Wednesday",
      time: "09:00 AM",
      dayColor: Colors.pink[300]!,
    ),
    ClassItem(
      date: "1",
      month: "JAN",
      subject: "Arabic",
      day: "Friday",
      time: "09:00 AM",
      dayColor: Colors.pink[300]!,
    ),
    ClassItem(
      date: "18",
      month: "JAN",
      subject: "Math",
      day: "Monday",
      time: "09:00 AM",
      dayColor: Colors.pink[300]!,
    ),
    ClassItem(
      date: "20",
      month: "JAN",
      subject: "Social Study",
      day: "Wednesday",
      time: "09:00 AM",
      dayColor: Colors.pink[300]!,
    ),
    ClassItem(
      date: "22",
      month: "JAN",
      subject: "Drawing",
      day: "Friday",
      time: "09:00 AM",
      dayColor: Colors.pink[300]!,
    ),
    ClassItem(
      date: "25",
      month: "JAN",
      subject: "Computer",
      day: "Monday",
      time: "09:00 AM",
      dayColor: Colors.pink[300]!,
    ),
  ];

  ClassScheduleWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey[50],
      child: ListView.separated(
        shrinkWrap: true,
        physics:
            NeverScrollableScrollPhysics(), // Use this if inside a ScrollView
        // If you want it scrollable itself, remove this line
        itemCount: classes.length,
        separatorBuilder: (context, index) => Divider(
          color: Colors.amber[300],
          height: 1,
          thickness: 1,
        ),
        itemBuilder: (context, index) {
          return ClassScheduleCard(classItem: classes[index]);
        },
      ),
    );
  }
}

class ClassItem {
  final String date;
  final String month;
  final String subject;
  final String day;
  final String time;
  final Color dayColor;

  ClassItem({
    required this.date,
    required this.month,
    required this.subject,
    required this.day,
    required this.time,
    required this.dayColor,
  });
}

class ClassScheduleCard extends StatelessWidget {
  final ClassItem classItem;

  const ClassScheduleCard({Key? key, required this.classItem})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80,
      margin: EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          // Date and Month Column
          SizedBox(
            width: 50,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  classItem.date,
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.purple[300],
                  ),
                ),
                Text(
                  classItem.month,
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.purple[300],
                  ),
                ),
              ],
            ),
          ),
          SizedBox(width: 16),
          // Subject and Day Column
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  classItem.subject,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.blue[800],
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  classItem.day,
                  style: TextStyle(
                    fontSize: 14,
                    color: classItem.dayColor,
                  ),
                ),
              ],
            ),
          ),
          // Time Column with Clock Icon
          Row(
            children: [
              Icon(
                Icons.access_time,
                color: Colors.red[300],
                size: 16,
              ),
              SizedBox(width: 4),
              Text(
                classItem.time,
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.red[300],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
