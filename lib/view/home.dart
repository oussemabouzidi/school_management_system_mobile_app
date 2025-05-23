import 'package:flutter/material.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:get/get.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:intl/intl.dart';
import 'package:my_app3/controller/wrappercontroller.dart';
import 'package:my_app3/models/Devoir.dart';
import 'package:my_app3/models/LastNotes.dart';
import 'package:my_app3/services/Services.dart';
import 'package:my_app3/shared/SharedPrefsService.dart';
import 'package:my_app3/widgets/language_button.dart';
import 'package:my_app3/widgets/logout_button.dart';
import 'package:my_app3/widgets/notification_button.dart';
import 'package:my_app3/widgets/presence_card.dart';
import 'package:my_app3/widgets/student_card.dart';
import 'package:my_app3/view/wrapper.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);
  @override
  State<Home> createState() => HomeState();
}

class HomeState extends State<Home> {
  late List<Lastnotes> grades = [];
  late Devoir latest_devoir;
  late String date_formated;
  //late String mois_formated;
  Service service = Service();

  bool _showChatbotTooltip = true;
  bool _isExpanded = false;
  int _animationCount = 0;
  late var role;

  void _getGrades() async {
    grades = await service.getLastNotes();
  }

  void _getDevoirInfo() async {
    latest_devoir = await service.getLastsDevoir();

    String originalDate = latest_devoir.date_test;

    // Parse the string into a DateTime object
    DateTime date = DateTime.parse(originalDate);

    // Format to "dd-MM"
    String formatted = DateFormat('dd-MM').format(date);
    date_formated = formatted;
    print(date_formated);

    // Format to abbreviated month in French (e.g., janv, févr, mars)
    String shortMonth = DateFormat.MMM('fr_FR').format(date);
    /*mois_formated = shortMonth;
    print(mois_formated);*/
  }

  void _startTooltipTimer() {
    setState(() {
      _showChatbotTooltip = true;
    });
    Future.delayed(Duration(seconds: 5), () {
      if (mounted) {
        setState(() {
          _showChatbotTooltip = false;
        });
      }
    });
  }

  void resetTooltip() {
    _startTooltipTimer();
    _animationCount = 0;
    _startAnimation();
  }

  void _startAnimation() async {
    _animationCount = 0; // make sure to reset counter when starting

    while (_animationCount < 4) {
      await Future.delayed(Duration(milliseconds: 500));
      if (!mounted) return;
      setState(() {
        _isExpanded = !_isExpanded;
        _animationCount++;
      });
    }

    // After animation is finished, reset to natural (not expanded) state
    if (mounted) {
      setState(() {
        _isExpanded = false;
      });
    }
  }

  void _loadUserRole() async {
    role = await SharedPrefsService.getUserRole();
    // If needed, call setState to update UI
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    _startTooltipTimer();
    _startAnimation();
    _loadUserRole();
    _getGrades();
    _getDevoirInfo();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 12, horizontal: 4),
      child: Stack(
        children: [
          ListView(
            //padding: EdgeInsets.all(16.0),
            children: [
              // Top navigation row with language, trimester, year, and logout
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16.0),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Language button
                    LanguageButton(),
                    // Notification button with badge
                    NotificationButton(
                      notificationService: Service(),
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
                    LogoutButton()
                  ],
                ),
              ),

              SizedBox(height: 16),

              // User profile card
              StudentCard(),
              SizedBox(height: 24),

              Padding(
                padding: EdgeInsets.symmetric(horizontal: 12),
                child: Column(
                  children: [
                    if (role == 'eleve')
                      // presence screen
                      PresenceCard(),

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
                                HugeIcon(
                                    icon: HugeIcons.strokeRoundedNote,
                                    color: Color(0xFF559DFF)),
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
                                    children: [
                                      Text(
                                        date_formated,
                                        style: const TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold,
                                          color: Color(0xFF559DFF),
                                        ),
                                      ),
                                      /*Text(
                                        mois_formated,
                                        style: TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.w500,
                                          color: Color(0xFF559DFF),
                                        ),
                                      ),*/
                                    ],
                                  ),
                                ),
                                SizedBox(width: 16),
                                // Test details
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        latest_devoir.matiere,
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                          color: Color(0xFF2D3142),
                                        ),
                                      ),
                                      SizedBox(height: 4),
                                      Text(
                                        "${latest_devoir.enseignant_nom}, ${latest_devoir.enseignant_prenom}",
                                        style: TextStyle(
                                          fontSize: 14,
                                          color: Color(0xFF2D3142),
                                        ),
                                      ),
                                      SizedBox(height: 4),
                                      Text(
                                        '${latest_devoir.date_test}, ${latest_devoir.heure}',
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
                                            latest_devoir.salle,
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
                                HugeIcon(
                                    icon: HugeIcons
                                        .strokeRoundedDocumentValidation,
                                    color: Color(0xFF559DFF)),
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
                          ...grades
                              .map((grade) => _buildGradeItem(grade))
                              .toList(),
                        ],
                      ),
                    ),

                    SizedBox(height: 90),
                  ],
                ) // Extra space for the bottom navigation
                ,
              )
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

                AnimatedContainer(
                  duration: Duration(seconds: 1),
                  curve: Curves.easeInOut,
                  margin: _isExpanded
                      ? EdgeInsets.only(bottom: 70, right: 5)
                      : EdgeInsets.only(bottom: 0, right: 5),
                  padding: _isExpanded
                      ? EdgeInsets.symmetric(horizontal: 0, vertical: 5)
                      : EdgeInsets.symmetric(horizontal: 0, vertical: 5),
                  child:
                      // Floating button
                      FloatingActionButton(
                    onPressed: () {
                      setState(() {
                        _showChatbotTooltip = false;
                      });
                      Navigator.of(context).pushReplacement(
                        MaterialPageRoute(
                            builder: (context) =>
                                Wrapper(initialIndex: 1)), // chatbot
                      );
                    },
                    backgroundColor: const Color(0xFF559DFF).withOpacity(0.1),
                    shape: const CircleBorder(),
                    child: Image.asset(
                      "images/bot.png",
                      width: 70,
                      height: 70,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

Widget _buildGradeItem(Lastnotes grade) {
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
                grade.subject,
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
                    grade.date,
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
            "${grade.grade}",
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
      child: ElevatedButton(
        onPressed: () {
          final WrapperController wrapperController = Get.find();
          switch (label) {
            case "Emploi du temps":
              wrapperController.changePage(2); // Switch to the "Menu" tab
              Future.delayed(Duration(milliseconds: 100), () {
                Get.toNamed('/menu/schedule', id: 1);
              });
              break;
            case "Assignment":
              wrapperController.changePage(2); // Switch to the "Menu" tab
              Future.delayed(Duration(milliseconds: 100), () {
                Get.toNamed('/menu/homework', id: 1);
              });
              break;
            case "Mes livres":
              wrapperController.changePage(2); // Switch to the "Menu" tab
              Future.delayed(Duration(milliseconds: 100), () {
                Get.toNamed('/menu/livres', id: 1);
              });
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
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
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
            Text(
              label,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.bold,
                color: Color(0xFF2D3142),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
