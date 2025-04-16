import 'package:slide_switcher/slide_switcher.dart';
import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:crystal_navigation_bar/crystal_navigation_bar.dart';
import 'package:iconly/iconly.dart';
import 'package:badges/badges.dart' as badges;

class ForgotPassword extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
      body: Stack(children: [
        // Background Image
        Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('images/background.png'), // Or NetworkImage
              fit: BoxFit.cover,
            ),
          ),
          child: Column(
            children: [
              Stack(
                alignment: Alignment.center,
                children: [
                  // Background image
                  Image.asset(
                    'images/login_effect.png',
                    width: 500,
                    height: 50,
                    fit: BoxFit.cover,
                  ),

                  // Foreground image
                  Image.asset(
                    'images/mdp_oublie.png',
                    //width: 300,
                    height: 150,
                  ),
                ],
              ),
              Container(
                child: Container(
                    alignment: Alignment.topCenter,
                    child: Column(
                      children: [
                        Text("Mot de pass oublié",
                            style: TextStyle(
                                color: Color(0XFF124388),
                                fontSize: 40,
                                fontWeight: FontWeight.bold)),
                        Text("Enter votre numero portable ",
                            style:
                                TextStyle(color: Colors.black, fontSize: 16)),
                        SlideSwitcher(
                          onSelect: (index) {},
                          containerHeight: 40,
                          containerWight: 400,
                          children: [
                            Text('Numero de telephone'),
                            Text('Email'),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              SizedBox(
                                height: 30,
                              ),
                              Container(
                                decoration: BoxDecoration(
                                  border:
                                      Border.all(color: Colors.grey.shade300),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Row(
                                  children: [
                                    SizedBox(
                                      width: 100,
                                      child: TextField(
                                        decoration: const InputDecoration(
                                          hintText: '+216',
                                          border: InputBorder.none,
                                          prefixIcon:
                                              Icon(Icons.person_outline),
                                          contentPadding: EdgeInsets.symmetric(
                                              vertical: 12),
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      width: 150,
                                      child: TextField(
                                        decoration: const InputDecoration(
                                          hintText: '81313782626',
                                          border: InputBorder.none,
                                          prefixIcon:
                                              Icon(Icons.person_outline),
                                          contentPadding: EdgeInsets.symmetric(
                                              vertical: 12),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: 30,
                              ),
                              Container(
                                width: double.infinity,
                                height: 50,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                  gradient: LinearGradient(
                                    colors: [
                                      const Color(0xFFF9D976), // gold/yellow
                                      const Color(0xFF6BBBF7), // blue
                                    ],
                                    begin: Alignment.centerLeft,
                                    end: Alignment.centerRight,
                                  ),
                                ),
                                child: ElevatedButton(
                                  onPressed: () {},
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.transparent,
                                    shadowColor: Colors.transparent,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                  ),
                                  child: const Text(
                                    'Envoiyer l’OTP',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(height: 16),

                              // Cancel button
                              SizedBox(
                                width: double.infinity,
                                height: 50,
                                child: OutlinedButton(
                                  onPressed: () {},
                                  style: OutlinedButton.styleFrom(
                                    side:
                                        const BorderSide(color: Colors.black26),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                  ),
                                  child: const Text(
                                    'Annuler',
                                    style: TextStyle(
                                      color: Colors.black87,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    )),
              ),
            ],
          ),
        ),
      ]),
    ));
  }
}
