import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:easy_date_timeline/easy_date_timeline.dart';
import 'package:my_app3/models/ScheduleItem.dart';
import 'package:my_app3/services/Services.dart';
import 'package:my_app3/widgets/language_button.dart';
import 'package:my_app3/widgets/student_card.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ScheduleController extends GetxController {
  var scheduleItems = <ScheduleItem>[].obs;
  var isLoading = true.obs;
  var selectedDate = DateTime.now().obs;
  var selectedTrimester = "3".obs;
  var selectedYear = "2023/2024".obs;

  @override
  void onInit() {
    super.onInit();
    // Set initial date to Tuesday (Mardi) since we know that data exists
    DateTime now = DateTime.now();
    // Find the nearest Tuesday
    int daysUntilTuesday = (DateTime.tuesday - now.weekday) % 7;
    selectedDate.value = now.add(Duration(days: daysUntilTuesday));
    fetchScheduleData();
  }

  // Get day of week in French
  String getDayName(DateTime date) {
    List<String> days = [
      'Dimanche',
      'Lundi',
      'Mardi',
      'Mercredi',
      'Jeudi',
      'Vendredi',
      'Samedi'
    ];
    return days[date.weekday % 7];
  }

  // Add error handling for API responses
  void handleApiError(String message) {
    // You can extend this to show a proper error dialog or snackbar
    print(message);
    Get.snackbar(
      'Erreur',
      'Impossible de charger l\'emploi du temps. Affichage des données en mode hors ligne.',
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.red[100],
      colorText: Colors.red[800],
      duration: Duration(seconds: 5),
    );
  }

  void fetchScheduleData() async {
    isLoading.value = true;

    try {
      // Get the day name for filtering
      String dayName = getDayName(selectedDate.value);

      // Try making direct connection to the API endpoint with full URL
      String apiUrl =
          '${Service().baseUrl}/emploi-du-temps_filtrer?eleve_id=1&day=$dayName';

      try {
        // Try HTTPS first with short timeout
        final httpsResponse = await http.get(
          Uri.parse(apiUrl),
          headers: {'Accept': 'application/json'},
        ).timeout(const Duration(seconds: 5));

        if (httpsResponse.statusCode == 200) {
          List<dynamic> data = json.decode(httpsResponse.body);
          scheduleItems.value =
              data.map((item) => ScheduleItem.fromJson(item)).toList();
          print(
              'Successfully loaded ${scheduleItems.length} schedule items via HTTPS');
          return; // Exit the function if HTTPS succeeds
        }
      } catch (httpsError) {
        print('HTTPS connection failed: $httpsError.');
        // Continue to HTTP attempt
      }

      // For testing, or if both HTTP and HTTPS failed, use mock data
    } catch (e) {
      // In case of any other error, use mock data
      handleApiError('Erreur de connexion: $e');
    } finally {
      isLoading.value = false;
    }
  }

  // Helper method to get the right base URL for API calls
  String getProperBaseUrl() {
    // The URL needs to be different depending on where the app is running

    // For Android emulator reaching localhost server
    if (GetPlatform.isAndroid) {
      return 'http://10.0.2.2:8000'; // Android emulator special IP for host machine
    }

    // For iOS simulator reaching localhost server
    if (GetPlatform.isIOS) {
      return 'http://127.0.0.1:8000'; // Works for iOS simulator
    }

    // For physical devices or web testing
    // NOTE: This won't work with a local server unless on same network
    // You'll need to replace this with your actual server IP/domain when testing on physical devices
    return 'http://127.0.0.1:8000';
  }

  List<ScheduleItem> getFilteredSchedule() {
    String dayName = getDayName(selectedDate.value);
    // Filter by day
    var filtered = scheduleItems.where((item) => item.jour == dayName).toList();

    // Log for debugging
    print('Filtered schedule for $dayName: found ${filtered.length} items');

    return filtered;
  }

  void updateSelectedDate(DateTime date) {
    selectedDate.value = date;
    // Refetch data when date changes
    fetchScheduleData();
  }

  void updateSelectedTrimester(String value) {
    selectedTrimester.value = value;
    // Fetch new data based on trimester
    fetchScheduleData();
  }

  void updateSelectedYear(String value) {
    selectedYear.value = value;
    // Fetch new data based on year
    fetchScheduleData();
  }

  // Function to get a unique color for each subject
  Color getSubjectColor(String subject) {
    // Simple hash function to generate consistent colors for subjects
    int hash = subject.hashCode;

    // List of predefined colors
    List<Color> colors = [
      Colors.indigo,
      Colors.cyan,
      Colors.orange,
      Colors.green,
      Colors.deepPurple,
      Colors.amber[700]!,
      Colors.teal,
      Colors.pink,
    ];

    return colors[hash.abs() % colors.length];
  }
}

