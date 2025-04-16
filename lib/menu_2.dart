import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:crystal_navigation_bar/crystal_navigation_bar.dart';
import 'package:iconly/iconly.dart';
import 'package:badges/badges.dart' as badges;

class Menu2 extends StatelessWidget {
  const Menu2({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    // Adaptive button size based on screen width
    final double buttonSize = (screenWidth * 0.1).clamp(36.0, 48.0);
    return Scaffold(
      backgroundColor: Color(0xFFE8F0FE),
      body: SafeArea(
        child: ListView(padding: EdgeInsets.symmetric(vertical: 10), children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
            decoration: BoxDecoration(
              //color: const Color(0xFFF2F2F2), // Light gray background
              borderRadius: BorderRadius.circular(16.0),
            ),
            child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(children: [
                  const SizedBox(width: 8),

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
                                    borderRadius: BorderRadius.circular(15)),
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
                                                width: buttonSize * 0.6,
                                                height: buttonSize * 0.6,
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
                                                padding:
                                                    EdgeInsets.only(left: 30),
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
                  const SizedBox(width: 8),

                  // Trimester dropdown
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: DropdownButton<String>(
                      value: "3",
                      underline: Container(), // Remove the underline
                      icon: const Icon(Icons.arrow_drop_down),
                      hint: const Text("Premier trimestre"),
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

                  const SizedBox(width: 8),

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
                  const SizedBox(width: 8),

                  // Logout button
                  Container(
                    width: buttonSize.clamp(35, 50),
                    height: buttonSize.clamp(35, 50),
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
                                            backgroundColor: Colors.transparent,
                                            shadowColor: Colors.transparent,
                                            surfaceTintColor:
                                                Colors.transparent,
                                            shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(20)),
                                          ),
                                          onPressed: () {
                                            Navigator.of(context).pop();
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

                  const SizedBox(width: 8),
                ])),
          ),
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
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
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
                        textDirection: TextDirection.rtl,
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
                      child: ElevatedButton(
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
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                backgroundColor: Colors.white,
                                shape: CircleBorder(),
                                content: Image.asset(
                                  'images/student.png', // Replace with your placeholder image path
                                  fit: BoxFit.cover,
                                  width: 200,
                                  height: 200,
                                  // Alternatively, you can use a placeholder icon:
                                  // child: Icon(Icons.person, size: 40, color: Colors.grey.shade400),
                                ),
                              );
                            },
                          );
                        },
                        child: Image.asset(
                          'images/student.png', // Replace with your placeholder image path
                          fit: BoxFit.cover,
                          // Alternatively, you can use a placeholder icon:
                          // child: Icon(Icons.person, size: 40, color: Colors.grey.shade400),
                        ),
                      )),
                ],
              ),
            ),
          ),
          Container(
            color: Colors.white,
            child: Center(
              child: Container(
                padding: const EdgeInsets.all(16),
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(24),
                ),
                child: GridView.count(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  crossAxisCount: 3,
                  crossAxisSpacing: 12,
                  mainAxisSpacing: 12,
                  childAspectRatio: 1.0,
                  children: [
                    DashboardItem(
                      image: "images/dashboard/courses.png",
                      label: 'Courses',
                      route: "",
                    ),
                    DashboardItem(
                      image: "images/dashboard/assignment.png",
                      label: 'Assignment',
                      route: 'homework_menu',
                    ),
                    DashboardItem(
                      image: "images/dashboard/books.png",
                      label: 'Mes livres',
                      route: "",
                    ),
                    DashboardItem(
                      image: "images/dashboard/Meeting.png",
                      label: 'Réunions',
                      route: "",
                    ),
                    DashboardItem(
                      image: "images/dashboard/Schedule.png",
                      label: """Emploi du
temps""",
                      route: "schedule",
                    ),
                    DashboardItem(
                      image: "images/dashboard/communique.png",
                      label: 'Notes',
                      route: "notes",
                    ),
                    DashboardItem(
                      image: "images/dashboard/Payment.png",
                      label: 'Paiement',
                      route: "payment",
                    ),
                    DashboardItem(
                      image: "images/dashboard/cantine.png",
                      label: 'Cantine',
                      route: "cantine",
                    ),
                    DashboardItem(
                      image: "images/dashboard/Discipline.png",
                      label: 'Discipline',
                      route: "behavior",
                    ),
                    DashboardItem(
                      image: "images/dashboard/Information.png",
                      label: 'Savoir plus',
                      route: "",
                    ),
                    DashboardItem(
                      image: "images/dashboard/Rapport.png",
                      label: 'Rapport',
                      route: "",
                    ),
                    DashboardItem(
                      image: "images/dashboard/Attendance.png",
                      label: 'Présence',
                      route: "despline",
                    ),
                  ],
                ),
              ),
            ),
          ),
        ]),
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
    );
  }
}

class DashboardItem extends StatelessWidget {
  final String image;
  final String label;
  final String route;

  const DashboardItem(
      {Key? key, required this.image, required this.label, required this.route})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFFE8F0FE), // Light blue background
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            image,
            width: 48,
            height: 48,
          ),
          const SizedBox(height: 8),
          ElevatedButton(
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
            onPressed: () {
              if (route != "") {
                print(route);
                Navigator.of(context).pushNamed(route);
              }
            },
            child: Text(
              label,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
          )
        ],
      ),
    );
  }
}
