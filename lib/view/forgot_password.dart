import 'package:my_app3/view/wrapper.dart';
import 'package:slide_switcher/slide_switcher.dart';
import 'package:flutter/material.dart';
import 'package:crystal_navigation_bar/crystal_navigation_bar.dart';
import 'package:iconly/iconly.dart';

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
      bottomNavigationBar: CrystalNavigationBar(
        currentIndex: 2, // ✅ Provide a valid default value
        onTap: (index) {
          switch (index) {
            case 0:
              //Navigator.of(context).pushReplacementNamed("home");
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(
                    builder: (context) => Wrapper(initialIndex: 0)), // home
              );
              break;
            case 1:
              //Navigator.of(context).pushReplacementNamed("chatbot");
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(
                    builder: (context) => Wrapper(initialIndex: 1)), // home
              );
              break;
            case 2:
              //Navigator.of(context).pushReplacementNamed("menu");
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(
                    builder: (context) => Wrapper(initialIndex: 2)), // home
              );
              break;
            case 3:
              //Navigator.of(context).pushReplacementNamed("settings");
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(
                    builder: (context) => Wrapper(initialIndex: 3)), // home
              );
              break;
            case 4:
              //Navigator.of(context).pushReplacementNamed("myaccount");
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(
                    builder: (context) => Wrapper(initialIndex: 4)), // home
              );
              break;
          }
        },
        height: 10,
        // indicatorColor: Colors.blue,
        unselectedItemColor: Colors.white70,
        borderWidth: 2,
        outlineBorderColor: Colors.white,
        backgroundColor: Colors.black.withValues(alpha: 0.5),
        // boxShadow: [
        //   BoxShadow(
        //     color: Colors.black.withOpacity(0.1),
        //     blurRadius: 4,
        //     spreadRadius: 4,
        //     offset: Offset(0, 10),
        //   ),
        // ],
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
              selectedColor: Colors.white),

          /// Profile
          CrystalNavigationBarItem(
            icon: IconlyBold.profile,
            unselectedIcon: IconlyLight.profile,
            selectedColor: Colors.white,
          ),
        ],
      ),
    ));
  }
}
