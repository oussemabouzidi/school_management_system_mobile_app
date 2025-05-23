import 'package:flutter/material.dart';
import 'package:my_app3/widgets/language_button.dart';

class SavoirPlus extends StatelessWidget {
  const SavoirPlus({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return ListView(
      padding: EdgeInsets.symmetric(
        vertical: 32,
      ),
      children: [
        Container(
          padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 8.0),
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
                "Savoir Plus",
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
        SizedBox(
          height: 20,
        ),
        Padding(
          padding: EdgeInsets.symmetric(
            horizontal: screenWidth * 0.05,
          ),
          child: Column(
            children: [
              // App Information Card
              _buildInfoCard(
                context,
                title: 'À propos de l\'application',
                icon: Icons.app_shortcut,
                children: [
                  _buildInfoItem(
                    'Version',
                    '1.0.0',
                  ),
                  _buildInfoItem(
                    'Dernière mise à jour',
                    '21 Mai 2025',
                  ),
                  _buildInfoItem(
                    'Développé par',
                    'Oussema Bouzidi',
                  ),
                  _buildInfoItem(
                    'Support',
                    'bouzidioussema16@gmail.com',
                  ),
                ],
              ),

              SizedBox(height: screenHeight * 0.025),

              // School Information Card
              _buildInfoCard(
                context,
                title: 'Notre École',
                icon: Icons.school,
                children: [
                  _buildInfoItem(
                    'Nom',
                    'Institut Supérieur des Etudes Technologiques de Kélibia',
                  ),
                  _buildInfoItem(
                    'Adresse',
                    'V336+525, Route Oued El Khatf, Kélibia 8090',
                  ),
                  _buildInfoItem(
                    'Téléphone',
                    '72 277 090',
                  ),
                  _buildInfoItem(
                    'Email',
                    'boc@isetkl.rnu.tn',
                  ),
                  _buildInfoItem(
                    'Site Web',
                    'https://isetkl.rnu.tn/',
                  ),
                ],
              ),

              SizedBox(height: screenHeight * 0.025),

              // Academic Information Card
              _buildInfoCard(
                context,
                title: 'Informations Académiques',
                icon: Icons.book,
                children: [
                  _buildInfoItem(
                    'Année Scolaire',
                    '2024/2025',
                  ),
                  _buildInfoItem(
                    'Horaires',
                    'Lun-Ven: 8h00 - 17h00',
                  ),
                  _buildInfoItem(
                    'Vacances Prochaines',
                    '20 Mai - 5 Juin 2025',
                  ),
                ],
              ),

              SizedBox(height: screenHeight * 0.025),

              // FAQ Card
              _buildInfoCard(
                context,
                title: 'Foire Aux Questions',
                icon: Icons.question_answer,
                children: [
                  _buildExpandableItem(
                    context,
                    'Comment contacter un professeur?',
                    'Vous pouvez contacter les professeurs via la section "Réunions" où vous trouverez leurs coordonnées professionnelles et la possibilité de prendre rendez-vous.',
                  ),
                  _buildExpandableItem(
                    context,
                    'Comment signaler une absence?',
                    'Les absences doivent être signalées via la section "Présence" au moins 24 heures à l\'avance si possible, ou le jour même avant 8h00.',
                  ),
                  _buildExpandableItem(
                    context,
                    'Comment accéder aux devoirs?',
                    'Tous les devoirs sont disponibles dans la section "Assignment" où vous pouvez voir les échéances et les instructions détaillées.',
                  ),
                  _buildExpandableItem(
                    context,
                    'Comment fonctionne la cantine?',
                    'La section "Cantine" vous permet de voir les menus de la semaine et de réserver ou annuler des repas jusqu\'à 48h à l\'avance.',
                  ),
                ],
              ),

              SizedBox(height: screenHeight * 0.1),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildInfoCard(
    BuildContext context, {
    required String title,
    required IconData icon,
    required List<Widget> children,
  }) {
    return Card(
      elevation: 2,
      color: Colors.blue[50], // Light blue background color
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(color: Colors.blue[200]!, width: 1), // Blue border
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(
                  icon,
                  color: Colors.blue[700], // Darker blue for icon
                  size: 24,
                ),
                const SizedBox(width: 12),
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.blue[800], // Darker blue for title
                  ),
                ),
              ],
            ),
            Divider(height: 24, color: Colors.blue[200]), // Blue divider
            ...children,
          ],
        ),
      ),
    );
  }

  Widget _buildInfoItem(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 120,
            child: Text(
              label,
              style: const TextStyle(
                fontWeight: FontWeight.w500,
                color: Colors.black54,
              ),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: const TextStyle(
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildExpandableItem(
    BuildContext context,
    String question,
    String answer,
  ) {
    return Theme(
      data: Theme.of(context).copyWith(
        dividerColor: Colors.transparent,
      ),
      child: ExpansionTile(
        tilePadding: EdgeInsets.zero,
        title: Text(
          question,
          style: const TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: 15,
          ),
        ),
        iconColor: Theme.of(context).primaryColor,
        childrenPadding: const EdgeInsets.only(
          left: 16.0,
          bottom: 16.0,
        ),
        children: [
          Text(
            answer,
            style: const TextStyle(color: Colors.black87),
          ),
        ],
      ),
    );
  }
}
