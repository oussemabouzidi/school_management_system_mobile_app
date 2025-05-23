import 'package:circular_gradient_spinner/circular_gradient_spinner.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:my_app3/services/Services.dart';
import 'dart:convert';
import 'package:my_app3/widgets/language_button.dart';
import 'package:my_app3/widgets/student_card.dart';

class Despline extends StatefulWidget {
  final Function(String month)? onMonthPressed;

  const Despline({
    Key? key,
    this.onMonthPressed,
  }) : super(key: key);

  @override
  State<Despline> createState() => _DesplineState();
}

class _DesplineState extends State<Despline> {
  List<MonthAttendance> attendanceData = [];
  bool isLoading = true;
  String selectedTrimester = "3";
  String selectedYear = "2023/2024";
  int inscriptionId =
      1; // This would typically come from a state management solution

  @override
  void initState() {
    super.initState();
    fetchAttendanceData();
  }

  Future<void> fetchAttendanceData() async {
    setState(() {
      isLoading = true;
    });

    try {
      final response = await http.get(
        Uri.parse(
            "${Service().baseUrl}/attendance/stats/$inscriptionId/$selectedTrimester"),
      );

      if (response.statusCode == 200) {
        final List<dynamic> jsonData = json.decode(response.body);
        setState(() {
          attendanceData =
              jsonData.map((data) => MonthAttendance.fromJson(data)).toList();
          isLoading = false;
        });
      } else {
        setState(() {
          isLoading = false;
        });
        print('Failed to load attendance data: ${response.statusCode}');
      }
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      print('Error fetching attendance data: $e');
    }
  }

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
                        value: selectedTrimester,
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
                        onChanged: (value) {
                          if (value != null) {
                            setState(() {
                              selectedTrimester = value;
                            });
                            fetchAttendanceData();
                          }
                        },
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
                        value: selectedYear,
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
                        onChanged: (value) {
                          if (value != null) {
                            setState(() {
                              selectedYear = value;
                            });
                            // If year selection should affect the API call, update and fetch
                            // Currently the API doesn't seem to use the year parameter directly
                            fetchAttendanceData();
                          }
                        },
                      ),
                    ),
                    SizedBox(width: screenWidth * 0.06),
                    // Language button
                    LanguageButton(),
                  ],
                ),
              ),
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
                    isLoading
                        ? CircularGradientSpinner(
                            color: Colors.blue,
                            size: 50,
                            strokeWidth: 20,
                          )
                        : Column(
                            children: [
                              for (int i = 0; i < attendanceData.length; i++)
                                Padding(
                                  padding: const EdgeInsets.only(bottom: 16),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      // Month button
                                      GestureDetector(
                                          onTap: () => widget.onMonthPressed
                                              ?.call(
                                                  attendanceData[i].monthName),
                                          child: ElevatedButton(
                                            style: ElevatedButton.styleFrom(
                                              elevation: 0,
                                              padding: EdgeInsets.zero,
                                              backgroundColor:
                                                  Colors.transparent,
                                              shadowColor: Colors.transparent,
                                              surfaceTintColor:
                                                  Colors.transparent,
                                              shape: RoundedRectangleBorder(
                                                borderRadius: BorderRadius.zero,
                                              ),
                                            ),
                                            onPressed: () {
                                              Get.toNamed(
                                                  '/menu/despline_mounth',
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
                                                  attendanceData[i].monthName,
                                                  style: const TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 18,
                                                      fontWeight:
                                                          FontWeight.w500),
                                                ),
                                              ),
                                            ),
                                          )),
                                      const SizedBox(width: 12),

                                      // Present count
                                      _buildAttendanceCard(
                                        count: attendanceData[i].presentCount,
                                        label: 'Present',
                                        color: const Color(0xFFAAF0C8),
                                        textColor: const Color(0xFF008000),
                                        icon: "images/present.png",
                                      ),
                                      const SizedBox(width: 12),

                                      // Absent count
                                      _buildAttendanceCard(
                                        count: attendanceData[i].absentCount,
                                        label: 'Absent',
                                        color: const Color(0xFFFFDADA),
                                        textColor: const Color(0xFFFF6B6B),
                                        icon: "images/absent.png",
                                      ),
                                      const SizedBox(width: 12),

                                      // Late count
                                      _buildAttendanceCard(
                                        count: attendanceData[i].retardCount,
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

class MonthAttendance {
  final String month;
  final String presentCount;
  final String absentCount;
  final String retardCount;

  MonthAttendance({
    required this.month,
    required this.presentCount,
    required this.absentCount,
    required this.retardCount,
  });

  String get monthName {
    // Convert YYYY-MM format to abbreviated month name
    final monthNumber = int.tryParse(month.split('-')[1]) ?? 1;
    final monthAbbreviations = [
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'May',
      'Jun',
      'Jul',
      'Aug',
      'Sep',
      'Oct',
      'Nov',
      'Dec'
    ];
    return monthAbbreviations[monthNumber - 1];
  }

  factory MonthAttendance.fromJson(Map<String, dynamic> json) {
    return MonthAttendance(
      month: json['month'] ?? '',
      presentCount: json['present_count'] ?? '0',
      absentCount: json['absent_count'] ?? '0',
      retardCount: json['retard_count'] ?? '0',
    );
  }
}
