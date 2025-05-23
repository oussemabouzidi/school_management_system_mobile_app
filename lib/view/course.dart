import 'package:circular_gradient_spinner/circular_gradient_spinner.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_app3/controller/course_controller.dart';
import 'package:my_app3/models/Course.dart';
import 'package:my_app3/widgets/language_button.dart';
import 'package:intl/intl.dart';

class CourseScreen extends StatefulWidget {
  final Map<String, dynamic>? arguments;

  const CourseScreen({Key? key, this.arguments}) : super(key: key);

  @override
  _CourseScreenState createState() => _CourseScreenState();
}

class _CourseScreenState extends State<CourseScreen> {
  final CourseController _courseController = Get.put(CourseController());
  late final String idMatiere;

  @override
  void initState() {
    super.initState();
    final args = widget.arguments;

    if (args != null && args['id'] != null) {
      idMatiere = args['id'];
      // Fetch course data using the matiere ID
      _courseController.fetchData(int.parse(idMatiere));
    } else {
      print("No argument passed!!!");
    }
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        Column(
          children: [
            // Top navigation bar
            Container(
              padding:
                  const EdgeInsets.symmetric(horizontal: 8.0, vertical: 16.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16.0),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Back button
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
                  const Text(
                    "Contenu du cours",
                    style: TextStyle(
                      color: Colors.blue,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  // Language button
                  LanguageButton(),
                ],
              ),
            ),
            SizedBox(height: 20),

            // Course content
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Obx(() {
                if (_courseController.isLoading.value) {
                  return Center(
                    child: CircularGradientSpinner(
                      color: Colors.blue,
                      size: 50,
                      strokeWidth: 20,
                    ),
                  );
                } else if (_courseController.hasError.value) {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                            'Error loading course: ${_courseController.errorMessage.value}'),
                        SizedBox(height: 16),
                        ElevatedButton(
                          onPressed: () =>
                              _courseController.fetchData(int.parse(idMatiere)),
                          child: Text('Retry'),
                        ),
                      ],
                    ),
                  );
                } else {
                  // Access course data through _courseController._course.value
                  return _buildCourseContent(_courseController.course.value);
                }
              }),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildCourseContent(Course course) {
    // Format the date
    DateTime createdDate = DateTime.parse(course.created_at);
    String formattedDate = DateFormat('EEEE d MMMM yyyy').format(createdDate);

    return Column(
      children: [
        // Course Title Card
        Container(
          width: double.infinity,
          padding: EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: Colors.blue.withOpacity(0.1),
                spreadRadius: 1,
                blurRadius: 5,
                offset: Offset(0, 2),
              ),
            ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  course.title,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.blue.shade800,
                  ),
                ),
              ),
              Image.asset(
                "images/course/course.png",
                width: 80,
                height: 80,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    width: 80,
                    height: 80,
                    decoration: BoxDecoration(
                      color: Colors.blue.shade100,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Icon(
                      Icons.book,
                      size: 40,
                      color: Colors.blue.shade800,
                    ),
                  );
                },
              ),
            ],
          ),
        ),
        SizedBox(height: 16),

        // Course Info Card
        Container(
          width: double.infinity,
          padding: EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: Colors.blue.withOpacity(0.1),
                spreadRadius: 1,
                blurRadius: 5,
                offset: Offset(0, 2),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Type
              Row(
                children: [
                  Icon(Icons.category, color: Colors.blue, size: 24),
                  SizedBox(width: 8),
                  Text(
                    'Type: ',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  Text(
                    course.type,
                    style: TextStyle(fontSize: 16),
                  ),
                ],
              ),
              SizedBox(height: 12),

              // Week
              Row(
                children: [
                  Icon(Icons.calendar_today, color: Colors.blue, size: 24),
                  SizedBox(width: 8),
                  Text(
                    'Semaine: ',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  Text(
                    course.week.toString(),
                    style: TextStyle(fontSize: 16),
                  ),
                ],
              ),
              SizedBox(height: 12),

              // Created Date
              Row(
                children: [
                  Icon(Icons.date_range, color: Colors.blue, size: 24),
                  SizedBox(width: 8),
                  Text(
                    'Créé le: ',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  Text(
                    formattedDate,
                    style: TextStyle(fontSize: 16),
                  ),
                ],
              ),
              SizedBox(height: 16),

              // Course Details
              Text(
                'Détails du cours:',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                  color: Colors.blue.shade800,
                ),
              ),
              SizedBox(height: 8),
              Container(
                padding: EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.blue.withOpacity(0.05),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: Colors.blue.withOpacity(0.2)),
                ),
                child: Text(
                  course.details,
                  style: TextStyle(
                    fontSize: 16,
                    height: 1.5,
                  ),
                ),
              ),
              SizedBox(height: 16),

              // Resources
              Text(
                'Ressources:',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                  color: Colors.blue.shade800,
                ),
              ),
              SizedBox(height: 8),

              (course.ressources == null || course.ressources!.isEmpty)
                  ? Container(
                      padding: EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Colors.grey.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        'Aucune ressource disponible pour ce cours.',
                        style: TextStyle(
                          fontSize: 16,
                          fontStyle: FontStyle.italic,
                          color: Colors.grey.shade700,
                        ),
                      ),
                    )
                  : SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: course.ressources!.map((resource) {
                          return Padding(
                            padding: const EdgeInsets.only(right: 10.0),
                            child: Container(
                              width: 200,
                              padding: EdgeInsets.all(12),
                              decoration: BoxDecoration(
                                color: Colors.blue.withOpacity(0.1),
                                borderRadius: BorderRadius.circular(8),
                                border: Border.all(
                                    color: Colors.blue.withOpacity(0.3)),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Icon(Icons.insert_drive_file,
                                      color: Colors.blue, size: 32),
                                  SizedBox(height: 8),
                                  Text(
                                    resource,
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.blue.shade800,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        }).toList(),
                      ),
                    ),
              SizedBox(height: 16),

              // Video Section (if available)
              if (course.video_url != null && course.video_url!.isNotEmpty)
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Vidéo du cours:',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                        color: Colors.blue.shade800,
                      ),
                    ),
                    SizedBox(height: 8),
                    Container(
                      height: 200,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.play_circle_fill,
                              color: Colors.white,
                              size: 60,
                            ),
                            SizedBox(height: 8),
                            Text(
                              'Cliquez pour regarder la vidéo',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
            ],
          ),
        ),
        SizedBox(height: 16),

        // Actions Card
        Container(
          width: double.infinity,
          padding: EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.blue.shade50,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: Colors.blue.withOpacity(0.1),
                spreadRadius: 1,
                blurRadius: 5,
                offset: Offset(0, 2),
              ),
            ],
          ),
          child: Column(
            children: [
              Text(
                'Actions',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue.shade800,
                ),
              ),
              SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _buildActionButton(
                    icon: Icons.assignment,
                    text: "Devoirs",
                    onTap: () {
                      Get.toNamed('/menu/homework',
                          id: 1, arguments: {'id': idMatiere});
                    },
                  ),
                  _buildActionButton(
                    icon: Icons.question_answer,
                    text: "Questions",
                    onTap: () {
                      // Navigate to questions screen
                    },
                  ),
                  _buildActionButton(
                    icon: Icons.download,
                    text: "Télécharger",
                    onTap: () {
                      // Download course content
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
        SizedBox(height: 30),
      ],
    );
  }

  Widget _buildActionButton({
    required IconData icon,
    required String text,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 90,
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: Colors.blue.withOpacity(0.2),
                    spreadRadius: 1,
                    blurRadius: 4,
                    offset: Offset(0, 2),
                  ),
                ],
              ),
              child: Icon(
                icon,
                color: Colors.blue,
                size: 24,
              ),
            ),
            SizedBox(height: 8),
            Text(
              text,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: Colors.blue.shade800,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
