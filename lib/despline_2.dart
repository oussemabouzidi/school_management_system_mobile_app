import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:crystal_navigation_bar/crystal_navigation_bar.dart';
import 'package:iconly/iconly.dart';
import 'package:badges/badges.dart' as badges;
import 'package:table_calendar/table_calendar.dart';

class Despline2 extends StatefulWidget {
  @override
  _Despline2State createState() => _Despline2State();
}

class _Despline2State extends State<Despline2> {
  // Sample attendance data - Map of dates to attendance status
  final Map<DateTime, String> _attendanceData = {
    DateTime.utc(2025, 1, 5): 'Present',
    DateTime.utc(2025, 1, 7): 'Present',
    DateTime.utc(2025, 1, 10): 'Present',
    DateTime.utc(2025, 1, 12): 'Present',
    DateTime.utc(2025, 1, 15): 'Present',
    DateTime.utc(2025, 1, 17): 'Present',
    DateTime.utc(2025, 1, 19): 'Present',
    DateTime.utc(2025, 1, 22): 'Present',
    DateTime.utc(2025, 1, 24): 'Present',
    DateTime.utc(2025, 1, 3): 'Absent',
    DateTime.utc(2025, 1, 14): 'Absent',
    DateTime.utc(2025, 1, 28): 'Absent',
    DateTime.utc(2025, 1, 8): 'Retard',
    DateTime.utc(2025, 1, 21): 'Retard',
  };

  DateTime _focusedDay = DateTime.utc(
    2025,
    1,
  );
  DateTime? _selectedDay;

  @override
  void initState() {
    super.initState();
    _selectedDay = _focusedDay;
  }

