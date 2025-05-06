import 'dart:convert';
import 'package:circular_gradient_spinner/circular_gradient_spinner.dart';
import 'package:flutter/material.dart';
import 'package:my_app3/widgets/language_button.dart';
import 'package:http/http.dart' as http;

class Cantine extends StatefulWidget {
  @override
  State<Cantine> createState() {
    return _CantineState();
  }
}

class _CantineState extends State<Cantine> {
  String expandedDay = "";
  bool Spinner = true;

  final Map<String, Color> dayColors = {
    "lundi": Colors.blue,
    "mardi": Colors.orange,
    "mercredi": Colors.green,
    "jeudi": Colors.purple,
    "vendredi": Colors.red,
  };

  final Map<String, List<String>> menuItems = {
    "lundi": [],
    "mardi": [],
    "mercredi": [],
    "jeudi": [],
    "vendredi": [],
  };

  @override
  void initState() {
    super.initState();
    _fetchData();
  }

  Future<void> _fetchData() async {
    try {
      var response = await http.get(Uri.parse(
          "http://apiserv.ise-college-lycee.com:8415/getMenuCantine"));
      var data = jsonDecode(response.body);
      for (var item in data) {
        switch (item["idjour"]) {
          case 1:
            menuItems["lundi"]?.add(item["libellerepat"]);
            break;
          case 2:
            menuItems["mardi"]?.add(item["libellerepat"]);
            break;
          case 3:
            menuItems["mercredi"]?.add(item["libellerepat"]);
            break;
          case 4:
            menuItems["jeudi"]?.add(item["libellerepat"]);
            break;
          case 5:
            menuItems["vendredi"]?.add(item["libellerepat"]);
            break;
        }
        print(menuItems);
      }
      // Set Spinner to false and refresh the UI
      setState(() {
        Spinner = false;
      });
    } catch (e) {
      print("Erreur : $e");
    }
  }

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
    return ListView(
      children: [
        // Back button and language toggle row
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
              const Text(
                "Cantine",
                style: TextStyle(
                  color: Colors.blue,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              // Language button
              LanguageButton()
            ],
          ),
        ),
        const SizedBox(height: 30),

        Padding(
          padding: EdgeInsets.all(16),
          child: // Header with animation
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
              padding: EdgeInsets.symmetric(vertical: 15, horizontal: 40),
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
        ),
        if (Spinner)
          CircularGradientSpinner(
            color: Colors.blue,
            size: 50,
            strokeWidth: 20,
          ),
        if (!Spinner)
          Padding(
            padding: EdgeInsets.all(16),
            child: Column(
              children: [
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
                                            duration:
                                                Duration(milliseconds: 300),
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
                                                    color:
                                                        color.withOpacity(0.1),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            8),
                                                  ),
                                                  child: Text(
                                                    "Entrées",
                                                    style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
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
                                                    color:
                                                        color.withOpacity(0.1),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            8),
                                                  ),
                                                  child: Text(
                                                    "Plats",
                                                    style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
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
                                                    color:
                                                        color.withOpacity(0.1),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            8),
                                                  ),
                                                  child: Text(
                                                    "Desserts",
                                                    style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
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
                                              padding:
                                                  EdgeInsets.only(bottom: 8),
                                              child: Container(
                                                padding: EdgeInsets.symmetric(
                                                    vertical: 10,
                                                    horizontal: 12),
                                                decoration: BoxDecoration(
                                                  color: idx % 2 == 0
                                                      ? color.withOpacity(0.05)
                                                      : Colors.grey
                                                          .withOpacity(0.05),
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                  border: Border.all(
                                                    color:
                                                        color.withOpacity(0.2),
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
                                              color:
                                                  Colors.grey.withOpacity(0.1),
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
                                                    Icons
                                                        .local_fire_department),
                                                _nutritionInfo(
                                                    "Protéines",
                                                    "25g",
                                                    Icons.fitness_center),
                                                _nutritionInfo("Glucides",
                                                    "80g", Icons.grain),
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
          )
      ],
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
