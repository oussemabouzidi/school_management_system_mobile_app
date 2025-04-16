import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:crystal_navigation_bar/crystal_navigation_bar.dart';
import 'package:iconly/iconly.dart';
import 'package:badges/badges.dart' as badges;

class Languages extends StatefulWidget {
  @override
  _LanguagesState createState() => _LanguagesState();
}

class _LanguagesState extends State<Languages> {
  String _selectedLanguage = 'Français';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Color(0xFFE8F0FE),
        extendBody: true,
        body: ListView(
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
                  // Back button
                  Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                    child: IconButton(
                      onPressed: () => Navigator.of(context)
                          .pushReplacementNamed("settings"),
                      icon: Icon(
                        Icons.arrow_back,
                        color: Colors.grey[700],
                      ),
                      padding: EdgeInsets.zero,
                    ),
                  ),

                  // Languages title
                  Text(
                    "Langues",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF2D3142),
                    ),
                  ),

                  // Placeholder for symmetry
                  SizedBox(width: 40, height: 40),
                ],
              ),
            ),

            // Languages section
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(24),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.05),
                      blurRadius: 10,
                      spreadRadius: 0,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    // Header
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Color(0xFFF6F6F6),
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(24),
                          topRight: Radius.circular(24),
                        ),
                      ),
                      child: Row(
                        children: [
                          Icon(
                            Icons.language,
                            color: Color(0xFF2D3142),
                            size: 20,
                          ),
                          SizedBox(width: 8),
                          Expanded(
                            child: Text(
                              'Sélectionnez votre langue',
                              style: TextStyle(
                                color: Color(0xFF2D3142),
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                    // French option
                    RadioListTile<String>(
                      value: 'Français',
                      groupValue: _selectedLanguage,
                      onChanged: (value) {
                        setState(() {
                          _selectedLanguage = value!;
                        });
                      },
                      title: Row(
                        children: [
                          Container(
                            width: 30,
                            height: 20,
                            margin: EdgeInsets.only(right: 16),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(4),
                              image: DecorationImage(
                                image:
                                    AssetImage('images/languages/francais.png'),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          Text(
                            'Français',
                            style: TextStyle(
                              color: Color(0xFF2D3142),
                              fontSize: 16,
                              fontWeight: _selectedLanguage == 'Français'
                                  ? FontWeight.bold
                                  : FontWeight.normal,
                            ),
                          ),
                        ],
                      ),
                      activeColor: Colors.blue,
                    ),
                    Divider(height: 1),

                    // English option
                    RadioListTile<String>(
                      value: 'English',
                      groupValue: _selectedLanguage,
                      onChanged: (value) {
                        setState(() {
                          _selectedLanguage = value!;
                        });
                      },
                      title: Row(
                        children: [
                          Container(
                            width: 30,
                            height: 20,
                            margin: EdgeInsets.only(right: 16),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(4),
                              image: DecorationImage(
                                image: AssetImage(
                                    'images/languages/unitedKingdom.png'),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          Text(
                            'English',
                            style: TextStyle(
                              color: Color(0xFF2D3142),
                              fontSize: 16,
                              fontWeight: _selectedLanguage == 'English'
                                  ? FontWeight.bold
                                  : FontWeight.normal,
                            ),
                          ),
                        ],
                      ),
                      activeColor: Colors.blue,
                    ),
                    Divider(height: 1),

                    // Arabic option
                    RadioListTile<String>(
                      value: 'العربية',
                      groupValue: _selectedLanguage,
                      onChanged: (value) {
                        setState(() {
                          _selectedLanguage = value!;
                        });
                      },
                      title: Row(
                        children: [
                          Container(
                            width: 30,
                            height: 20,
                            margin: EdgeInsets.only(right: 16),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(4),
                              image: DecorationImage(
                                image: AssetImage(
                                    'images/languages/arabicLanguage.png'),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          Text(
                            'العربية',
                            style: TextStyle(
                              color: Color(0xFF2D3142),
                              fontSize: 16,
                              fontWeight: _selectedLanguage == 'العربية'
                                  ? FontWeight.bold
                                  : FontWeight.normal,
                            ),
                          ),
                        ],
                      ),
                      activeColor: Colors.blue,
                    ),
                  ],
                ),
              ),
            ),

            // Language information section
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(24),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.05),
                      blurRadius: 10,
                      spreadRadius: 0,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    // Header
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Color(0xFFF6F6F6),
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(24),
                          topRight: Radius.circular(24),
                        ),
                      ),
                      child: Row(
                        children: [
                          Icon(
                            Icons.info,
                            color: Color(0xFF2D3142),
                            size: 20,
                          ),
                          SizedBox(width: 8),
                          Expanded(
                            child: Text(
                              'Informations',
                              style: TextStyle(
                                color: Color(0xFF2D3142),
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                    // Info content
                    Padding(
                      padding: const EdgeInsets.all(16),
                      child: Text(
                        'Changer la langue affectera tous les textes de l\'application. Vous pouvez changer la langue à tout moment dans les paramètres.',
                        style: TextStyle(
                          color: Color(0xFF2D3142),
                          fontSize: 14,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // Apply button
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: ElevatedButton(
                onPressed: () {
                  // Save language preference and navigate back
                  Navigator.of(context).pushReplacementNamed("settings");
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  padding: EdgeInsets.symmetric(vertical: 16),
                ),
                child: Text(
                  'Appliquer',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),

            // Bottom space for navigation bar
            SizedBox(height: 80),
          ],
        ),
        bottomNavigationBar: CrystalNavigationBar(
          currentIndex: 3, // Settings is active
          onTap: (index) {
            switch (index) {
              case 0:
                Navigator.of(context).pushReplacementNamed("home");
                break;
              case 1:
                Navigator.of(context).pushReplacementNamed("chatbot");
                break;
              case 2:
                Navigator.of(context).pushReplacementNamed("menu");
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
              selectedColor: Colors.white,
            ),

            /// Profile
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
}
