import 'package:crystal_navigation_bar/crystal_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:iconly/iconly.dart';

class Cantine extends StatefulWidget {
  @override
  State<Cantine> createState() {
    return _CantineState();
  }
}

class _CantineState extends State<Cantine> {
  String expandedDay = "";

  final Map<String, Color> dayColors = {
    "lundi": Colors.blue,
    "mardi": Colors.orange,
    "mercredi": Colors.green,
    "jeudi": Colors.purple,
    "vendredi": Colors.red,
  };

  final Map<String, List<String>> menuItems = {
    "lundi": [
      "Salade de riz",
      "Salade niçoise",
      "Escalope pannée",
      "Potatoes",
      "Mini pizza",
      "Yaourt + Fruit"
    ],
    "mardi": [
      "Soupe de légumes",
      "Couscous royal",
      "Filet de poisson",
      "Riz pilaf",
      "Quiche lorraine",
      "Fruit + Crème dessert"
    ],
    "mercredi": [
      "Taboulé",
      "Steak haché",
      "Gratin dauphinois",
      "Haricots verts",
      "Croque-monsieur",
      "Compote + Fromage"
    ],
    "jeudi": [
      "Salade César",
      "Poulet rôti",
      "Pâtes carbonara",
      "Ratatouille",
      "Panini",
      "Mousse au chocolat"
    ],
    "vendredi": [
      "Macédoine",
      "Lasagnes",
      "Poisson pané",
      "Épinards à la crème",
      "Wrap végétarien",
      "Tarte aux fruits"
    ],
  };

