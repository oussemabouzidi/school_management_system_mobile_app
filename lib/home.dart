import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:crystal_navigation_bar/crystal_navigation_bar.dart';
import 'package:iconly/iconly.dart';
import 'package:badges/badges.dart' as badges;
import 'package:animated_text_kit/animated_text_kit.dart';

class Home extends StatefulWidget {
  State<Home> createState() => _Home();
}

class _Home extends State<Home> {
  // list of latest grades to display
  final List<Map<String, String>> grades = [
    {'subject': 'ANGLAIS', 'date': '10 janv', 'grade': '12,00'},
    {'subject': 'FRANCAIS', 'date': '7 janv', 'grade': '12,00'},
    {'subject': 'PHYSIQUE', 'date': '10 janv', 'grade': '12,00'},
    {'subject': 'INFORMATIQUE', 'date': '10 janv', 'grade': '12,00'},
    {'subject': 'ARAB', 'date': '10 janv', 'grade': '12,00'},
  ];

  bool _showChatbotTooltip = true;

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(seconds: 5), () {
      setState(() {
        _showChatbotTooltip = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFE8F0FE),
      extendBody: true,
      body: Padding(
        padding: EdgeInsets.symmetric(vertical: 20),
        child: Stack(
          children: [
            ListView(
              padding: EdgeInsets.all(16.0),
              children: [
                // Top navigation row with language, trimester, year, and logout
                Container(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 8.0, vertical: 4.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16.0),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
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
                                                    BorderRadius.circular(15)),
                                            height: 50,
                                            width: 250,
                                            child: Row(
                                              children: [
                                                Padding(
                                                  padding:
                                                      EdgeInsets.only(left: 30),
                                                  child: Image.asset(
                                                    'images/languages/francais.png',
                                                    width: 30,
                                                    height: 30,
                                                  ),
                                                ),
                                                Padding(
                                                  padding:
                                                      EdgeInsets.only(left: 30),
                                                  child: Center(
                                                      child: Text("Francais")),
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
                                                    BorderRadius.circular(15)),
                                            height: 50,
                                            width: 250,
                                            child: Row(
                                              children: [
                                                Padding(
                                                  padding:
                                                      EdgeInsets.only(left: 30),
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
                                                    BorderRadius.circular(15)),
                                            height: 50,
                                            width: 250,
                                            child: Row(
                                              children: [
                                                Padding(
                                                  padding:
                                                      EdgeInsets.only(left: 30),
                                                  child: Image.asset(
                                                    'images/languages/arabicLanguage.png',
                                                    width: 30,
                                                    height: 30,
                                                  ),
                                                ),
                                                Padding(
                                                  padding:
                                                      EdgeInsets.only(left: 30),
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
                      // Notification button with badge
                      badges.Badge(
                        badgeContent: Text(
                          '3',
                          style: TextStyle(color: Colors.white, fontSize: 10),
                        ),
                        badgeStyle: badges.BadgeStyle(
                          badgeColor: Colors.red,
                          padding: EdgeInsets.all(6),
                        ),
                        child: Container(
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
                                        borderRadius: BorderRadius.circular(15),
                                      ),
                                      title: Text(
                                        "Notifications",
                                        style:
                                            TextStyle(color: Colors.red[400]),
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
                            icon: HugeIcon(
                              icon: HugeIcons.strokeRoundedNotification03,
                              color: Colors.grey[700]!,
                              size: 24.0,
                            ),
                            padding: EdgeInsets.zero,
                          ),
                        ),
                      ),

                      // Year dropdown
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12.0),
                        ),
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: DropdownButton<String>(
                          value: "2023/2024",
                          underline: Container(), // Remove the underline
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

                      // Logout button
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
                                                padding: EdgeInsets.symmetric(
                                                    vertical: 16),
                                                backgroundColor:
                                                    Colors.transparent,
                                                shadowColor: Colors.transparent,
                                                surfaceTintColor:
                                                    Colors.transparent,
                                                shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            20)),
                                              ),
                                              onPressed: () {
                                                Navigator.of(context).pop();
                                              },
                                              child: Container(
                                                decoration: BoxDecoration(
                                                    color: Color(0xFF9ECAFF),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            15)),
                                                height: 30,
                                                width: 50,
                                                child:
                                                    Center(child: Text("Non")),
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
                                                  backgroundColor:
                                                      Colors.transparent,
                                                  shadowColor:
                                                      Colors.transparent,
                                                  surfaceTintColor:
                                                      Colors.transparent,
                                                  shape: RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              20)),
                                                ),
                                                onPressed: () {},
                                                child: Container(
                                                  decoration: BoxDecoration(
                                                      color: Color(0xFFFF8CA1),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              15)),
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
                          icon: Image.asset(
                            "images/dashboard/Logout.png",
                            width: 24,
                            height: 24,
                          ),
                          padding: EdgeInsets.zero,
                        ),
                      ),
                    ],
                  ),
                ),

