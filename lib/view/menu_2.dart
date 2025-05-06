import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_app3/widgets/language_button.dart';
import 'package:my_app3/widgets/logout_button.dart';
import 'package:my_app3/widgets/student_card.dart';

class Menu2 extends StatelessWidget {
  const Menu2({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    // Adaptive button size based on screen width
    return ListView(children: [
      Container(
        padding: EdgeInsets.symmetric(
            horizontal: screenWidth / 80, vertical: screenHeight / 50),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16.0),
        ),
        child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(children: [
              // Language button
              LanguageButton(),
              SizedBox(width: screenWidth * 0.06),

              // Trimester dropdown
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12.0),
                ),
                padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.008),
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

              SizedBox(width: screenWidth * 0.06),

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
              SizedBox(width: screenWidth * 0.06),

              // Logout button
              LogoutButton(),
              //SizedBox(width: screenWidth * 0.06),
            ])),
      ),
      StudentCard(),
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
                  route: '',
                ),
                DashboardItem(
                  image: "images/dashboard/assignment.png",
                  label: 'Assignment',
                  route: '/menu/homework',
                ),
                DashboardItem(
                  image: "images/dashboard/books.png",
                  label: 'Mes livres',
                  route: '',
                ),
                DashboardItem(
                  image: "images/dashboard/Meeting.png",
                  label: 'Réunions',
                  route: '',
                ),
                DashboardItem(
                  image: "images/dashboard/Schedule.png",
                  label: """Emploi du
temps""",
                  route: '/menu/schedule',
                ),
                DashboardItem(
                  image: "images/dashboard/communique.png",
                  label: 'Notes',
                  route: '/menu/notes',
                ),
                DashboardItem(
                  image: "images/dashboard/Payment.png",
                  label: 'Paiement',
                  route: '/menu/paiement',
                ),
                DashboardItem(
                  image: "images/dashboard/cantine.png",
                  label: 'Cantine',
                  route: '/menu/cantine',
                ),
                DashboardItem(
                  image: "images/dashboard/Discipline.png",
                  label: 'Discipline',
                  route: '/menu/behavior',
                ),
                DashboardItem(
                  image: "images/dashboard/Information.png",
                  label: 'Savoir plus',
                  route: '',
                ),
                DashboardItem(
                  image: "images/dashboard/Rapport.png",
                  label: 'Actualité',
                  route: '/menu/actualite',
                ),
                DashboardItem(
                  image: "images/dashboard/Attendance.png",
                  label: 'Présence',
                  route: '/menu/despline',
                ),
              ],
            ),
          ),
        ),
      ),
    ]);
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
          if (route != "") {
            Get.toNamed(route, id: 1);
          }
        },
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          Image.asset(
            image,
            width: 48,
            height: 48,
          ),
          const SizedBox(height: 8),
          Text(
            label,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
        ]),
      ),
    );
  }
}
