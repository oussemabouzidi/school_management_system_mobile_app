import 'package:circular_gradient_spinner/circular_gradient_spinner.dart';
import 'package:flutter/material.dart';
import 'package:my_app3/controller/payement_controller.dart';
import 'package:my_app3/widgets/language_button.dart';
import 'package:get/get.dart';

class Payement extends StatefulWidget {
  @override
  _PayementState createState() => _PayementState();
}

class _PayementState extends State<Payement> {
  // Track which tab is active: 0 for Scolarité, 1 for Activités
  int _activeTabIndex = 0;
  final PayementController _paymentController = Get.put(PayementController());
  // Flag to track if initial loading has been done
  bool _initialLoadDone = false;

  @override
  void initState() {
    super.initState();
    // Initial data load - "scolarité" is the default tab
    _loadData();
  }

  void _loadData() {
    if (!_initialLoadDone) {
      _paymentController.fetchData("scolarité");
      _initialLoadDone = true;
    }
  }

  void _changeTab(int index) {
    if (_activeTabIndex != index) {
      setState(() {
        _activeTabIndex = index;
        // Load appropriate data based on active tab
        _paymentController.fetchData(index == 0 ? "scolarité" : "activités");
      });
    }
  }

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
              // Display content based on API data
              Obx(() {
                if (_paymentController.isLoading.value) {
                  return Center(
                      child: CircularGradientSpinner(
                    color: Colors.blue,
                    size: 50,
                    strokeWidth: 20,
                  ));
                }

                if (_paymentController.hasError.value) {
                  return Center(
                    child: Column(
                      children: [
                        Icon(Icons.error, color: Colors.red, size: 50),
                        SizedBox(height: 10),
                        Text(_paymentController.errorMessage.value),
                        SizedBox(height: 10),
                        ElevatedButton(
                          onPressed: () => _paymentController.fetchData(
                              _activeTabIndex == 0 ? "scolarité" : "activités"),
                          child: Text("Retry"),
                        ),
                      ],
                    ),
                  );
                }

                if (_paymentController.payements.isEmpty) {
                  return Center(
                    child: Text("No payments found"),
                  );
                }

                return _buildPaymentList();
              }),
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
        _changeTab(index);
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

  // Dynamic payment list from API data
  Widget _buildPaymentList() {
    return Column(
      children: _paymentController.payements.map((payment) {
        return Column(
          children: [
            _buildPaymentItem(
              imagePath: _getImagePath(payment.title, payment.type),
              title: payment.title,
              isPaid: payment.paye == 1,
              amount: "${payment.price}dt",
            ),
            SizedBox(height: 10),
          ],
        );
      }).toList(),
    );
  }

  // Helper method to determine image path based on payment type and title
  String _getImagePath(String title, String type) {
    String lowerTitle = title.toLowerCase();

    if (type.toLowerCase() == "scolarité") {
      if (lowerTitle.contains("inscription")) {
        return "images/money.png";
      } else {
        return "images/month.png";
      }
    } else {
      // For activities
      if (lowerTitle.contains("football")) {
        return "images/payment/football.png";
      } else if (lowerTitle.contains("excursion")) {
        return "images/payment/excursion.png";
      } else if (lowerTitle.contains("musique") ||
          lowerTitle.contains("music")) {
        return "images/payment/music.png";
      } else {
        // Default image for activities
        return "images/payment/excursion.png";
      }
    }
  }

  // Reusable widget for payment items (unchanged)
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