  void toggleMenu(String day) {
    setState(() {
      if (expandedDay == day) {
        expandedDay = "";
      } else {
        expandedDay = day;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        useMaterial3: true,
        fontFamily: 'Poppins',
      ),
      home: Scaffold(
        backgroundColor: Color(0xFFE8F0FE),
        body: SafeArea(
          child: ListView(
            padding: const EdgeInsets.all(16.0),
            children: [
              // Back button and language toggle row
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
                      child: Icon(Icons.arrow_back, color: Colors.black54),
                    ),
                  ),
                  const Text(
                    "Cantine",
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
                                    borderRadius: BorderRadius.circular(15)),
                                title: Text("Choisir language"),
                                content: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    _languageOption(
                                        'images/languages/francais.png',
                                        'Francais',
                                        Color(0xFF9ECAFF)),
                                    SizedBox(height: 10),
                                    _languageOption(
                                        'images/languages/unitedKingdom.png',
                                        'Englais',
                                        Color(0xFFFF8CA1)),
                                    SizedBox(height: 10),
                                    _languageOption(
                                        'images/languages/arabicLanguage.png',
                                        'Arabic',
                                        Color(0xFF92FFC1)),
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
              const SizedBox(height: 30),

              // Header with animation
              TweenAnimationBuilder(
                duration: Duration(milliseconds: 800),
                tween: Tween<double>(begin: 0, end: 1),
                builder: (context, value, child) {
                  return Opacity(
                    opacity: value,
                    child: Transform.translate(
                      offset: Offset(0, 20 * (1 - value)),
                      child: child,
                    ),
                  );
                },
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [Colors.blue.shade400, Colors.blue.shade700],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.blue.withOpacity(0.3),
                        spreadRadius: 2,
                        blurRadius: 10,
                        offset: Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      Text(
                        "Menu de la semaine",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 5),
                      Text(
                        "Découvrez les repas servis chaque jour",
                        style: TextStyle(
                          color: Colors.white.withOpacity(0.9),
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              SizedBox(height: 30),

              // Days of the week
              ...dayColors.entries.map((entry) {
                String day = entry.key;
                Color color = entry.value;
                String displayDay =
                    day.substring(0, 1).toUpperCase() + day.substring(1);

                return Padding(
                  padding: EdgeInsets.only(bottom: 15),
                  child: AnimatedContainer(
                    duration: Duration(milliseconds: 300),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                        BoxShadow(
                          color: color.withOpacity(0.3),
                          spreadRadius: 1,
                          blurRadius: 6,
                          offset: Offset(0, 3),
                        ),
                      ],
                    ),
                    child: Column(
                      children: [
                        // Day header
                        Material(
                          color: Colors.transparent,
                          child: InkWell(
                            onTap: () => toggleMenu(day),
                            borderRadius: BorderRadius.circular(16),
                            child: Container(
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  colors: [color.withOpacity(0.8), color],
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight,
                                ),
                                borderRadius: expandedDay == day
                                    ? BorderRadius.only(
                                        topLeft: Radius.circular(16),
                                        topRight: Radius.circular(16),
                                      )
                                    : BorderRadius.circular(16),
                              ),
                              child: Padding(
                                padding: EdgeInsets.symmetric(vertical: 16),
                                child: Row(
                                  children: [
                                    Container(
                                      width: 60,
                                      child: Center(
                                        child: Container(
                                          padding: EdgeInsets.all(8),
                                          decoration: BoxDecoration(
                                            color:
                                                Colors.white.withOpacity(0.2),
                                            shape: BoxShape.circle,
                                          ),
                                          child: Icon(
                                            Icons.restaurant_menu,
                                            color: Colors.white,
                                            size: 24,
                                          ),
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      child: Text(
                                        displayDay,
                                        style: TextStyle(
                                          fontSize: 18,
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                        ),
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                    Container(
                                      width: 60,
                                      child: Center(
                                        child: AnimatedRotation(
                                          turns: expandedDay == day ? 0.5 : 0,
                                          duration: Duration(milliseconds: 300),
                                          child: Icon(
                                            Icons.keyboard_arrow_down,
                                            color: Colors.white,
                                            size: 24,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),

                        // Menu items
                        AnimatedSize(
                          duration: Duration(milliseconds: 300),
                          child: expandedDay == day
                              ? Container(
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.only(
                                      bottomLeft: Radius.circular(16),
                                      bottomRight: Radius.circular(16),
                                    ),
                                    border: Border.all(
                                      color: color.withOpacity(0.5),
                                      width: 1.5,
                                    ),
                                  ),
                                  child: Padding(
                                    padding: EdgeInsets.all(16),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        // Meal categories
                                        Row(
                                          children: [
                                            Expanded(
                                              child: Container(
                                                padding: EdgeInsets.symmetric(
                                                    vertical: 8),
                                                decoration: BoxDecoration(
                                                  color: color.withOpacity(0.1),
                                                  borderRadius:
                                                      BorderRadius.circular(8),
                                                ),
                                                child: Text(
                                                  "Entrées",
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    color: color,
                                                  ),
                                                  textAlign: TextAlign.center,
                                                ),
                                              ),
                                            ),
                                            SizedBox(width: 8),
                                            Expanded(
                                              child: Container(
                                                padding: EdgeInsets.symmetric(
                                                    vertical: 8),
                                                decoration: BoxDecoration(
                                                  color: color.withOpacity(0.1),
                                                  borderRadius:
                                                      BorderRadius.circular(8),
                                                ),
                                                child: Text(
                                                  "Plats",
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    color: color,
                                                  ),
                                                  textAlign: TextAlign.center,
                                                ),
                                              ),
                                            ),
                                            SizedBox(width: 8),
                                            Expanded(
                                              child: Container(
                                                padding: EdgeInsets.symmetric(
                                                    vertical: 8),
                                                decoration: BoxDecoration(
                                                  color: color.withOpacity(0.1),
                                                  borderRadius:
                                                      BorderRadius.circular(8),
                                                ),
                                                child: Text(
                                                  "Desserts",
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    color: color,
                                                  ),
                                                  textAlign: TextAlign.center,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),

                                        SizedBox(height: 16),

                                        // Menu items list
                                        ...menuItems[day]!
                                            .asMap()
                                            .entries
                                            .map((entry) {
                                          int idx = entry.key;
                                          String item = entry.value;

                                          IconData iconData;
                                          if (idx < 2) {
                                            iconData =
                                                Icons.soup_kitchen_outlined;
                                          } else if (idx < 4) {
                                            iconData = Icons.dinner_dining;
                                          } else if (idx < 5) {
                                            iconData = Icons.lunch_dining;
                                          } else {
                                            iconData = Icons.icecream;
                                          }

                                          return Padding(
                                            padding: EdgeInsets.only(bottom: 8),
                                            child: Container(
                                              padding: EdgeInsets.symmetric(
                                                  vertical: 10, horizontal: 12),
                                              decoration: BoxDecoration(
                                                color: idx % 2 == 0
                                                    ? color.withOpacity(0.05)
                                                    : Colors.grey
                                                        .withOpacity(0.05),
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                                border: Border.all(
                                                  color: color.withOpacity(0.2),
                                                  width: 1,
                                                ),
                                              ),
                                              child: Row(
                                                children: [
                                                  Icon(
                                                    iconData,
                                                    color: color,
                                                    size: 20,
                                                  ),
                                                  SizedBox(width: 12),
                                                  Expanded(
                                                    child: Text(
                                                      item,
                                                      style: TextStyle(
                                                        fontSize: 15,
                                                        color: Colors.black87,
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          );
                                        }).toList(),

                                        SizedBox(height: 8),

                                        // Nutritional info
                                        Container(
                                          padding: EdgeInsets.all(12),
                                          decoration: BoxDecoration(
                                            color: Colors.grey.withOpacity(0.1),
                                            borderRadius:
                                                BorderRadius.circular(10),
                                          ),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceAround,
                                            children: [
                                              _nutritionInfo(
                                                  "Calories",
                                                  "650 kcal",
                                                  Icons.local_fire_department),
                                              _nutritionInfo("Protéines", "25g",
                                                  Icons.fitness_center),
                                              _nutritionInfo("Glucides", "80g",
                                                  Icons.grain),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                )
                              : SizedBox.shrink(),
                        ),
                      ],
                    ),
                  ),
                );
              }).toList(),
            ],
          ),
        ),
        bottomNavigationBar: CrystalNavigationBar(
          currentIndex: 2,
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
          unselectedItemColor: Colors.white70,
          borderWidth: 2,
          outlineBorderColor: Colors.white,
          backgroundColor: Colors.black.withValues(alpha: 0.5),
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
              selectedColor: Colors.white,
            ),

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

  // Helper method for language selection options
  Widget _languageOption(String imagePath, String language, Color color) {
    return Container(
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(15),
      ),
      height: 50,
      width: 250,
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(15),
          onTap: () {
            Navigator.pop(context);
          },
          child: Row(
            children: [
              Padding(
                padding: EdgeInsets.only(left: 30),
                child: Image.asset(
                  imagePath,
                  width: 30,
                  height: 30,
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 30),
                child: Text(
                  language,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Helper method for nutrition information display
  Widget _nutritionInfo(String label, String value, IconData icon) {
    return Column(
      children: [
        Icon(
          icon,
          color: Colors.grey.shade700,
          size: 20,
        ),
        SizedBox(height: 4),
        Text(
          value,
          style: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 14,
          ),
        ),
        Text(
          label,
          style: TextStyle(
            color: Colors.grey.shade600,
            fontSize: 12,
          ),
        ),
      ],
    );
  }
}
