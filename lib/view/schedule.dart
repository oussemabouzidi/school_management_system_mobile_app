import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:easy_date_timeline/easy_date_timeline.dart';
import 'package:my_app3/widgets/language_button.dart';
import 'package:my_app3/widgets/student_card.dart';

class Schedule extends StatelessWidget {
  const Schedule({super.key});

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
        Positioned(
          bottom: 128,
          right: 32,
          child: FloatingActionButton(
            onPressed: () {},
            backgroundColor: Color(0xFF12B264),
            shape: CircleBorder(),
            child: Icon(Icons.picture_as_pdf, color: Colors.white),
          ),
        ),
      ],
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
