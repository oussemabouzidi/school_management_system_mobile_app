import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_app3/widgets/language_button.dart';
import 'package:file_picker/file_picker.dart';

class Homework extends StatefulWidget {
  @override
  _HomeworkState createState() => _HomeworkState();
}

class _HomeworkState extends State<Homework> {
  int _selectedTabIndex =
      0; // 0 for "Détail de travail", 1 for "Envoyer le travail"

  @override
  Widget build(BuildContext context) {
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
                const Text(
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
  }

  // This is the content view
  Widget _buildDetailView() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        children: [
          // Explanation card
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
                Text(
                  'Explication des mots',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
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
                      'Matière : ',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Text('Lecture'),
                  ],
                ),
                SizedBox(height: 8),

                // Unit
                Row(
                  children: [
                    Image.asset(
                      "images/homework/widget.png",
                      width: 30,
                      height: 30,
                    ),
                    SizedBox(width: 8),
                    Text(
                      'Unité : ',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Text('Les étoiles'),
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
                    Text('Samedi 3 Février 2024'),
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
                    Text('Mardi 14 Février 2024'),
                  ],
                ),
                SizedBox(height: 8),

                // Classé
                Row(
                  children: [
                    Image.asset(
                      "images/homework/done.png",
                      width: 30,
                      height: 30,
                    ),
                    SizedBox(width: 8),
                    Text(
                      'Classer : ',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Text('Oui'),
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
                    'Le mot "brillant" exprime quelque chose qui émet ou réfléchit la lumière de manière intense. C\'est un adjectif descriptif qui peut être utilisé pour décrire la lumière ou le contexte littéral dans le cadre linguistique et métaphorique, que ce soit pour les objets naturels ou la lumière. Ou dans le contexte métaphorique pour décrire quelque chose de remarquable, par exemple:',
                    style: TextStyle(fontSize: 16),
                  ),
                ),
                SizedBox(height: 12),

                // Examples
                Padding(
                  padding: const EdgeInsets.only(left: 32.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('• ',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 18)),
                          Expanded(
                            child: Text(
                              'Les vêtements blancs étaient brillants sous les rayons du soleil.',
                              style: TextStyle(fontSize: 16),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 8),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('• ',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 18)),
                          Expanded(
                            child: Text(
                              'L\'apparence de la montagne était clairement visible dans la journée brillante.',
                              style: TextStyle(fontSize: 16),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 8),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('• ',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 18)),
                          Expanded(
                            child: Text(
                              'Il a obtenu une réussite brillante dans son domaine.',
                              style: TextStyle(fontSize: 16),
                            ),
                          ),
                        ],
                      ),
                    ],
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

                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      for (var path in [
                        "images/homework/test1.png",
                        "images/homework/test2.png",
                        "images/homework/test3.jpg",
                        "images/homework/test4.jpg",
                      ])
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) =>
                                    FullScreenImage(imagePath: path),
                              ),
                            );
                          },
                          child: Padding(
                            padding: const EdgeInsets.only(right: 8.0),
                            child: Image.asset(path, width: 200),
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

            // Comment section
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
                onPressed: () {},
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
        child: Image.asset(imagePath),
      ),
    );
  }
}
