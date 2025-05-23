import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_app3/shared/SharedPrefsService.dart';

class LogoutButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return // Logout button
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
                  title: Text("Logout"),
                  content: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text("Souhaitez-vous vraiment vous déconnecter ?"),
                      SizedBox(
                        height: 30,
                      ),
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              elevation: 0,
                              padding: EdgeInsets.symmetric(vertical: 16),
                              backgroundColor: Colors.transparent,
                              shadowColor: Colors.transparent,
                              surfaceTintColor: Colors.transparent,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20)),
                            ),
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                  color: Color(0xFF9ECAFF),
                                  borderRadius: BorderRadius.circular(15)),
                              height: 30,
                              width: 50,
                              child: Center(child: Text("Non")),
                            ),
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                elevation: 0,
                                padding: EdgeInsets.symmetric(vertical: 16),
                                backgroundColor: Colors.transparent,
                                shadowColor: Colors.transparent,
                                surfaceTintColor: Colors.transparent,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20)),
                              ),
                              onPressed: () {
                                SharedPrefsService.clearUserData();
                                Get.offNamed('/login');
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                    color: Color(0xFFFF8CA1),
                                    borderRadius: BorderRadius.circular(15)),
                                width: 50,
                                height: 30,
                                child: Center(
                                  child: Text("Oui"),
                                ),
                              )),
                        ],
                      )
                    ],
                  ),
                );
              });
        },
        icon: Image.asset(
          "images/dashboard/Logout.png",
          width: 24,
          height: 24,
        ),
        padding: EdgeInsets.zero,
      ),
    );
  }
}
