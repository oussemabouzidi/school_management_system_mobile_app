import 'package:flutter/material.dart';
import 'package:my_app3/widgets/language_button.dart';

class Payement extends StatefulWidget {
  @override
  _PayementState createState() => _PayementState();
}

class _PayementState extends State<Payement> {
  // Track which tab is active: 0 for Scolarité, 1 for Activités
  int _activeTabIndex = 0;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: ListView(
        children: [
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
                  "Payment",
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
          Container(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Column(children: [
              SizedBox(height: 24),
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
            ]),
          )
        ],
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
