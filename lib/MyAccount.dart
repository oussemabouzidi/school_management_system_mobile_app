import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:crystal_navigation_bar/crystal_navigation_bar.dart';
import 'package:iconly/iconly.dart';
import 'package:badges/badges.dart' as badges;

class Myaccount extends StatefulWidget {
  @override
  _MyaccountState createState() => _MyaccountState();
}

class _MyaccountState extends State<Myaccount> {
  // Mock data for children profiles
  final List<Map<String, dynamic>> childrenProfiles = [
    {
      'name': 'Ahmed Snoussi',
      'id': '11023',
      'grade': 'Deuxième année',
      'image': 'images/student.png',
      'birthDate': '15 Oct 2013',
      'phone': '+216 54 784 621',
    },
    {
      'name': 'Sara Snoussi',
      'id': '11024',
      'grade': 'Quatrième année',
      'image': 'images/student_female.png',
      'birthDate': '23 Apr 2011',
      'phone': '+216 54 784 621',
    },
  ];

  int selectedChildIndex = 0;

  void _showChildrenSelectionDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          title: Text(
            "Choisir un enfant",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          content: Container(
            width: double.maxFinite,
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: childrenProfiles.length,
              itemBuilder: (context, index) {
                final child = childrenProfiles[index];
                return Container(
                  margin: EdgeInsets.only(bottom: 10),
                  decoration: BoxDecoration(
                    color: selectedChildIndex == index
                        ? Color(0xFF9ECAFF)
                        : Colors.grey.shade100,
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundImage: AssetImage(child['image']),
                    ),
                    title: Text(
                      child['name'],
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text(child['grade']),
                    selected: selectedChildIndex == index,
                    onTap: () {
                      setState(() {
                        selectedChildIndex = index;
                      });
                      Navigator.of(context).pop();
                    },
                  ),
                );
              },
            ),
          ),
          actions: [
            TextButton(
              child: Text("Annuler"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final currentChild = childrenProfiles[selectedChildIndex];

    return MaterialApp(
        home: Scaffold(
      backgroundColor: Color(0xFFE8F0FE),
      extendBody: true,
      body: ListView(
        children: [
          // Top navigation bar (similar to EducationalDashboard)
          Container(
            padding:
                const EdgeInsets.symmetric(horizontal: 8.0, vertical: 16.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16.0),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Language button
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
                                            padding: EdgeInsets.only(left: 30),
                                            child: Image.asset(
                                              'images/languages/francais.png',
                                              width: 30,
                                              height: 30,
                                            ),
                                          ),
                                          Padding(
                                            padding: EdgeInsets.only(left: 30),
                                            child:
                                                Center(child: Text("Francais")),
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
                                            padding: EdgeInsets.only(left: 30),
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
                ),

                // Notifications
                badges.Badge(
                  badgeContent: Text(
                    '3',
                    style: TextStyle(color: Colors.white, fontSize: 10),
                  ),
                  badgeStyle: badges.BadgeStyle(
                    badgeColor: Colors.red,
                    padding: EdgeInsets.all(6),
                  ),
                  child: Container(
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
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                title: Text(
                                  "Notifications",
                                  style: TextStyle(color: Colors.red[400]),
                                ),
                                content: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    _buildNotificationItem(
                                      title: 'Club Théâtre',
                                      description:
                                          'Le Club-Théâtre est un lieu dynamique où l\'art du théâtre prend vie',
                                      imageAsset: 'images/theatre.png',
                                      logoColor: Colors.red,
                                    ),
                                    SizedBox(height: 16),
                                    _buildNotificationItem(
                                      title: 'Club de Foot',
                                      description:
                                          'Le Club foot est un lieu sportive',
                                      imageAsset: 'images/football.png',
                                      logoColor: Colors.black,
                                    ),
                                  ],
                                ),
                              );
                            });
                      },
                      icon: HugeIcon(
                        icon: HugeIcons.strokeRoundedNotification03,
                        size: 24.0,
                        color: Colors.grey[700]!,
                      ),
                      padding: EdgeInsets.zero,
                    ),
                  ),
                ),

