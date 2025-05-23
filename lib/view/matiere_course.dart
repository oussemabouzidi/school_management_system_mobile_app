import 'package:circular_gradient_spinner/circular_gradient_spinner.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_app3/controller/matiere_controller.dart';
import 'package:my_app3/models/Matiere.dart';
import 'package:my_app3/widgets/language_button.dart';

class MatiereCourse extends StatelessWidget {
  final MatiereController _matiereController = Get.put(MatiereController());

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
                  "Matieres",
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
          SizedBox(height: 40),

          // Matiere Cards
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Obx(() {
              if (_matiereController.isLoading.value) {
                return Center(
                    child: CircularGradientSpinner(
                  color: Colors.blue,
                  size: 50,
                  strokeWidth: 20,
                ));
              } else if (_matiereController.hasError.value) {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                          'Error loading subjects: ${_matiereController.errorMessage.value}'),
                      SizedBox(height: 16),
                      ElevatedButton(
                        onPressed: () => _matiereController.fetchMatieres(),
                        child: Text('Retry'),
                      ),
                    ],
                  ),
                );
              } else if (_matiereController.matieres.isEmpty) {
                return Center(child: Text('No subjects available'));
              } else {
                return Column(
                  children: [
                    // Dynamic matiere cards
                    ..._matiereController.matieres
                        .map(
                          (matiere) => Column(
                            children: [
                              buildMatiereCard(matiere),
                              SizedBox(height: 16),
                            ],
                          ),
                        )
                        .toList(),
                  ],
                );
              }
            }),
          )
        ],
      ),
    ]);
  }

  Widget buildMatiereCard(Matiere matiere) {
    return ElevatedButton(
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
        onPressed: () {
          Get.toNamed('/menu/course_details',
              id: 1, arguments: {'id': matiere.id.toString()});
        },
        child: Container(
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
                matiere.nomMatiereFr,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Image.asset(
                matiere.imageAsset,
                width: 80,
                height: 80,
              ),
            ],
          ),
        ));
  }
}
