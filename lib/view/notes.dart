import 'package:circular_gradient_spinner/circular_gradient_spinner.dart';
import 'package:flutter/material.dart';
import 'package:my_app3/services/Services.dart';
import 'package:my_app3/widgets/language_button.dart';
import 'package:my_app3/widgets/student_card.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

// Models
class StudentGrade {
  final String nom;
  final String prenom;
  final String nomMatiereFr;
  final double moyemati;
  final double nvmoy;
  final String type;

  StudentGrade({
    required this.nom,
    required this.prenom,
    required this.nomMatiereFr,
    required this.moyemati,
    required this.nvmoy,
    required this.type,
  });

  factory StudentGrade.fromJson(Map<String, dynamic> json) {
    return StudentGrade(
      nom: json['nom'],
      prenom: json['prenom'],
      nomMatiereFr: json['nom_matiere_fr'],
      moyemati: json['moyemati'] is int
          ? (json['moyemati'] as int).toDouble()
          : json['moyemati'],
      nvmoy: json['nvmoy'] is int
          ? (json['nvmoy'] as int).toDouble()
          : json['nvmoy'],
      type: json['type'],
    );
  }
}

class StudentResult {
  final String nomFr;
  final String prenomFr;
  final int id;
  final int idenevId;
  final double moyeperiexam;
  final int rangperiexam;
  final String obsecons;
  final String codecondassi;

  StudentResult({
    required this.nomFr,
    required this.prenomFr,
    required this.id,
    required this.idenevId,
    required this.moyeperiexam,
    required this.rangperiexam,
    required this.obsecons,
    required this.codecondassi,
  });

  factory StudentResult.fromJson(Map<String, dynamic> json) {
    return StudentResult(
      nomFr: json['nom_fr'],
      prenomFr: json['prenom_fr'],
      id: json['id'],
      idenevId: json['idenelev_id'],
      moyeperiexam: json['moyeperiexam'] is int
          ? (json['moyeperiexam'] as int).toDouble()
          : json['moyeperiexam'],
      rangperiexam: json['rangperiexam'],
      obsecons: json['obsecons'],
      codecondassi: json['codecondassi'],
    );
  }
}

// API Service
class ApiService {
  static String baseUrl = Service().baseUrl;