                SizedBox(height: 16),

                // User profile card
                Container(
                  width: double.infinity,
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
                    padding: const EdgeInsets.symmetric(
                        horizontal: 24, vertical: 16),
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
                          clipBehavior: Clip.antiAlias,
                          child: Image.asset(
                            'images/student.png',
                            fit: BoxFit.cover,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                SizedBox(height: 24),

                // Presence Card
                Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.05),
                        blurRadius: 8,
                        spreadRadius: 0,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: ElevatedButton(
                    onPressed: () {
                      //Navigator.of(context).pushNamed("presence");
                      showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              title: Text("Votre présence est marqué !"),
                              content: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Image.asset("images/done.png"),
                                  ElevatedButton(
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                      child: Container(
                                        width: 80,
                                        child: Center(
                                          child: Text("Ok"),
                                        ),
                                      ))
                                ],
                              ),
                            );
                          });
                    },
                    style: ElevatedButton.styleFrom(
                      elevation: 0,
                      padding: EdgeInsets.symmetric(vertical: 16),
                      backgroundColor: Colors.transparent,
                      shadowColor: Colors.transparent,
                      surfaceTintColor: Colors.transparent,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20)),
                    ),
                    child: Column(
                      children: [
                        Text(
                          "Marqué votre présence",
                          style: TextStyle(
                            color: Color(0xFF2D3142),
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 12),
                        Image.asset(
                          'images/presence.png',
                          width: 80,
                          height: 80,
                        )
                      ],
                    ),
                  ),
                ),

                SizedBox(height: 24),

                // Quick Access Menu
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.05),
                        blurRadius: 8,
                        spreadRadius: 0,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      Text(
                        "Accès Rapide",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF2D3142),
                        ),
                      ),
                      SizedBox(height: 16),
                      // Quick access grid
                      GridView.count(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        crossAxisCount: 3,
                        crossAxisSpacing: 12,
                        mainAxisSpacing: 12,
                        childAspectRatio: 1.0,
                        children: const [
                          DashboardItem(
                            image: "images/dashboard/Schedule.png",
                            label: 'Emploi du temps',
                          ),
                          DashboardItem(
                            image: "images/dashboard/books.png",
                            label: 'Mes livres',
                          ),
                          DashboardItem(
                            image: "images/dashboard/assignment.png",
                            label: 'Assignment',
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

                SizedBox(height: 24),

                // Next exam card
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.05),
                        blurRadius: 8,
                        spreadRadius: 0,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      // Header
                      Container(
                        padding: const EdgeInsets.symmetric(
                            vertical: 12, horizontal: 16),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(20),
                            topRight: Radius.circular(20),
                          ),
                        ),
                        child: Row(
                          children: [
                            Icon(
                              Icons.event_note,
                              color: Color(0xFF559DFF),
                            ),
                            SizedBox(width: 8),
                            Text(
                              'Prochains Devoir',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF2D3142),
                              ),
                            ),
                          ],
                        ),
                      ),
                      // Divider
                      Container(
                        height: 1,
                        color: const Color(0xFFEEEEEE),
                      ),
                      // Content
                      Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(20),
                            bottomRight: Radius.circular(20),
                          ),
                        ),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Date container
                            Container(
                              width: 50,
                              height: 50,
                              decoration: BoxDecoration(
                                color: Color(0xFFE8F0FE),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: const [
                                  Text(
                                    '16',
                                    style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      color: Color(0xFF559DFF),
                                    ),
                                  ),
                                  Text(
                                    'janv.',
                                    style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w500,
                                      color: Color(0xFF559DFF),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(width: 16),
                            // Test details
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: const [
                                  Text(
                                    'MATÉMATIQUE',
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: Color(0xFF2D3142),
                                    ),
                                  ),
                                  SizedBox(height: 4),
                                  Text(
                                    'Mr blanc',
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: Color(0xFF2D3142),
                                    ),
                                  ),
                                  SizedBox(height: 4),
                                  Text(
                                    'jeudi 16 janv, de 11h00 à 12h00',
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: Colors.grey,
                                    ),
                                  ),
                                  SizedBox(height: 4),
                                  Row(
                                    children: [
                                      Icon(
                                        Icons.location_on,
                                        size: 16,
                                        color: Colors.red,
                                      ),
                                      SizedBox(width: 4),
                                      Text(
                                        'Salle 21',
                                        style: TextStyle(
                                          fontSize: 14,
                                          color: Colors.grey,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),

                SizedBox(height: 24),

                // Latest grades
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.05),
                        blurRadius: 8,
                        spreadRadius: 0,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      // Header
                      Container(
                        padding: const EdgeInsets.symmetric(
                            vertical: 12, horizontal: 16),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(20),
                            topRight: Radius.circular(20),
                          ),
                        ),
                        child: Row(
                          children: [
                            Icon(
                              Icons.score,
                              color: Color(0xFF559DFF),
                            ),
                            SizedBox(width: 8),
                            Text(
                              'Dernières notes',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF2D3142),
                              ),
                            ),
                          ],
                        ),
                      ),
                      // Divider
                      Container(
                        height: 1,
                        color: const Color(0xFFEEEEEE),
                      ),
                      // Grade items
                      ...grades.map((grade) => _buildGradeItem(grade)).toList(),
                    ],
                  ),
                ),

                SizedBox(height: 90), // Extra space for the bottom navigation
              ],
            ),

            // 2. Tooltip + FAB positioned on screen
            Positioned(
              bottom: 100,
              right: 20,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  // Tooltip text
                  if (_showChatbotTooltip)
                    Container(
                        margin: const EdgeInsets.only(bottom: 8, right: 10),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 12, vertical: 20),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black26,
                              blurRadius: 6,
                              offset: Offset(0, 2),
                            ),
                          ],
                        ),
                        child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 15),
                            child: Center(
                              child: AnimatedTextKit(
                                animatedTexts: [
                                  TyperAnimatedText(
                                    """Posez une question à 
notre chatbot ! 😃🚀 """,
                                    textStyle: TextStyle(
                                      color: Colors.black87,
                                      fontSize: 14,
                                    ),
                                  )
                                ],
                                totalRepeatCount: 1,
                              ),
                            ))),

                  // Floating button
                  FloatingActionButton(
                    onPressed: () {
                      setState(() {
                        _showChatbotTooltip = false;
                      });
                      Navigator.of(context).pushNamed("chatbot");
                    },
                    backgroundColor: const Color(0xFF559DFF).withOpacity(0.1),
                    shape: const CircleBorder(),
                    child: Image.asset(
                      "images/bot.png",
                      width: 70,
                      height: 70,
                    ),
                  ),
                ],
              ),
            ),
          ],
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
    );
  }
}