  // Get event list for a day
  List<String> _getEventsForDay(DateTime day) {
    final normalizedDay = DateTime.utc(day.year, day.month, day.day);
    final status = _attendanceData[normalizedDay];
    return status != null ? [status] : [];
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Color(0xFFE8F0FE),
        extendBody: true,
        body: ListView(
          children: [
            // Header section with filters
            Container(
              padding:
                  const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16.0),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                  const SizedBox(width: 8),

                  // Month dropdown
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: DropdownButton<String>(
                      value: "January",
                      underline: Container(),
                      icon: const Icon(Icons.arrow_drop_down),
                      items: const [
                        DropdownMenuItem(
                          value: "January",
                          child: Text("January"),
                        ),
                        DropdownMenuItem(
                          value: "February",
                          child: Text("February"),
                        ),
                        DropdownMenuItem(
                          value: "March",
                          child: Text("March"),
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
                      value: "2025",
                      underline: Container(),
                      icon: const Icon(Icons.arrow_drop_down),
                      items: const [
                        DropdownMenuItem(
                          value: "2025",
                          child: Text("2025"),
                        ),
                        DropdownMenuItem(
                          value: "2024",
                          child: Text("2024"),
                        ),
                      ],
                      onChanged: (value) {},
                    ),
                  ),
                  const SizedBox(width: 8),

                  // Notifications
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
                                    style: TextStyle(color: Colors.red[400]),
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
                          size: 24.0,
                          color: Colors.grey[700]!,
                        ),
                        padding: EdgeInsets.zero,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // Student profile card
            Container(
              width: double.infinity,
              margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
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
                      clipBehavior: Clip.antiAlias,
                      child: Image.asset("images/student.png"),
                    ),
                  ],
                ),
              ),
            ),

            // Calendar with attendance markers
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(24),
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
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    TableCalendar(
                      firstDay: DateTime.utc(2025, 1, 1),
                      lastDay: DateTime.utc(2025, 12, 31),
                      focusedDay: _focusedDay,
                      selectedDayPredicate: (day) {
                        return isSameDay(_selectedDay, day);
                      },
                      onDaySelected: (selectedDay, focusedDay) {
                        setState(() {
                          _selectedDay = selectedDay;
                          _focusedDay = focusedDay;
                        });
                      },
                      onPageChanged: (focusedDay) {
                        _focusedDay = focusedDay;
                      },
                      eventLoader: _getEventsForDay,
                      calendarStyle: CalendarStyle(
                        todayDecoration: BoxDecoration(
                          color: Color(0xFF4A86E8).withOpacity(0.7),
                          shape: BoxShape.circle,
                        ),
                        selectedDecoration: BoxDecoration(
                          color: Color(0xFF4A86E8),
                          shape: BoxShape.circle,
                        ),
                        markersMaxCount: 1,
                        markerDecoration: BoxDecoration(
                          color: Colors.transparent,
                          shape: BoxShape.circle,
                        ),
                        markerSize: 8,
                        markerMargin:
                            const EdgeInsets.symmetric(horizontal: 0.5),
                      ),
                      headerStyle: HeaderStyle(
                        formatButtonVisible: false,
                        titleCentered: true,
                      ),
                      calendarBuilders: CalendarBuilders(
                        markerBuilder: (context, date, events) {
                          if (events.isEmpty) return null;

                          final status = events.first as String;
                          Color markerColor;

                          switch (status) {
                            case 'Present':
                              markerColor = Color(0xFF008000);
                              break;
                            case 'Absent':
                              markerColor = Color(0xFFFF6B6B);
                              break;
                            case 'Retard':
                              markerColor = Color(0xFF4A86E8);
                              break;
                            default:
                              markerColor = Colors.grey;
                          }

                          return Positioned(
                            bottom: 1,
                            child: Container(
                              width: 35,
                              height: 35,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: markerColor.withOpacity(0.3),
                                border: Border.all(
                                  color: markerColor,
                                  width: 1.5,
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),

                    // Calendar legend
                    Padding(
                      padding: const EdgeInsets.only(top: 16.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          _buildLegendItem('Present', Color(0xFF008000)),
                          SizedBox(width: 16),
                          _buildLegendItem('Absent', Color(0xFFFF6B6B)),
                          SizedBox(width: 16),
                          _buildLegendItem('Retard', Color(0xFF4A86E8)),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // Statistics Section
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Present count
                  Expanded(
                    child: Container(
                      height: 100,
                      decoration: BoxDecoration(
                        color: const Color(0xFFAAF0C8),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            '23',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 24,
                              color: Color(0xFF008000),
                            ),
                          ),
                          const SizedBox(height: 4),
                          const Text(
                            'Present',
                            style: TextStyle(
                              fontSize: 14,
                              color: Color(0xFF008000),
                            ),
                          ),
                          Image.asset(
                            "images/present.png",
                            width: 30,
                            height: 30,
                          )
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),

                  // Absent count
                  Expanded(
                    child: Container(
                      height: 100,
                      decoration: BoxDecoration(
                        color: const Color(0xFFFFDADA),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            '3',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 24,
                              color: Color(0xFFFF6B6B),
                            ),
                          ),
                          const SizedBox(height: 4),
                          const Text(
                            'Absent',
                            style: TextStyle(
                              fontSize: 14,
                              color: Color(0xFFFF6B6B),
                            ),
                          ),
                          Image.asset(
                            "images/absent.png",
                            width: 30,
                            height: 30,
                          )
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),

                  // Excused count
                  Expanded(
                    child: Container(
                      height: 100,
                      decoration: BoxDecoration(
                        color: const Color(0xFFCCE6FF),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            '2',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 24,
                              color: Color(0xFF4A86E8),
                            ),
                          ),
                          const SizedBox(height: 4),
                          const Text(
                            'Retard',
                            style: TextStyle(
                              fontSize: 14,
                              color: Color(0xFF4A86E8),
                            ),
                          ),
                          Image.asset(
                            "images/late.png",
                            width: 30,
                            height: 30,
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // Recent Attendance Records
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(24),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 10,
                    spreadRadius: 0,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Enregistrements récents",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF2D3142),
                    ),
                  ),
                  SizedBox(height: 12),

                  // Attendance records list
                  AttendanceRecord(
                    date: "April 10, 2025",
                    status: "Present",
                    statusColor: Color(0xFF008000),
                    bgColor: Color(0xFFAAF0C8).withOpacity(0.3),
                  ),
                  SizedBox(height: 8),
                  AttendanceRecord(
                    date: "April 9, 2025",
                    status: "Present",
                    statusColor: Color(0xFF008000),
                    bgColor: Color(0xFFAAF0C8).withOpacity(0.3),
                  ),
                  SizedBox(height: 8),
                  AttendanceRecord(
                    date: "April 8, 2025",
                    status: "Absent",
                    statusColor: Color(0xFFFF6B6B),
                    bgColor: Color(0xFFFFDADA).withOpacity(0.3),
                  ),
                  SizedBox(height: 8),
                  AttendanceRecord(
                    date: "April 7, 2025",
                    status: "Retard",
                    statusColor: Color(0xFF4A86E8),
                    bgColor: Color(0xFFCCE6FF).withOpacity(0.3),
                  ),
                ],
              ),
            ),
          ],
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

  // Helper method to build legend items
  Widget _buildLegendItem(String label, Color color) {
    return Row(
      children: [
        Container(
          width: 16,
          height: 16,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: color.withOpacity(0.3),
            border: Border.all(
              color: color,
              width: 1.5,
            ),
          ),
        ),
        SizedBox(width: 4),
        Text(
          label,
          style: TextStyle(
            fontSize: 12,
            color: color,
          ),
        ),
      ],
    );
  }
}

// Custom widget for attendance records
class AttendanceRecord extends StatelessWidget {
  final String date;
  final String status;
  final Color statusColor;
  final Color bgColor;

  const AttendanceRecord({
    Key? key,
    required this.date,
    required this.status,
    required this.statusColor,
    required this.bgColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            date,
            style: TextStyle(
              fontSize: 16,
              color: Color(0xFF2D3142),
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Text(
              status,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: statusColor,
              ),
            ),
          ),
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