  static Future<List<StudentGrade>> fetchGrades(int eleveId) async {
    try {
      final response =
          await http.get(Uri.parse('$baseUrl/note/eleve?eleve_id=$eleveId'));

      if (response.statusCode == 200) {
        List<dynamic> jsonData = json.decode(response.body);
        return jsonData.map((data) => StudentGrade.fromJson(data)).toList();
      } else {
        throw Exception('Failed to load grades: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Failed to connect to server: $e');
    }
  }

  static Future<StudentResult> fetchStudentResult(int eleveId) async {
    try {
      final response =
          await http.get(Uri.parse('$baseUrl/eleve/$eleveId/resultat'));

      if (response.statusCode == 200) {
        List<dynamic> jsonData = json.decode(response.body);
        if (jsonData.isNotEmpty) {
          return StudentResult.fromJson(jsonData[0]);
        } else {
          throw Exception('No result data found');
        }
      } else {
        throw Exception(
            'Failed to load student result: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Failed to connect to server: $e');
    }
  }
}

class Notes extends StatefulWidget {
  @override
  _NotesState createState() => _NotesState();
}

class _NotesState extends State<Notes> {
  List<StudentGrade> _grades = [];
  StudentResult? _studentResult;
  bool _isLoading = true;
  String _selectedTrimester = "1";
  String _selectedYear = "2023/2024";
  String _error = '';

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    setState(() {
      _isLoading = true;
      _error = '';
    });

    try {
      // Fetch both data in parallel
      final futureGrades =
          ApiService.fetchGrades(1); // assuming student ID is 1
      final futureResult = ApiService.fetchStudentResult(1);

      final results = await Future.wait([futureGrades, futureResult]);

      setState(() {
        _grades = results[0] as List<StudentGrade>;
        _studentResult = results[1] as StudentResult;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
        _error = e.toString();
      });
    }
  }

  // Calculate average grade for a subject
  double calculateSubjectAverage(String subject) {
    final subjectGrades =
        _grades.where((grade) => grade.nomMatiereFr == subject);
    if (subjectGrades.isEmpty) return 0.0;

    double sum = subjectGrades.fold(0.0, (sum, grade) => sum + grade.moyemati);
    return sum / subjectGrades.length;
  }

  // Get unique subjects
  List<String> get uniqueSubjects {
    return _grades.map((grade) => grade.nomMatiereFr).toSet().toList();
  }

  // Get student grades by subject and type
  StudentGrade? getGradeBySubjectAndType(String subject, String type) {
    try {
      return _grades.firstWhere((grade) =>
          grade.nomMatiereFr == subject &&
          grade.type.toLowerCase() == type.toLowerCase());
    } catch (e) {
      return null;
    }
  }

  // Get color for subject
  Color getSubjectColor(String subject) {
    final colors = {
      'Math': Colors.blue[800]!,
      'Français': Colors.green,
      'Arabic': Colors.purple,
      'English': Colors.red,
      'Sciences physiques': Colors.orange,
    };

    return colors[subject] ?? Colors.grey;
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
                    SizedBox(width: screenWidth * 0.06),
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: DropdownButton<String>(
                        value: _selectedTrimester,
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
                              _selectedTrimester = value;
                              // In a real app, you would reload data with new trimester
                              _loadData();
                            });
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
                        value: _selectedYear,
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
                              _selectedYear = value;
                              // In a real app, you would reload data with new year
                              _loadData();
                            });
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

            // Loading or error indicator
            if (_isLoading)
              Container(
                margin: const EdgeInsets.all(16),
                padding: const EdgeInsets.all(20),
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
                child: Center(
                    child: CircularGradientSpinner(
                  color: Colors.blue,
                  size: 50,
                  strokeWidth: 20,
                )),
              )
            else if (_error.isNotEmpty)
              Container(
                margin: const EdgeInsets.all(16),
                padding: const EdgeInsets.all(20),
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
                child: Center(
                  child: Text(
                    'Erreur: $_error',
                    style: TextStyle(color: Colors.red),
                  ),
                ),
              )
            // Grades Content
            else
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
                        "Notes",
                        style: TextStyle(
                          color: Colors.blue,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 30),
                      Column(
                        children: [
                          // Display each subject grade card
                          ...uniqueSubjects.map((subject) => SubjectGradeCard(
                                subjectName: subject,
                                subjectColor: getSubjectColor(subject),
                                grade: calculateSubjectAverage(subject),
                                cc1Grade: getGradeBySubjectAndType(
                                            subject, 'contrôle continu 1')
                                        ?.moyemati ??
                                    0,
                                cc2Grade: getGradeBySubjectAndType(
                                            subject, 'contrôle continu 2')
                                        ?.moyemati ??
                                    0,
                                syntheseGrade: getGradeBySubjectAndType(
                                            subject, 'synthèse')
                                        ?.moyemati ??
                                    0,
                              )),

                          const SizedBox(height: 16),

                          // Overall average
                          if (_studentResult != null)
                            Container(
                              width: double.infinity,
                              padding: const EdgeInsets.all(12),
                              decoration: BoxDecoration(
                                color: Colors.green.withOpacity(0.2),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Moyenne générale élève : ${_studentResult!.moyeperiexam.toStringAsFixed(2)}',
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.green,
                                      fontSize: 16,
                                    ),
                                  ),
                                  SizedBox(height: 4),
                                  Text(
                                    'Rang : ${_studentResult!.rangperiexam}',
                                    style: const TextStyle(
                                      color: Colors.black54,
                                      fontSize: 14,
                                    ),
                                  ),
                                  if (_studentResult!.obsecons.isNotEmpty)
                                    Padding(
                                      padding: const EdgeInsets.only(top: 8.0),
                                      child: Text(
                                        'Appréciation générale : ${_studentResult!.obsecons}',
                                        style: const TextStyle(
                                          color: Colors.black87,
                                          fontSize: 14,
                                          fontStyle: FontStyle.italic,
                                        ),
                                      ),
                                    ),
                                ],
                              ),
                            )
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
            onPressed: () {
              // PDF download functionality would go here
            },
            backgroundColor: Color(0xFF12B264),
            shape: CircleBorder(),
            child: Icon(Icons.picture_as_pdf, color: Colors.white),
          ),
        ),
      ],
    );
  }
}

class SubjectGradeCard extends StatelessWidget {
  final String subjectName;
  final Color subjectColor;
  final double grade;
  final double cc1Grade;
  final double cc2Grade;
  final double syntheseGrade;

  const SubjectGradeCard({
    Key? key,
    required this.subjectName,
    required this.subjectColor,
    required this.grade,
    required this.cc1Grade,
    required this.cc2Grade,
    required this.syntheseGrade,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 2,
            offset: const Offset(0, 1),
          ),
        ],
      ),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: const BoxDecoration(
              border: Border(
                bottom: BorderSide(color: Colors.black12, width: 1),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Container(
                      width: 5,
                      height: 20,
                      decoration: BoxDecoration(
                        color: subjectColor,
                        borderRadius: BorderRadius.circular(2),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      subjectName,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
                Text(
                  grade.toStringAsFixed(2),
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              ],
            ),
          ),
          _buildAssessmentRow('Contrôle continu 1', cc1Grade),
          _buildAssessmentRow('Contrôle continu 2', cc2Grade),
          _buildAssessmentRow('Synthèse', syntheseGrade),
          // Appréciation would typically come from your API as well
          // but not included in the provided endpoints
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text(
                  'Appréciation',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  'Bon travail, élève appliqué',
                  style: TextStyle(
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAssessmentRow(String title, double grade) {
    // For a real implementation, you would also include the date from the API
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: const BoxDecoration(
        border: Border(
          bottom: BorderSide(color: Colors.black12, width: 1),
        ),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: Colors.grey[300],
              borderRadius: BorderRadius.circular(4),
            ),
            child: Column(
              children: const [
                Text(
                  '27',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  'nov.',
                  style: TextStyle(
                    fontSize: 10,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              title,
              style: const TextStyle(fontSize: 14),
            ),
          ),
          Text(
            grade.toStringAsFixed(2),
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }
}
