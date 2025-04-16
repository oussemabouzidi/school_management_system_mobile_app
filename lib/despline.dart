import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:crystal_navigation_bar/crystal_navigation_bar.dart';
import 'package:iconly/iconly.dart';

class Despline extends StatelessWidget {
  final List<String> months = const ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun'];
  final Function(String month)? onMonthPressed;

  const Despline({
    Key? key,
    this.onMonthPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: const Color(0xFFE8F0FE),
        extendBody: true,
        body: ListView(
          children: [
            // Top Navigation Bar
            Container(
              padding:
                  const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    // back button
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
                        child: Icon(Icons.arrow_back, color: Colors.black54),
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
                    SizedBox(
                      width: 8,
                    ),
                  ],
                ),
              ),
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

            // Attendance Content
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
                    const Text(
                      "Présence",
                      style: TextStyle(
                          color: Colors.blue,
                          fontSize: 20,
                          fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 30),
                    Column(
                      children: [
                        for (int i = 0; i < months.length; i++)
                          Padding(
                            padding: const EdgeInsets.only(bottom: 16),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                // Month button
                                GestureDetector(
                                    onTap: () =>
                                        onMonthPressed?.call(months[i]),
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
                                        Navigator.of(context)
                                            .pushNamed("despline_2");
                                      },
                                      child: Container(
                                        width: 60,
                                        height: 60,
                                        decoration: BoxDecoration(
                                          color: Colors.grey[500],
                                          borderRadius:
                                              BorderRadius.circular(15),
                                        ),
                                        child: Center(
                                          child: Text(
                                            months[i],
                                            style: const TextStyle(
                                                color: Colors.white,
                                                fontSize: 18,
                                                fontWeight: FontWeight.w500),
                                          ),
                                        ),
                                      ),
                                    )),
                                const SizedBox(width: 12),

                                // Present count
                                _buildAttendanceCard(
                                  count: '23',
                                  label: 'Present',
                                  color: const Color(0xFFAAF0C8),
                                  textColor: const Color(0xFF008000),
                                  icon: "images/present.png",
                                ),
                                const SizedBox(width: 12),

                                // Absent count
                                _buildAttendanceCard(
                                  count: '3',
                                  label: 'Absent',
                                  color: const Color(0xFFFFDADA),
                                  textColor: const Color(0xFFFF6B6B),
                                  icon: "images/absent.png",
                                ),
                                const SizedBox(width: 12),

                                // Late count
                                _buildAttendanceCard(
                                  count: '2',
                                  label: 'Retard',
                                  color: const Color(0xFFCCE6FF),
                                  textColor: const Color(0xFF4A86E8),
                                  icon: "images/late.png",
                                ),
                              ],
                            ),
                          ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {},
          backgroundColor: const Color(0xFF12B264),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          child: const Row(
            //mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                "Filtre",
                style: TextStyle(color: Colors.white),
              ),
              Icon(
                Icons.filter_alt_outlined,
                color: Colors.white,
                size: 20,
              ),
            ],
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.startFloat,
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

  Widget _buildAttendanceCard({
    required String count,
    required String label,
    required Color color,
    required Color textColor,
    required String icon,
  }) {
    return Container(
      width: 70,
      height: 70,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            count,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
              color: textColor,
            ),
          ),
          Text(
            label,
            style: TextStyle(
              fontSize: 12,
              color: textColor,
            ),
          ),
          Image.asset(
            icon,
            width: 30,
            height: 30,
          )
        ],
      ),
    );
  }
}
