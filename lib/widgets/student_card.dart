import 'dart:ui';

import 'package:flutter/material.dart';

class StudentCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
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
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text(
                  "Ahmed Snoussi",
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF2D3142),
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  "Deuxième année",
                  style: TextStyle(
                    fontSize: 18,
                    color: Color(0xFF2D3142),
                  ),
                  textDirection: TextDirection.rtl,
                ),
              ],
            ),
            Container(
                width: 70,
                height: 70,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.grey.shade200,
                ),
                clipBehavior: Clip.antiAlias,
                child: GestureDetector(
                  /*style: ElevatedButton.styleFrom(
                    elevation: 0,
                    padding: EdgeInsets.zero,
                    backgroundColor: Colors.transparent,
                    shadowColor: Colors.transparent,
                    surfaceTintColor: Colors.transparent,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.zero,
                    ),
                  ),*/
                  onLongPress: () {
                    showGeneralDialog(
                      context: context,
                      barrierDismissible: true,
                      barrierColor: Colors.black.withOpacity(0.7),
                      barrierLabel: MaterialLocalizations.of(context)
                          .modalBarrierDismissLabel,
                      transitionDuration: const Duration(milliseconds: 100),
                      pageBuilder: (context, animation, secondaryAnimation) {
                        return GestureDetector(
                          onTap: () {
                            Navigator.of(context)
                                .pop(); // Close the dialog when tapping outside
                          },
                          child: Stack(
                            children: [
                              BackdropFilter(
                                filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                                child: Container(
                                  color: Colors.black.withOpacity(
                                      0), // Needed for the blur effect
                                ),
                              ),
                              AlertDialog(
                                backgroundColor: Colors.white,
                                shape: CircleBorder(),
                                content: Image.asset(
                                  'images/student.png', // Replace with your placeholder image path
                                  fit: BoxFit.cover,
                                  width: 200,
                                  height: 200,
                                  // Alternatively, you can use a placeholder icon:
                                  // child: Icon(Icons.person, size: 40, color: Colors.grey.shade400),
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                      transitionBuilder:
                          (context, animation, secondaryAnimation, child) {
                        return ScaleTransition(
                          scale: animation,
                          child: child,
                        );
                      },
                    );
                  },
                  child: Image.asset(
                    'images/student.png', // Replace with your placeholder image path
                    fit: BoxFit.cover,
                    // Alternatively, you can use a placeholder icon:
                    // child: Icon(Icons.person, size: 40, color: Colors.grey.shade400),
                  ),
                )),
          ],
        ),
      ),
    );
  }
}
