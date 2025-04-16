import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:crystal_navigation_bar/crystal_navigation_bar.dart';
import 'package:iconly/iconly.dart';
import 'package:badges/badges.dart' as badges;
import 'package:easy_date_timeline/easy_date_timeline.dart';

class Schedule extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    // Adaptive button size based on screen width
    final double buttonSize = (screenWidth * 0.1).clamp(36.0, 48.0);

    return MaterialApp(
      home: Scaffold(
        backgroundColor: Color(0xFFE8F0FE),
        extendBody: true,
        body: SafeArea(
          child: ListView(
            children: [
              // Top Bar
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.5),
                                spreadRadius: 2,
                                blurRadius: 5,
                                offset: Offset(0, 3),
                              ),
                            ],
                          ),
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
                                borderRadius: BorderRadius.zero,
                              ),
                            ),
                            child:
                                Icon(Icons.arrow_back, color: Colors.black54),
                          ),
                        ),
                        SizedBox(
                          width: 8,
                        ),
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(12.0),
                          ),
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: DropdownButton<String>(
                            value: "3",
                            underline: Container(),
                            icon: const Icon(Icons.arrow_drop_down),
                            items: const [
                              DropdownMenuItem(
                                value: "1",
                                child: Text("Premier trimestre"),
                              ),
                              DropdownMenuItem(
                                value: "2",
                                child: Text("Deuxième trimestre"),
                              ),
                              DropdownMenuItem(
                                value: "3",
                                child: Text("Troisième trimestre"),
                              ),
                            ],
                            onChanged: (value) {},
                          ),
                        ),
                        SizedBox(
                          width: 8,
                        ),
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(12.0),
                          ),
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: DropdownButton<String>(
                            value: "2023/2024",
                            underline: Container(),
                            icon: const Icon(Icons.arrow_drop_down),
                            items: const [
                              DropdownMenuItem(
                                value: "2025/2026",
                                child: Text("2025/2026"),
                              ),
                              DropdownMenuItem(
                                value: "2024/2025",
                                child: Text("2024/2025"),
                              ),
                              DropdownMenuItem(
                                value: "2023/2024",
                                child: Text("2023/2024"),
                              ),
                            ],
                            onChanged: (value) {},
                          ),
                        ),
                        SizedBox(
                          width: 8,
                        ),
                        // Language button
                        Container(
                          width: 40,
                          height: 40,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(12.0),
                          ),
                          child: IconButton(
                            onPressed: () {
                              showDialog(
                                  context: context,
                                  builder: (context) {
                                    return AlertDialog(
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(15)),
                                      title: Text("Choisir language"),
                                      content: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Container(
                                              decoration: BoxDecoration(
                                                  color: Color(0xFF9ECAFF),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          15)),
                                              height: 50,
                                              width: 250,
                                              child: Row(
                                                children: [
                                                  Padding(
                                                    padding: EdgeInsets.only(
                                                        left: 30),
                                                    child: Image.asset(
                                                      'images/languages/francais.png',
                                                      width: 30,
                                                      height: 30,
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding: EdgeInsets.only(
                                                        left: 30),
                                                    child: Center(
                                                        child:
                                                            Text("Francais")),
                                                  )
                                                ],
                                              )),
                                          SizedBox(
                                            height: 10,
                                          ),
                                          Container(
                                              decoration: BoxDecoration(
                                                  color: Color(0xFFFF8CA1),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          15)),
                                              height: 50,
                                              width: 250,
                                              child: Row(
                                                children: [
                                                  Padding(
                                                    padding: EdgeInsets.only(
                                                        left: 30),
                                                    child: Image.asset(
                                                      'images/languages/unitedKingdom.png',
                                                      width: 30,
                                                      height: 30,
                                                    ),
                                                  ),
                                                  Padding(
                                                      padding: EdgeInsets.only(
                                                          left: 30),
                                                      child: Center(
                                                        child: Text("Englais"),
                                                      )),
                                                ],
                                              )),
                                          SizedBox(
                                            height: 10,
                                          ),
                                          Container(
                                              decoration: BoxDecoration(
                                                  color: Color(0xFF92FFC1),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          15)),
                                              height: 50,
                                              width: 250,
                                              child: Row(
                                                children: [
                                                  Padding(
                                                    padding: EdgeInsets.only(
                                                        left: 30),
                                                    child: Image.asset(
                                                      'images/languages/arabicLanguage.png',
                                                      width: 30,
                                                      height: 30,
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding: EdgeInsets.only(
                                                        left: 30),
                                                    child: Text("Arabic"),
                                                  )
                                                ],
                                              )),
                                        ],
                                      ),
                                    );
                                  });
                            },
                            icon: Image.asset(
                              "images/dashboard/Language.png",
                              width: 24,
                              height: 24,
                            ),
                            padding: EdgeInsets.zero,
                          ),
                        ),
                      ],
                    )),
              ),

