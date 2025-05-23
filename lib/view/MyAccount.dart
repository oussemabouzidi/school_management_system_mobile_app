import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_app3/controller/myaccount_controller.dart';
import 'package:my_app3/services/Services.dart';
import 'package:my_app3/widgets/language_button.dart';
import 'package:my_app3/widgets/logout_button.dart';
import 'package:my_app3/widgets/notification_button.dart';

class Myaccount extends StatefulWidget {
  @override
  _MyaccountState createState() => _MyaccountState();
}

class _MyaccountState extends State<Myaccount> {
  final MyaccountController controller = Get.put(MyaccountController());
  // Mock data for children profiles
  //final List<Map<String, dynamic>> childrenProfiles ;

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
              itemCount: controller.eleveProfile.length,
              itemBuilder: (context, index) {
                final child = controller.eleveProfile[index];
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
                      backgroundImage: AssetImage(
                        (child['image'] != null &&
                                child['image'].toString().isNotEmpty)
                            ? child['image']
                            : 'images/student.png', // your default image path
                      ),
                    ),
                    title: Text(
                      child['nom'],
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text(child['classe']),
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
    return Obx(() {
      if (controller.isLoading.value) {
        return Center(child: CircularProgressIndicator());
      }

      if (controller.hasError.value) {
        return Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.error_outline, size: 48, color: Colors.red),
              SizedBox(height: 16),
              Text(
                controller.errorMessage.value,
                style: TextStyle(color: Colors.red, fontSize: 16),
              ),
              SizedBox(height: 16),
              ElevatedButton.icon(
                onPressed: controller.fetchData,
                icon: Icon(Icons.refresh),
                label: Text('Réessayer'),
              ),
            ],
          ),
        );
      }

      if (controller.eleveProfile.isEmpty) {
        return Center(child: Text('Aucun profil trouvé.'));
      }

      final currentChild = controller.eleveProfile[selectedChildIndex];

      return ListView(
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
                LanguageButton(),
                // Notifications
                NotificationButton(
                  notificationService: Service(),
                ),
                // Logout
                LogoutButton()
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
                            currentChild['nom'],
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF2D3142),
                            ),
                          ),
                          SizedBox(height: 8),
                          Text(
                            currentChild['classe'],
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
                          currentChild['image'] != null &&
                                  currentChild['image'].toString().isNotEmpty
                              ? currentChild['image']
                              : 'images/student.png',
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
                          currentChild['nom'],
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                            color: Color(0xFF2D3142),
                          ),
                        ),
                        SizedBox(height: 4),
                        Text(
                          "${currentChild['eleve_id']}",
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
                      currentChild['date_naissance'],
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
                      currentChild['telephone'],
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
      );
    });
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

// In your Myaccount class, update the _buildActionButton method like this:
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
        onTap: () {
          if (text == "Changer le mot de passe") {
            Get.toNamed(
              '/myaccount/change_password',
              id: 3,
            );
          } else if (text == "Modifier le profil") {
            // Pass the correct student ID to ModifierProfil
            final studentId =
                controller.eleveProfile[selectedChildIndex]['eleve_id'];
            Get.toNamed(
              '/myaccount/update_profile',
              id: 3,
              arguments: studentId,
            );
          }
        },
      ),
    );
  }
}
