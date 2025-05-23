import 'package:circular_gradient_spinner/circular_gradient_spinner.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_app3/controller/homework_controller.dart';
import 'package:my_app3/widgets/language_button.dart';
import 'package:file_picker/file_picker.dart';
import 'package:intl/intl.dart';

class Homework extends StatefulWidget {
  @override
  _HomeworkState createState() => _HomeworkState();

  final Map<String, dynamic>? arguments;

  const Homework({super.key, this.arguments});
}

class _HomeworkState extends State<Homework> {
  int _selectedTabIndex =
      0; // 0 for "Détail de travail", 1 for "Envoyer le travail"
  final HomeworkController controller = Get.put(HomeworkController());

  late final String idMatiere;

  @override
  void initState() {
    super.initState();
    final args = widget.arguments;

    if (args != null && args['id'] != null) {
      idMatiere = args['id'];
    } else {
      print("no argument passed!!!");
    }
    // Pass the parameters to your controller
    controller.fetchHomework(studentId: 1, matiereId: int.parse(idMatiere));
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (controller.isLoading.value) {
        return Center(
            child: CircularGradientSpinner(
          color: Colors.blue,
          size: 50,
          strokeWidth: 20,
        ));
      }

      if (controller.hasError.value) {
        return Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Erreur: ${controller.errorMessage.value}'),
              ElevatedButton(
                onPressed: () => controller.fetchHomework(),
                child: Text('Réessayer'),
              ),
            ],
          ),
        );
      }

      return ListView(children: [
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
                  Text(
                    "Travaux à faire",
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

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                tabButton("Détail de travail", 0, _selectedTabIndex == 0,
                    onTap: () {
                  setState(() {
                    _selectedTabIndex = 0;
                  });
                }),
                tabButton("Envoyer le travail", 1, _selectedTabIndex == 1,
                    onTap: () {
                  setState(() {
                    _selectedTabIndex = 1;
                  });
                }),
              ],
            ),

            SizedBox(height: 20),

            // Show content based on selected tab
            _selectedTabIndex == 0 ? _buildDetailView() : _buildSubmitView(),
          ],
        ),
      ]);
    });
  }

  // This is the content view
  Widget _buildDetailView() {
    final homework = controller.homework;

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        children: [
          // Explanation card with title now from API
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    homework.titre,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Image.asset(
                  "images/homework/book.png",
                  width: 80,
                  height: 80,
                ),
              ],
            ),
          ),
          SizedBox(height: 16),

          // Lesson details card
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Subject
                Row(
                  children: [
                    Image.asset(
                      "images/homework/star.png",
                      width: 30,
                      height: 30,
                    ),
                    SizedBox(width: 8),
                    Text(
                      'Matière ID : ',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Text('${homework.matiere_id}'),
                  ],
                ),
                SizedBox(height: 8),

                // Unit/Enseignant
                Row(
                  children: [
                    Image.asset(
                      "images/homework/widget.png",
                      width: 30,
                      height: 30,
                    ),
                    SizedBox(width: 8),
                    Text(
                      'Enseignant ID : ',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Text('${homework.enseignant_id}'),
                  ],
                ),
                SizedBox(height: 8),

                // Date
                Row(
                  children: [
                    Image.asset(
                      "images/homework/calendar.png",
                      width: 30,
                      height: 30,
                    ),
                    SizedBox(width: 8),
                    Text(
                      'Créé le : ',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Text(DateFormat('EEEE d MMMM yyyy').format(homework.date)),
                  ],
                ),
                SizedBox(height: 8),

                // Deadline
                Row(
                  children: [
                    Image.asset(
                      "images/homework/notification.png",
                      width: 30,
                      height: 30,
                    ),
                    SizedBox(width: 8),
                    Text(
                      'Deadline le : ',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Text(DateFormat('EEEE d MMMM yyyy')
                        .format(homework.datelimite)),
                  ],
                ),
                SizedBox(height: 8),

                // État
                Row(
                  children: [
                    Image.asset(
                      "images/homework/done.png",
                      width: 30,
                      height: 30,
                    ),
                    SizedBox(width: 8),
                    Text(
                      'État : ',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Text(homework.etat),
                  ],
                ),
                SizedBox(height: 8),

                // Details
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Image.asset(
                      "images/homework/notebook.png",
                      width: 30,
                      height: 30,
                    ),
                    SizedBox(width: 8),
                    Text(
                      'Détails : ',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 32.0),
                  child: Text(
                    homework.description,
                    style: TextStyle(fontSize: 16),
                  ),
                ),
                SizedBox(height: 12),

                // resources
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Image.asset(
                      "images/homework/resources.png",
                      width: 30,
                      height: 30,
                    ),
                    SizedBox(width: 8),
                    Text(
                      'Ressources : ',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                    ),
                  ],
                ),

                homework.ressources.isEmpty
                    ? Padding(
                        padding: const EdgeInsets.only(left: 32.0),
                        child: Text("Aucune ressource disponible"),
                      )
                    : SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: [
                            for (var resource in homework.ressources)
                              GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (_) => FullScreenImage(
                                          imagePath:
                                              "images/homework/$resource"),
                                    ),
                                  );
                                },
                                child: Padding(
                                  padding: const EdgeInsets.only(right: 8.0),
                                  child: Stack(
                                    children: [
                                      Image.asset(
                                        "images/homework/$resource",
                                        width: 200,
                                        errorBuilder:
                                            (context, error, stackTrace) {
                                          return Container(
                                            width: 200,
                                            height: 120,
                                            color: Colors.grey[300],
                                            child: Center(
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Icon(Icons.insert_drive_file,
                                                      size: 40),
                                                  SizedBox(height: 8),
                                                  Text(resource,
                                                      textAlign:
                                                          TextAlign.center),
                                                ],
                                              ),
                                            ),
                                          );
                                        },
                                      ),
                                      Positioned(
                                        bottom: 5,
                                        right: 5,
                                        child: Container(
                                          padding: EdgeInsets.all(4),
                                          decoration: BoxDecoration(
                                            color: Colors.black54,
                                            borderRadius:
                                                BorderRadius.circular(4),
                                          ),
                                          child: Text(
                                            resource,
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 12),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                          ],
                        ),
                      )
              ],
            ),
          ),
        ],
      ),
    );
  }

  // This is the submit work view
  Widget _buildSubmitView() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16),
      child: Container(
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
                child: Text(
              'Soumettre votre travail',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            )),
            SizedBox(height: 20),

            // Upload file section
            Container(
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Color(0xFFF1F7FF), // Slightly lighter blue background
                borderRadius: BorderRadius.circular(16), // More rounded corners
                border:
                    Border.all(color: Colors.blue.withOpacity(0.4), width: 1.5),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 6,
                    offset: Offset(0, 3),
                  ),
                ],
              ),
              child: Column(
                children: [
                  Container(
                    padding: EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.blue.withOpacity(0.1),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      Icons.cloud_upload_outlined,
                      size: 46,
                      color: Colors.blue,
                    ),
                  ),
                  SizedBox(height: 16),
                  Text(
                    'Déposez des fichiers ici ou cliquez pour parcourir',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Colors.blue.shade700,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'Formats acceptés: PDF, DOCX, JPG, PNG (max 10MB)',
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey.shade600,
                    ),
                  ),
                  SizedBox(height: 20),
                  ElevatedButton.icon(
                    onPressed: () async {
                      try {
                        FilePickerResult? result =
                            await FilePicker.platform.pickFiles(
                          allowMultiple: true,
                          type: FileType.custom,
                          allowedExtensions: ['pdf', 'docx', 'jpg', 'png'],
                        );

                        if (result != null) {
                          // List<PlatformFile> files = result.files;
                          // Display the snackbar using Get.snackbar
                          Get.snackbar(
                            "✅ Travail remis avec succès",
                            "Votre travail a été envoyé. Merci pour votre soumission !",
                            snackPosition: SnackPosition.TOP,
                            backgroundColor: Colors.green.shade100,
                            colorText: Colors.green.shade800,
                            margin: EdgeInsets.all(16),
                            duration: Duration(seconds: 3),
                            icon: Icon(Icons.check_circle, color: Colors.green),
                            borderRadius: 10,
                            boxShadows: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.1),
                                blurRadius: 10,
                                offset: Offset(0, 2),
                              )
                            ],
                          );

                          // You can also get file bytes, paths, etc.
                        } else {
                          // User canceled the picker
                          print('No file selected');
                        }
                      } catch (e) {
                        print('Error picking files: $e');
                        Get.snackbar(
                          "Erreur",
                          "Une erreur est survenue lors de la sélection des fichiers.",
                          snackPosition: SnackPosition.TOP,
                          backgroundColor: Colors.red.shade100,
                          colorText: Colors.red.shade800,
                          margin: EdgeInsets.all(16),
                          duration: Duration(seconds: 3),
                          icon: Icon(Icons.error, color: Colors.red),
                          borderRadius: 10,
                        );
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue.shade600,
                      foregroundColor: Colors.white,
                      padding:
                          EdgeInsets.symmetric(horizontal: 24, vertical: 14),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      elevation: 2,
                    ),
                    icon: Icon(Icons.folder_open),
                    label: Text(
                      'Parcourir les fichiers',
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 24),

            // Comment section - now using the API data for compterendu
            Text(
              'Commentaires:',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8),
            TextField(
              maxLines: 5,
              controller:
                  TextEditingController(text: controller.homework.compterendu),
              decoration: InputDecoration(
                hintText:
                    'Ajoutez vos commentaires ou notes pour l\'enseignant...',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(color: Colors.grey.shade300),
                ),
                filled: true,
                fillColor: Color(0xFFF5F5F5),
              ),
            ),

            SizedBox(height: 24),

            // Submit button
            Center(
              child: ElevatedButton(
                onPressed: () {
                  // Here you would implement submission logic
                  Get.snackbar(
                    "✅ Travail remis avec succès",
                    "Votre travail a été envoyé. Merci pour votre soumission !",
                    snackPosition: SnackPosition.TOP,
                    backgroundColor: Colors.green.shade100,
                    colorText: Colors.green.shade800,
                    margin: EdgeInsets.all(16),
                    duration: Duration(seconds: 3),
                    icon: Icon(Icons.check_circle, color: Colors.green),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  padding: EdgeInsets.symmetric(horizontal: 36, vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: Text(
                  'Soumettre le travail',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Widget tabButton(String text, int index, bool isActive,
    {required Function() onTap}) {
  return GestureDetector(
    onTap: onTap,
    child: Container(
        width: 150,
        height: 60,
        padding: EdgeInsets.symmetric(horizontal: 5, vertical: 12),
        decoration: BoxDecoration(
          color: isActive ? Colors.blue : Colors.white,
          borderRadius: BorderRadius.circular(15),
        ),
        child: Center(
          child: Text(
            text,
            style: TextStyle(
              color: isActive ? Colors.white : Color(0xFF5c8cf4),
              fontWeight: FontWeight.bold,
            ),
          ),
        )),
  );
}

class FullScreenImage extends StatelessWidget {
  final String imagePath;

  const FullScreenImage({required this.imagePath});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body: Center(
        child: Image.asset(
          imagePath,
          errorBuilder: (context, error, stackTrace) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.broken_image, size: 64, color: Colors.white),
                SizedBox(height: 16),
                Text(
                  'Image non disponible',
                  style: TextStyle(color: Colors.white, fontSize: 18),
                ),
                Text(
                  imagePath,
                  style: TextStyle(color: Colors.white70, fontSize: 14),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
