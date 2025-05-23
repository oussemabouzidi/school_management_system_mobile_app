import 'package:circular_gradient_spinner/circular_gradient_spinner.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:intl/intl.dart';
import 'package:my_app3/services/Services.dart';
import 'package:my_app3/widgets/notification_button.dart';
import 'package:my_app3/widgets/student_card.dart';
import 'package:table_calendar/table_calendar.dart';

class Despline2 extends StatefulWidget {
  final String? month;
  final int? year;

  const Despline2({
    Key? key,
    this.month,
    this.year,
  }) : super(key: key);

  @override
  _Despline2State createState() => _Despline2State();
}

class _Despline2State extends State<Despline2> {
  Map<DateTime, String> _attendanceData = {};
  List<AttendanceRecord> _recentAttendance = [];

  bool isLoading = true;
  int presentCount = 0;
  int absentCount = 0;
  int retardCount = 0;

  // Month and year state management
  late DateTime _focusedDay;
  DateTime? _selectedDay;
  String selectedMonth = "January"; // Default value
  String selectedYear = "2025"; // Default value

  final Map<String, int> monthToNum = {
    "January": 1,
    "February": 2,
    "March": 3,
    "April": 4,
    "May": 5,
    "June": 6,
    "July": 7,
    "August": 8,
    "September": 9,
    "October": 10,
    "November": 11,
    "December": 12
  };

  final List<String> monthNames = [
    "January",
    "February",
    "March",
    "April",
    "May",
    "June",
    "July",
    "August",
    "September",
    "October",
    "November",
    "December"
  ];

  @override
  void initState() {
    super.initState();

    // Initialize month/year based on parameters if provided
    if (widget.month != null) {
      // Convert month abbreviation to full name
      final Map<String, String> monthAbbrevToFull = {
        'Jan': 'January',
        'Feb': 'February',
        'Mar': 'March',
        'Apr': 'April',
        'May': 'May',
        'Jun': 'June',
        'Jul': 'July',
        'Aug': 'August',
        'Sep': 'September',
        'Oct': 'October',
        'Nov': 'November',
        'Dec': 'December'
      };

      selectedMonth = monthAbbrevToFull[widget.month] ?? 'January';
    }

    if (widget.year != null) {
      selectedYear = widget.year.toString();
    }

    // Set the focused day based on selected month and year
    final monthNum = monthToNum[selectedMonth] ?? 1;
    final yearNum = int.tryParse(selectedYear) ?? 2025;

    _focusedDay = DateTime.utc(yearNum, monthNum, 1);
    _selectedDay = _focusedDay;

    fetchAttendanceData();
  }

  // Fetch attendance data from API
  Future<void> fetchAttendanceData() async {
    setState(() {
      isLoading = true;
    });

    try {
      // Get month calendar data (this would ideally come from an API endpoint per month)
      await fetchMonthAttendance();

      // Get recent attendance records
      await fetchRecentAttendance();

      setState(() {
        isLoading = false;
      });
    } catch (e) {
      print('Error fetching attendance data: $e');
      setState(() {
        isLoading = false;
      });
    }
  }

  // Fetch month calendar data (in a real app, this would come from a dedicated API)
  Future<void> fetchMonthAttendance() async {
    // In a real app, you'd have an API endpoint to get all attendance for a specific month
    // For now, we'll simulate this with random data for the month

    final monthNum = monthToNum[selectedMonth] ?? 1;
    final yearNum = int.tryParse(selectedYear) ?? 2025;

    // Clear previous data
    _attendanceData = {};
    presentCount = 0;
    absentCount = 0;
    retardCount = 0;

    // For demo, let's create some attendance data for the current month
    // In a real app, replace this with API call data
    final daysInMonth = DateTime(yearNum, monthNum + 1, 0).day;
    //final random = DateTime.now().millisecondsSinceEpoch % 3;

    // Create a set of weekdays (1-5, Monday to Friday) in the month
    for (int day = 1; day <= daysInMonth; day++) {
      final date = DateTime.utc(yearNum, monthNum, day);

      // Skip weekends
      if (date.weekday > 5) continue;

      // Assign status (this would come from API in real app)
      // For demo purposes, we'll create a pattern
      String status;
      if (day % 10 == 3 || day % 10 == 6) {
        status = 'Absent';
        absentCount++;
      } else if (day % 7 == 2 || day % 7 == 5) {
        status = 'Retard';
        retardCount++;
      } else {
        status = 'Present';
        presentCount++;
      }

      _attendanceData[date] = status;
    }
  }

