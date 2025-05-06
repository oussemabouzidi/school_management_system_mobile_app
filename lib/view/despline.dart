import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_app3/widgets/language_button.dart';
import 'package:my_app3/widgets/student_card.dart';

class Despline extends StatelessWidget {
  final List<String> months = const ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun'];
  final Function(String month)? onMonthPressed;

  const Despline({
    Key? key,
    this.onMonthPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Stack(
      children: [
        ListView(
          children: [
            // Top Bar
            Container(
              padding:
                  const EdgeInsets.symmetric(horizontal: 8.0, vertical: 16.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16.0),
              ),
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
                            Get.back(id: 1);
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
                      SizedBox(width: screenWidth * 0.06),
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
                      SizedBox(width: screenWidth * 0.06),
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
                      SizedBox(width: screenWidth * 0.06),
                      // Language button
                      LanguageButton(),
                    ],
                  )),
            ),

            // Profile Card
            StudentCard(),
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
                                        Get.toNamed('/menu/despline_mounth',
                                            id: 1);
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
        Positioned(
          bottom: 128,
          right: 32,
          child: FloatingActionButton(
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
        ),
      ],
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