class Schedule extends StatelessWidget {
  const Schedule({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ScheduleController());
    final screenWidth = MediaQuery.of(context).size.width;

    return Stack(
      children: [
        Obx(() => ListView(
              children: [
                // Top Bar
                Container(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 8.0, vertical: 16.0),
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
                            child:
                                Icon(Icons.arrow_back, color: Colors.black54),
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
                            value: controller.selectedTrimester.value,
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
                              if (value != null)
                                controller.updateSelectedTrimester(value);
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
                            value: controller.selectedYear.value,
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
                              if (value != null)
                                controller.updateSelectedYear(value);
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
                          initialDate: controller.selectedDate.value,
                          onDateChange: (selectedDate) {
                            controller.updateSelectedDate(selectedDate);
                          },
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
                                color: Color.fromARGB(255, 89, 139, 255),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 30),
                        controller.isLoading.value
                            ? Center(child: CircularProgressIndicator())
                            : Column(
                                children: _buildScheduleItems(controller),
                              ),
                      ],
                    ),
                  ),
                ),
              ],
            )),
        Positioned(
          bottom: 128,
          right: 32,
          child: FloatingActionButton(
            onPressed: () {
              // Add PDF export functionality
            },
            backgroundColor: Color(0xFF12B264),
            shape: CircleBorder(),
            child: Icon(Icons.picture_as_pdf, color: Colors.white),
          ),
        ),
      ],
    );
  }

  List<Widget> _buildScheduleItems(ScheduleController controller) {
    List<ScheduleItem> filteredItems = controller.getFilteredSchedule();

    if (filteredItems.isEmpty) {
      return [
        Center(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Text(
              "Aucun cours pour ce jour",
              style: TextStyle(fontSize: 16, fontStyle: FontStyle.italic),
            ),
          ),
        )
      ];
    }

    // Sort by start time
    filteredItems.sort((a, b) => a.seanceDebut.compareTo(b.seanceDebut));

    List<Widget> scheduleWidgets = [];

    for (var i = 0; i < filteredItems.length; i++) {
      final item = filteredItems[i];

      // Add a class item
      scheduleWidgets.add(
        ClassItem(
          time: item.seanceDebut,
          endTime: item.seanceFin,
          subject: item.nomMatiereFr.toUpperCase(),
          teacher: "${item.enseignantNom} ${item.enseignantPrenom}",
          room: item.salle,
          color: controller.getSubjectColor(item.nomMatiereFr),
        ),
      );

      // Add spacing between items
      if (i < filteredItems.length - 1) {
        // Check if there's a gap between classes that could be a break
        DateTime currentEnd = _parseTime(item.seanceFin);
        DateTime nextStart = _parseTime(filteredItems[i + 1].seanceDebut);

        // Calculate minutes between classes
        int minutesDifference = nextStart.difference(currentEnd).inMinutes;

        // If gap is greater than 15 minutes, add a break item
        if (minutesDifference >= 15) {
          scheduleWidgets.add(const SizedBox(height: 12));
          scheduleWidgets.add(
            BreakItem(
              time: item.seanceFin,
              endTime: filteredItems[i + 1].seanceDebut,
              minutesDuration: minutesDifference,
            ),
          );
        }

        scheduleWidgets.add(const SizedBox(height: 12));
      }
    }

    return scheduleWidgets;
  }

  // Helper method to parse time string into DateTime
  DateTime _parseTime(String timeString) {
    final parts = timeString.split(':');
    return DateTime(
      2000,
      1,
      1,
      int.parse(parts[0]),
      int.parse(parts[1]),
    );
  }
}

class ClassItem extends StatelessWidget {
  final String time;
  final String endTime;
  final String subject;
  final String teacher;
  final String room;
  final Color color;

  const ClassItem({
    required this.time,
    required this.endTime,
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
          width: 50,
          child: Column(
            children: [
              Text(
                time,
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Text(
                endTime,
                style: TextStyle(
                  fontSize: 10,
                  color: Colors.grey,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ],
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
  final String endTime;
  final int minutesDuration;

  const BreakItem({
    required this.time,
    required this.endTime,
    required this.minutesDuration,
  });

  @override
  Widget build(BuildContext context) {
    // Choose appropriate break icon based on duration
    IconData breakIcon = minutesDuration > 60 ? Icons.restaurant : Icons.coffee;
    String breakText = minutesDuration > 60 ? "Pause déjeuner" : "Pause";

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 50,
          child: Column(
            children: [
              Text(
                time,
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Text(
                endTime,
                style: TextStyle(
                  fontSize: 10,
                  color: Colors.grey,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ],
          ),
        ),
        Container(
          width: 4,
          height: 30,
          color: Colors.grey[400],
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Row(
            children: [
              Icon(
                breakIcon,
                color: Colors.grey[600],
                size: 20,
              ),
              SizedBox(width: 8),
              Text(
                breakText,
                style: TextStyle(
                  fontSize: 12,
                  fontStyle: FontStyle.italic,
                  color: Colors.grey[600],
                ),
              ),
              SizedBox(width: 4),
              Text(
                "$minutesDuration min",
                style: TextStyle(
                  fontSize: 10,
                  color: Colors.grey[500],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