  // Fetch recent attendance records
  Future<void> fetchRecentAttendance() async {
    try {
      final int inscriptionId =
          1; // This would typically come from state management
      final response = await http.get(
        Uri.parse("${Service().baseUrl}/api/attendance/lasts/$inscriptionId"),
      );

      if (response.statusCode == 200) {
        final List<dynamic> jsonData = json.decode(response.body);

        setState(() {
          _recentAttendance = jsonData.map((record) {
            // Parse the date
            final date = DateTime.parse(record['date_session']);
            final formattedDate = DateFormat('MMMM d, yyyy').format(date);

            // Map the status and set appropriate colors
            String status = 'Unknown';
            Color statusColor = Colors.grey;
            Color bgColor = Colors.grey.withOpacity(0.3);

            switch (record['etat'].toString().toLowerCase()) {
              case 'present':
                status = 'Present';
                statusColor = Color(0xFF008000);
                bgColor = Color(0xFFAAF0C8).withOpacity(0.3);
                break;
              case 'absent':
                status = 'Absent';
                statusColor = Color(0xFFFF6B6B);
                bgColor = Color(0xFFFFDADA).withOpacity(0.3);
                break;
              case 'retard':
                status = 'Retard';
                statusColor = Color(0xFF4A86E8);
                bgColor = Color(0xFFCCE6FF).withOpacity(0.3);
                break;
            }

            return AttendanceRecord(
              date: formattedDate,
              status: status,
              statusColor: statusColor,
              bgColor: bgColor,
            );
          }).toList();
        });
      } else {
        print('Failed to load recent attendance: ${response.statusCode}');
      }
    } catch (e) {
      print('Error fetching recent attendance: $e');
    }
  }

  // Get event list for a day
  List<String> _getEventsForDay(DateTime day) {
    final normalizedDay = DateTime.utc(day.year, day.month, day.day);
    final status = _attendanceData[normalizedDay];
    return status != null ? [status] : [];
  }

  // Update month and refetch data
  void _updateMonth(String month) {
    setState(() {
      selectedMonth = month;
      final monthNum = monthToNum[month] ?? 1;
      final yearNum = int.tryParse(selectedYear) ?? 2025;
      _focusedDay = DateTime.utc(yearNum, monthNum, 1);
    });
    fetchAttendanceData();
  }

  // Update year and refetch data
  void _updateYear(String year) {
    setState(() {
      selectedYear = year;
      final monthNum = monthToNum[selectedMonth] ?? 1;
      final yearNum = int.tryParse(year) ?? 2025;
      _focusedDay = DateTime.utc(yearNum, monthNum, 1);
    });
    fetchAttendanceData();
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        // Header section with filters
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 16.0),
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
                  value: selectedMonth,
                  underline: Container(),
                  icon: const Icon(Icons.arrow_drop_down),
                  items: monthNames.map((String month) {
                    return DropdownMenuItem<String>(
                      value: month,
                      child: Text(month),
                    );
                  }).toList(),
                  onChanged: (value) {
                    if (value != null) {
                      _updateMonth(value);
                    }
                  },
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
                  value: selectedYear,
                  underline: Container(),
                  icon: const Icon(Icons.arrow_drop_down),
                  items: [
                    DropdownMenuItem(value: "2025", child: Text("2025")),
                    DropdownMenuItem(value: "2024", child: Text("2024")),
                    DropdownMenuItem(value: "2023", child: Text("2023")),
                  ],
                  onChanged: (value) {
                    if (value != null) {
                      _updateYear(value);
                    }
                  },
                ),
              ),
              const SizedBox(width: 8),

              // Notifications
              NotificationButton(
                notificationService: Service(),
              )
            ],
          ),
        ),

        // Student profile card
        StudentCard(),

        // Calendar with attendance markers
        if (isLoading)
          CircularGradientSpinner(
            color: Colors.blue,
            size: 50,
            strokeWidth: 20,
          )
        else
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
                    firstDay: DateTime.utc(int.parse(selectedYear) - 1, 1, 1),
                    lastDay: DateTime.utc(int.parse(selectedYear) + 1, 12, 31),
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
                      // Update month/year dropdowns when calendar page changes
                      setState(() {
                        _focusedDay = focusedDay;
                        selectedMonth = monthNames[focusedDay.month - 1];
                        selectedYear = focusedDay.year.toString();
                      });
                      fetchAttendanceData();
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
                      markerMargin: const EdgeInsets.symmetric(horizontal: 0.5),
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
                      Text(
                        presentCount.toString(),
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
                      Text(
                        absentCount.toString(),
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

              // Retard count
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
                      Text(
                        retardCount.toString(),
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
              if (isLoading)
                CircularGradientSpinner(
                  color: Colors.blue,
                  size: 50,
                  strokeWidth: 20,
                )
              else if (_recentAttendance.isEmpty)
                Center(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Text(
                      "Aucun enregistrement trouvé",
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 16,
                      ),
                    ),
                  ),
                )
              else
                Column(
                  children: _recentAttendance.map((record) {
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 8.0),
                      child: record,
                    );
                  }).toList(),
                ),
            ],
          ),
        ),
      ],
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
