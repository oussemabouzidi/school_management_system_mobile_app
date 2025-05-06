import 'package:flutter/material.dart';

class LanguageButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return
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
                              borderRadius: BorderRadius.circular(15)),
                          height: 50,
                          width: 250,
                          child: Row(
                            children: [
                              Padding(
                                padding: EdgeInsets.only(left: 30),
                                child: Image.asset(
                                  'images/languages/francais.png',
                                  width: 30,
                                  height: 30,
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(left: 30),
                                child: Center(child: Text("Francais")),
                              )
                            ],
                          )),
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                          decoration: BoxDecoration(
                              color: Color(0xFFFF8CA1),
                              borderRadius: BorderRadius.circular(15)),
                          height: 50,
                          width: 250,
                          child: Row(
                            children: [
                              Padding(
                                padding: EdgeInsets.only(left: 30),
                                child: Image.asset(
                                  'images/languages/unitedKingdom.png',
                                  width: 30,
                                  height: 30,
                                ),
                              ),
                              Padding(
                                  padding: EdgeInsets.only(left: 30),
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
                              borderRadius: BorderRadius.circular(15)),
                          height: 50,
                          width: 250,
                          child: Row(
                            children: [
                              Padding(
                                padding: EdgeInsets.only(left: 30),
                                child: Image.asset(
                                  'images/languages/arabicLanguage.png',
                                  width: 30,
                                  height: 30,
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(left: 30),
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
    );
  }
}
