import 'package:crystal_navigation_bar/crystal_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';

class Payement extends StatefulWidget {
  @override
  _PayementState createState() => _PayementState();
}

class _PayementState extends State<Payement> {
  // Track which tab is active: 0 for Scolarité, 1 for Activités
  int _activeTabIndex = 0;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Color(0xFFE8F0FE),
        body: SafeArea(
          child: ListView(
            padding: const EdgeInsets.all(16.0),
            children: [
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
                    "Payment",
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
                                    Container(
                                        decoration: BoxDecoration(
                                            color: Color(0xFF9ECAFF),
                                            borderRadius:
                                                BorderRadius.circular(15)),
                                        height: 50,
                                        width: 250,
                                        child: Row(
                                          children: [
                                            Padding(
                                              padding:
                                                  EdgeInsets.only(left: 30),
                                              child: Image.asset(
                                                'images/languages/francais.png',
                                                width: 30,
                                                height: 30,
                                              ),
                                            ),
                                            Padding(
                                              padding:
                                                  EdgeInsets.only(left: 30),
                                              child: Center(
                                                  child: Text("Francais")),
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
                                                BorderRadius.circular(15)),
                                        height: 50,
                                        width: 250,
                                        child: Row(
                                          children: [
                                            Padding(
                                              padding:
                                                  EdgeInsets.only(left: 30),
                                              child: Image.asset(
                                                'images/languages/unitedKingdom.png',
                                                width: 30,
                                                height: 30,
                                              ),
                                            ),
                                            Padding(
                                                padding:
                                                    EdgeInsets.only(left: 30),
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
                                                BorderRadius.circular(15)),
                                        height: 50,
                                        width: 250,
                                        child: Row(
                                          children: [
                                            Padding(
                                              padding:
                                                  EdgeInsets.only(left: 30),
                                              child: Image.asset(
                                                'images/languages/arabicLanguage.png',
                                                width: 30,
                                                height: 30,
                                              ),
                                            ),
                                            Padding(
                                              padding:
                                                  EdgeInsets.only(left: 30),
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
              const SizedBox(height: 24),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildTabButton("Scolarité", 0),
                  _buildTabButton("Activités", 1),
                ],
              ),
              const SizedBox(height: 24),
              // Conditionally display content based on active tab
              _activeTabIndex == 0
                  ? _buildScolariteContent()
                  : _buildActivitesContent(),
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
            CrystalNavigationBarItem(
              icon: IconlyBold.home,
              unselectedIcon: IconlyLight.home,
              selectedColor: Colors.white,
            ),
            CrystalNavigationBarItem(
              icon: IconlyBold.chat,
              unselectedIcon: IconlyLight.chat,
              selectedColor: Colors.white,
            ),
            CrystalNavigationBarItem(
              icon: IconlyBold.category,
              unselectedIcon: IconlyLight.category,
              selectedColor: Colors.white,
            ),
            CrystalNavigationBarItem(
              icon: IconlyBold.setting,
              unselectedIcon: IconlyLight.setting,
              selectedColor: Colors.white,
            ),
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

  // Tab button with tap functionality to switch tabs
  Widget _buildTabButton(String text, int index) {
    bool isActive = _activeTabIndex == index;
    return GestureDetector(
      onTap: () {
        setState(() {
          _activeTabIndex = index;
        });
      },
      child: Container(
        width: 170,
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        decoration: BoxDecoration(
          color: isActive ? Colors.blue : Colors.white,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Center(
          child: Text(
            text,
            style: TextStyle(
              color: isActive ? Colors.white : Colors.blue,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }

  // Content for Scolarité tab (original content)
  Widget _buildScolariteContent() {
    return Column(
      children: [
        _buildPaymentItem(
          imagePath: "images/money.png",
          title: "Inscription",
          isPaid: true,
          amount: "150dt",
        ),
        SizedBox(height: 10),
        _buildPaymentItem(
          imagePath: "images/month.png",
          title: "Janvier 2025",
          isPaid: false,
          amount: "250dt",
        ),
        SizedBox(height: 10),
        _buildPaymentItem(
          imagePath: "images/month.png",
          title: "Février 2025",
          isPaid: false,
          amount: "250dt",
        ),
        SizedBox(height: 10),
        _buildPaymentItem(
          imagePath: "images/month.png",
          title: "Mars 2025",
          isPaid: false,
          amount: "250dt",
        ),
        SizedBox(height: 10),
        _buildPaymentItem(
          imagePath: "images/month.png",
          title: "Avril 2025",
          isPaid: false,
          amount: "250dt",
        ),
      ],
    );
  }

  // Content for Activités tab (new content)
  Widget _buildActivitesContent() {
    return Column(
      children: [
        _buildPaymentItem(
          imagePath: "images/payment/football.png",
          title: "Football",
          isPaid: true,
          amount: "50dt",
        ),
        SizedBox(height: 10),
        _buildPaymentItem(
          imagePath: "images/payment/excursion.png",
          title: "Excursion - Janvier",
          isPaid: false,
          amount: "75dt",
        ),
        SizedBox(height: 10),
        _buildPaymentItem(
          imagePath: "images/payment/music.png",
          title: "Club de musique",
          isPaid: false,
          amount: "100dt",
        ),
        SizedBox(height: 10),
        _buildPaymentItem(
          imagePath: "images/payment/excursion.png",
          title: "Excursion - Mars",
          isPaid: false,
          amount: "80dt",
        ),
      ],
    );
  }

  // Reusable widget for payment items
  Widget _buildPaymentItem({
    required String imagePath,
    required String title,
    required bool isPaid,
    required String amount,
  }) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: isPaid
            ? []
            : [
                BoxShadow(
                  color: Colors.black.withOpacity(0.2),
                  spreadRadius: 2,
                  blurRadius: 5,
                  offset: Offset(0, 3),
                ),
              ],
      ),
      child: Row(
        children: [
          Expanded(
            flex: 1,
            child: Container(
              padding: const EdgeInsets.all(4),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(4),
              ),
              child: Image.asset(
                imagePath,
                width: 70,
                height: 70,
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(fontSize: 16, color: Colors.black),
                ),
                Text(
                  isPaid ? "Payé" : "Non payé",
                  style: TextStyle(
                    fontSize: 12,
                    color: isPaid ? Colors.grey[600] : Colors.red[600],
                  ),
                )
              ],
            ),
          ),
          Expanded(
            child: Text(
              amount,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: isPaid ? Colors.black : Colors.red[500],
              ),
            ),
          )
        ],
      ),
    );
  }
}
