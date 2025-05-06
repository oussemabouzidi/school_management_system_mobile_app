import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Polices extends StatefulWidget {
  @override
  _PolicesState createState() => _PolicesState();
}

class _PolicesState extends State<Polices> {
  String _selectedFontSize = 'Medium';

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        // Top navigation bar
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 16.0),
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
                  onPressed: () {
                    Get.toNamed('/setting/main', id: 2);
                  },
                  icon: Icon(
                    Icons.arrow_back,
                    color: Colors.grey[700],
                  ),
                  padding: EdgeInsets.zero,
                ),
              ),

              // Font Size title
              Text(
                "Taille de police",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue,
                ),
              ),

              // Placeholder for symmetry
              SizedBox(width: 40, height: 40),
            ],
          ),
        ),

        // Font Size section
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
                        Icons.format_size,
                        color: Color(0xFF2D3142),
                        size: 20,
                      ),
                      SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          'Sélectionnez la taille de police',
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

                // Small option
                RadioListTile<String>(
                  value: 'Small',
                  groupValue: _selectedFontSize,
                  onChanged: (value) {
                    setState(() {
                      _selectedFontSize = value!;
                    });
                  },
                  title: Row(
                    children: [
                      Container(
                        width: 30,
                        height: 30,
                        margin: EdgeInsets.only(right: 16),
                        decoration: BoxDecoration(
                          color: Color(0xFFF6F6F6),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        alignment: Alignment.center,
                        child: Text(
                          'A',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF2D3142),
                          ),
                        ),
                      ),
                      Text(
                        'Petite',
                        style: TextStyle(
                          color: Color(0xFF2D3142),
                          fontSize: 16,
                          fontWeight: _selectedFontSize == 'Small'
                              ? FontWeight.bold
                              : FontWeight.normal,
                        ),
                      ),
                    ],
                  ),
                  activeColor: Colors.blue,
                ),
                Divider(height: 1),

                // Medium option
                RadioListTile<String>(
                  value: 'Medium',
                  groupValue: _selectedFontSize,
                  onChanged: (value) {
                    setState(() {
                      _selectedFontSize = value!;
                    });
                  },
                  title: Row(
                    children: [
                      Container(
                        width: 30,
                        height: 30,
                        margin: EdgeInsets.only(right: 16),
                        decoration: BoxDecoration(
                          color: Color(0xFFF6F6F6),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        alignment: Alignment.center,
                        child: Text(
                          'A',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF2D3142),
                          ),
                        ),
                      ),
                      Text(
                        'Moyenne',
                        style: TextStyle(
                          color: Color(0xFF2D3142),
                          fontSize: 16,
                          fontWeight: _selectedFontSize == 'Medium'
                              ? FontWeight.bold
                              : FontWeight.normal,
                        ),
                      ),
                    ],
                  ),
                  activeColor: Colors.blue,
                ),
                Divider(height: 1),

                // Large option
                RadioListTile<String>(
                  value: 'Large',
                  groupValue: _selectedFontSize,
                  onChanged: (value) {
                    setState(() {
                      _selectedFontSize = value!;
                    });
                  },
                  title: Row(
                    children: [
                      Container(
                        width: 30,
                        height: 30,
                        margin: EdgeInsets.only(right: 16),
                        decoration: BoxDecoration(
                          color: Color(0xFFF6F6F6),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        alignment: Alignment.center,
                        child: Text(
                          'A',
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF2D3142),
                          ),
                        ),
                      ),
                      Text(
                        'Grande',
                        style: TextStyle(
                          color: Color(0xFF2D3142),
                          fontSize: 16,
                          fontWeight: _selectedFontSize == 'Large'
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

        // Font Size information section
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
                    'Changer la taille de police affectera tous les textes de l\'application. Vous pouvez modifier cette option à tout moment dans les paramètres.',
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
              Get.toNamed('/setting/main', id: 2);
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
    );
  }
}