Widget _buildGradeItem(Map<String, String> grade) {
  return Container(
    padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
    decoration: BoxDecoration(
      color: Colors.white,
      border: Border(
        bottom: BorderSide(
          color: Color(0xFFEEEEEE),
          width: 1,
        ),
      ),
    ),
    child: Row(
      children: [
        // Subject and date
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                grade['subject']!,
                style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF2D3142),
                ),
              ),
              const SizedBox(height: 4),
              Row(
                children: [
                  Icon(
                    Icons.calendar_today,
                    size: 12,
                    color: Colors.grey,
                  ),
                  SizedBox(width: 4),
                  Text(
                    grade['date']!,
                    style: const TextStyle(
                      fontSize: 13,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        // Grade
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          decoration: BoxDecoration(
            color: Color(0xFF559DFF),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Text(
            grade['grade']!,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 14,
              color: Colors.white,
            ),
          ),
        ),
      ],
    ),
  );
}

class DashboardItem extends StatelessWidget {
  final String image;
  final String label;

  const DashboardItem({
    Key? key,
    required this.image,
    required this.label,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFFE8F0FE),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            image,
            width: 40,
            height: 40,
          ),
          const SizedBox(height: 8),
          ElevatedButton(
            onPressed: () {
              switch (label) {
                case "Emploi du temps":
                  Navigator.of(context).pushNamed("schedule");
                  break;
                case "Assignment":
                  Navigator.of(context).pushNamed("homework_menu");
                  break;
                default:
                  break;
              }
            },
            style: ElevatedButton.styleFrom(
              elevation: 0,
              padding: EdgeInsets.symmetric(vertical: 16),
              backgroundColor: Colors.transparent,
              shadowColor: Colors.transparent,
              surfaceTintColor: Colors.transparent,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20)),
            ),
            child: Text(
              label,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.bold,
                color: Color(0xFF2D3142),
              ),
            ),
          )
        ],
      ),
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