                // Logout button
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
                                  Text(
                                      "Souhaitez-vous vraiment vous déconnecter ?"),
                                  SizedBox(
                                    height: 30,
                                  ),
                                  Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                          elevation: 0,
                                          padding: EdgeInsets.symmetric(
                                              vertical: 16),
                                          backgroundColor: Colors.transparent,
                                          shadowColor: Colors.transparent,
                                          surfaceTintColor: Colors.transparent,
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(20)),
                                        ),
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                        },
                                        child: Container(
                                          decoration: BoxDecoration(
                                              color: Color(0xFF9ECAFF),
                                              borderRadius:
                                                  BorderRadius.circular(15)),
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
                                            padding: EdgeInsets.symmetric(
                                                vertical: 16),
                                            backgroundColor: Colors.transparent,
                                            shadowColor: Colors.transparent,
                                            surfaceTintColor:
                                                Colors.transparent,
                                            shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(20)),
                                          ),
                                          onPressed: () {},
                                          child: Container(
                                            decoration: BoxDecoration(
                                                color: Color(0xFFFF8CA1),
                                                borderRadius:
                                                    BorderRadius.circular(15)),
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
                ),
              ],
            ),
          ),

          // User profile card (updated to show current child and switch profile button)
          Container(
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
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            currentChild['name'],
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF2D3142),
                            ),
                          ),
                          SizedBox(height: 8),
                          Text(
                            currentChild['grade'],
                            style: TextStyle(
                              fontSize: 18,
                              color: Color(0xFF2D3142),
                            ),
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
                        child: Image.asset(
                          currentChild['image'],
                          fit: BoxFit.cover,
                        ),
                      ),
                    ],
                  ),

                  // Switch profile button
                  SizedBox(height: 16),
                  Container(
                    width: double.infinity,
                    child: ElevatedButton.icon(
                      onPressed: _showChildrenSelectionDialog,
                      icon: Icon(Icons.swap_horiz, color: Colors.white),
                      label: Text(
                        "Changer d'enfant",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xFF4E7DFF),
                        padding: EdgeInsets.symmetric(vertical: 12),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Personal info card with modern design
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
                        Expanded(
                          flex: 2,
                          child: Text(
                            'Informations Personnelles',
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

                  // Info rows - updated to use the selected child's data
                  _buildInfoRow(
                    iconData: Icons.badge,
                    leftText: 'Nom et Identifiant',
                    rightWidget: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          currentChild['name'],
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                            color: Color(0xFF2D3142),
                          ),
                        ),
                        SizedBox(height: 4),
                        Text(
                          currentChild['id'],
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                  ),
                  _buildInfoRow(
                    iconData: Icons.calendar_today,
                    leftText: 'Date de naissance',
                    rightWidget: Text(
                      currentChild['birthDate'],
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        color: Color(0xFF2D3142),
                      ),
                    ),
                  ),
                  _buildInfoRow(
                    iconData: Icons.phone,
                    leftText: 'Contact téléphonique',
                    rightWidget: Text(
                      currentChild['phone'],
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        color: Color(0xFF2D3142),
                      ),
                    ),
                  ),
                  _buildInfoRow(
                    iconData: Icons.people,
                    leftText: 'Nom et prenom de parent',
                    rightWidget: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        Text(
                          'Mohamed Snoussi',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                            color: Color(0xFF2D3142),
                          ),
                        ),
                        SizedBox(height: 4),
                        Text(
                          'Mouna Snoussi',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                            color: Color(0xFF2D3142),
                          ),
                        ),
                      ],
                    ),
                    isLastRow: true,
                  ),
                ],
              ),
            ),
          ),

          // Additional actions section
          Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
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
                  _buildActionButton(
                    icon: Icons.edit,
                    text: "Modifier le profil",
                    color: Colors.blue,
                  ),
                  Divider(height: 1),
                  _buildActionButton(
                    icon: Icons.password,
                    text: "Changer le mot de passe",
                    color: Colors.green,
                  ),
                  Divider(height: 1),
                  _buildActionButton(
                    icon: Icons.help_outline,
                    text: "Aide et support",
                    color: Colors.purple,
                    isLastItem: true,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: CrystalNavigationBar(
        currentIndex: 4, // My account is active
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
              // Already on myaccount
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

  Widget _buildInfoRow({
    required IconData iconData,
    required String leftText,
    required Widget rightWidget,
    bool isLastRow = false,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        border: !isLastRow
            ? const Border(
                bottom: BorderSide(
                  color: Color(0xFFEEEEEE),
                ),
              )
            : null,
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
        child: Row(
          children: [
            // Icon
            Container(
              padding: EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Color(0xFFE8F0FE),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(
                iconData,
                color: Color(0xFF2D3142),
                size: 20,
              ),
            ),
            SizedBox(width: 12),

            // Left text
            Expanded(
              flex: 2,
              child: Text(
                leftText,
                style: TextStyle(
                  color: Color(0xFF2D3142),
                  fontSize: 14,
                ),
              ),
            ),

            // Right widget
            Expanded(
              flex: 3,
              child: Container(
                alignment: Alignment.centerLeft,
                child: rightWidget,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildActionButton({
    required IconData icon,
    required String text,
    required Color color,
    bool isLastItem = false,
  }) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: isLastItem
            ? BorderRadius.only(
                bottomLeft: Radius.circular(24),
                bottomRight: Radius.circular(24),
              )
            : null,
      ),
      child: ListTile(
        leading: Container(
          padding: EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: color.withOpacity(0.1),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Icon(icon, color: color),
        ),
        title: Text(
          text,
          style: TextStyle(
            fontWeight: FontWeight.w500,
            color: Color(0xFF2D3142),
          ),
        ),
        trailing: Icon(
          Icons.arrow_forward_ios,
          size: 16,
          color: Colors.grey,
        ),
        onTap: () {},
      ),
    );
  }
}

Widget _buildNotificationItem({
  required String title,
  required String description,
  required String imageAsset,
  required Color logoColor,
}) {
  return Container(
    padding: EdgeInsets.all(12),
    decoration: BoxDecoration(
      color: logoColor.withOpacity(0.1),
      borderRadius: BorderRadius.circular(15),
    ),
    width: 280,
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CircleAvatar(
          backgroundColor: logoColor,
          radius: 24,
          child: Padding(
            padding: const EdgeInsets.all(4.0),
            child: Image.asset(
              imageAsset,
              fit: BoxFit.contain,
            ),
          ),
        ),
        SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  )),
              SizedBox(height: 4),
              Text(
                description,
                style: TextStyle(fontSize: 13, color: Colors.black87),
              ),
            ],
          ),
        )
      ],
    ),
  );
}
