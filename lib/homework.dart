import 'package:flutter/material.dart';
import 'package:crystal_navigation_bar/crystal_navigation_bar.dart';
import 'package:iconly/iconly.dart';

class Homework extends StatefulWidget {
  @override
  _HomeworkState createState() => _HomeworkState();
}

class _HomeworkState extends State<Homework> {
  int _selectedTabIndex =
      0; // 0 for "Détail de travail", 1 for "Envoyer le travail"

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Color(0xFFE8F0FE),
        body: SafeArea(
          child: ListView(
              padding:
                  const EdgeInsets.symmetric(horizontal: 16.0, vertical: 30),
              children: [
                Column(
                  children: [
                    // Top navigation bar
                    Row(
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
                            child:
                                Icon(Icons.arrow_back, color: Colors.black54),
                          ),
                        ),
                        const Text(
                          "Travail à Faire",
                          style: TextStyle(
                            color: Colors.blue,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        // Language button
                        Container(
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
                                          borderRadius:
                                              BorderRadius.circular(15)),
                                      title: Text("Choisir language"),
                                      content: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Container(
                                              decoration: BoxDecoration(
                                                  color: Color(0xFF9ECAFF),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          15)),
                                              height: 50,
                                              width: 250,
                                              child: Row(
                                                children: [
                                                  Padding(
                                                    padding: EdgeInsets.only(
                                                        left: 30),
                                                    child: Image.asset(
                                                      'images/languages/francais.png',
                                                      width: 30,
                                                      height: 30,
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding: EdgeInsets.only(
                                                        left: 30),
                                                    child: Center(
                                                        child:
                                                            Text("Francais")),
                                                  )
                                                ],
                                              )),
                                          SizedBox(
                                            height: 10,
                                          ),
                                          Container(
                                              decoration: BoxDecoration(
                                                  color: Color(0xFFFF8CA1),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          15)),
                                              height: 50,
                                              width: 250,
                                              child: Row(
                                                children: [
                                                  Padding(
                                                    padding: EdgeInsets.only(
                                                        left: 30),
                                                    child: Image.asset(
                                                      'images/languages/unitedKingdom.png',
                                                      width: 30,
                                                      height: 30,
                                                    ),
                                                  ),
                                                  Padding(
                                                      padding: EdgeInsets.only(
                                                          left: 30),
                                                      child: Center(
                                                        child: Text("Englais"),
                                                      )),
                                                ],
                                              )),
                                          SizedBox(
                                            height: 10,
                                          ),
                                          Container(
                                              decoration: BoxDecoration(
                                                  color: Color(0xFF92FFC1),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          15)),
                                              height: 50,
                                              width: 250,
                                              child: Row(
                                                children: [
                                                  Padding(
                                                    padding: EdgeInsets.only(
                                                        left: 30),
                                                    child: Image.asset(
                                                      'images/languages/arabicLanguage.png',
                                                      width: 30,
                                                      height: 30,
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding: EdgeInsets.only(
                                                        left: 30),
                                                    child: Text("Arabic"),
                                                  )
                                                ],
                                              )),
                                        ],
                                      ),
                                    );
                                  });
                            },
                            icon: Image.asset(
                              "images/dashboard/Language.png",
                              width: 24,
                              height: 24,
                            ),
                            padding: EdgeInsets.zero,
                          ),
                        ),
                      
                      ],
                    ),
                    SizedBox(height: 20),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        tabButton(
                            "Détail de travail", 0, _selectedTabIndex == 0,
                            onTap: () {
                          setState(() {
                            _selectedTabIndex = 0;
                          });
                        }),
                        tabButton(
                            "Envoyer le travail", 1, _selectedTabIndex == 1,
                            onTap: () {
                          setState(() {
                            _selectedTabIndex = 1;
                          });
                        }),
                      ],
                    ),

                    SizedBox(height: 20),

                    // Show content based on selected tab
                    _selectedTabIndex == 0
                        ? _buildDetailView()
                        : _buildSubmitView(),
                  ],
                ),
              ]),
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

  // This is the original content view
  Widget _buildDetailView() {
    return Column(
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
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
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
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
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
                              builder: (_) => FullScreenImage(imagePath: path),
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
    );
  }

  // This is the submit work view
  Widget _buildSubmitView() {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Soumettre votre travail',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          SizedBox(height: 20),

          // Upload file section
          Container(
            padding: EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Color(0xFFE8F0FE),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.blue.withOpacity(0.3), width: 1),
            ),
            child: Column(
              children: [
                Icon(
                  Icons.cloud_upload_outlined,
                  size: 60,
                  color: Colors.blue,
                ),
                SizedBox(height: 16),
                Text(
                  'Déposez des fichiers ici ou cliquez pour parcourir',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.blue,
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  'Formats acceptés: PDF, DOCX, JPG, PNG (max 10MB)',
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey,
                  ),
                ),
                SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: Text(
                    'Parcourir les fichiers',
                    style: TextStyle(
                      color: Colors.white,
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