// Profile Card
              Container(
                width: double.infinity,
                margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(28),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.05),
                      blurRadius: 10,
                      spreadRadius: 0,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
                          Text(
                            "Ahmed Snoussi",
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF2D3142),
                            ),
                          ),
                          SizedBox(height: 8),
                          Text(
                            "Deuxième année",
                            style: TextStyle(
                              fontSize: 18,
                              color: Color(0xFF2D3142),
                            ),
                          ),
                        ],
                      ),
                      Container(
                        width: 70,
                        height: 70,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.grey.shade200,
                        ),
                        child: Image.asset('images/student.png'),
                      ),
                    ],
                  ),
                ),
              ),
              // Schedule Content
              Container(
                margin: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(28),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.05),
                      blurRadius: 10,
                      spreadRadius: 0,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.all(20),
                        child: Center(
                          child: Text(
                            "Emploi du temps",
                            style: TextStyle(
                              color: Colors.blue,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                      EasyDateTimeLine(
                        initialDate: DateTime.now(),
                        onDateChange: (selectedDate) {},
                        headerProps: const EasyHeaderProps(
                          monthPickerType: MonthPickerType.switcher,
                          dateFormatter: DateFormatter.fullDateDMY(),
                        ),
                        dayProps: const EasyDayProps(
                          dayStructure: DayStructure.dayStrDayNum,
                          activeDayStyle: DayStyle(
                            decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(8)),
                                color: Color.fromARGB(255, 89, 139, 255)
                                /*gradient: LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: [
                                Color(0xff3371FF),
                                Color.fromARGB(255, 125, 108, 180),
                              ],
                            ),*/
                                ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 30),
                      Column(
                        children: [
                          ClassItem(
                            time: "9h00",
                            subject: "FRANCAIS",
                            teacher: "GALLET B.",
                            room: "105",
                            color: Colors.indigo,
                          ),
                          const SizedBox(height: 12),
                          ClassItem(
                            time: "9h00",
                            subject: "HISTOIRE-GÉOGRAPHIE",
                            teacher: "MOREAU C.",
                            room: "206",
                            color: Colors.cyan,
                          ),
                          const SizedBox(height: 12),
                          ClassItem(
                            time: "9h00",
                            subject: "MATHÉMATIQUES",
                            teacher: "PROFESSEUR M.",
                            room: "207",
                            color: Colors.orange,
                          ),
                          const SizedBox(height: 12),
                          BreakItem(time: "9h00"),
                          const SizedBox(height: 12),
                          ClassItem(
                            time: "9h00",
                            subject: "SCIENCES DE LA VIE ET DE LA TERRE",
                            teacher: "TESSIER A.",
                            room: "Labo 2",
                            color: Colors.black87,
                          ),
                          const SizedBox(height: 12),
                          ClassItem(
                            time: "9h00",
                            subject: "ANGLAIS LV1",
                            teacher: "BROWN J.",
                            room: "103",
                            color: Colors.amberAccent[400]!,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {},
          backgroundColor: Color(0xFF12B264),
          shape: CircleBorder(),
          child: Icon(Icons.picture_as_pdf, color: Colors.white),
        ),
        bottomNavigationBar: CrystalNavigationBar(
          currentIndex: 2, // ✅ Provide a valid default value
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
      ),
    );
  }
}

class ClassItem extends StatelessWidget {
  final String time;
  final String subject;
  final String teacher;
  final String room;
  final Color color;

  const ClassItem({
    required this.time,
    required this.subject,
    required this.teacher,
    required this.room,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 40,
          child: Text(
            time,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        Container(
          width: 4,
          height: 60,
          color: color,
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                subject,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                teacher,
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.grey[600],
                ),
              ),
              const SizedBox(height: 2),
              Text(
                room,
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.grey[600],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class BreakItem extends StatelessWidget {
  final String time;

  const BreakItem({
    required this.time,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 40,
          child: Text(
            time,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        Container(
          width: 4,
          height: 30,
          color: Colors.grey[400],
        ),
        const SizedBox(width: 12),
        Padding(
          padding: const EdgeInsets.only(top: 4.0),
          child: Icon(
            Icons.restaurant,
            color: Colors.grey[600],
            size: 20,
          ),
        ),
      ],
    );
  }
}
