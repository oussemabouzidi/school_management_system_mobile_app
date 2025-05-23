import 'package:circular_gradient_spinner/circular_gradient_spinner.dart';
import 'package:flutter/material.dart';
import 'package:my_app3/services/Services.dart';
import 'package:my_app3/widgets/language_button.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

// Model for behavior records
class BehaviorRecord {
  final String nomFr;
  final String prenomFr;
  final String dateCmp;
  final String type;
  final String description;
  final String trimestre;
  final String anneeScolaire;

  BehaviorRecord({
    required this.nomFr,
    required this.prenomFr,
    required this.dateCmp,
    required this.type,
    required this.description,
    required this.trimestre,
    required this.anneeScolaire,
  });

  factory BehaviorRecord.fromJson(Map<String, dynamic> json) {
    return BehaviorRecord(
      nomFr: json['nom_fr'],
      prenomFr: json['prenom_fr'],
      dateCmp: json['date_cmp'],
      type: json['type'],
      description: json['description'],
      trimestre: json['trimestre'],
      anneeScolaire: json['annee_scolaire'],
    );
  }
}

// API Service
class BehaviorApiService {
  static String baseUrl = Service().baseUrl;

  static Future<List<BehaviorRecord>> fetchBehaviorRecords({
    required int eleveId,
    required int anneeScolaireId,
    required int trimesterId,
  }) async {
    try {
      final response = await http.get(Uri.parse(
          '$baseUrl/comportement?eleve_id=$eleveId&annee_scolaire_id=$anneeScolaireId&trimester_id=$trimesterId'));

      if (response.statusCode == 200) {
        List<dynamic> jsonData = json.decode(response.body);
        return jsonData.map((data) => BehaviorRecord.fromJson(data)).toList();
      } else {
        throw Exception(
            'Failed to load behavior records: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Failed to connect to server: $e');
    }
  }
}

class Behavior extends StatefulWidget {
  const Behavior({Key? key}) : super(key: key);

  @override
  _BehaviorState createState() => _BehaviorState();
}

class _BehaviorState extends State<Behavior> {
  List<BehaviorRecord> _behaviorRecords = [];
  List<BehaviorRecord> _filteredRecords = [];
  bool _isLoading = true;
  String _error = '';
  int _selectedTrimestrId = 1;
  int _selectedAnneeId = 1;
  String _searchQuery = '';

  // Maps for display values
  final Map<int, String> _trimesterOptions = {
    1: "1er trimestre",
    2: "2ème trimestre",
    3: "3ème trimestre",
  };

  final Map<int, String> _yearOptions = {
    1: "2023/2024",
    2: "2024/2025",
    3: "2025/2026",
  };

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    setState(() {
      _isLoading = true;
      _error = '';
    });

    try {
      final records = await BehaviorApiService.fetchBehaviorRecords(
        eleveId: 1, // assuming student ID is 1
        anneeScolaireId: _selectedAnneeId,
        trimesterId: _selectedTrimestrId,
      );

      setState(() {
        _behaviorRecords = records;
        _applyFilter();
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
        _error = e.toString();
      });
    }
  }

  void _applyFilter() {
    if (_searchQuery.isEmpty) {
      _filteredRecords = List.from(_behaviorRecords);
    } else {
      _filteredRecords = _behaviorRecords.where((record) {
        return record.type.toLowerCase().contains(_searchQuery.toLowerCase()) ||
            record.description
                .toLowerCase()
                .contains(_searchQuery.toLowerCase());
      }).toList();
    }
  }

  // Get icon based on behavior type
  Image _getIconForBehaviorType(String type) {
    final typeLower = type.toLowerCase();
    if (typeLower.contains('positive') || typeLower.contains('félicitations')) {
      return Image.asset("images/positive.png");
    } else if (typeLower.contains('absence')) {
      return Image.asset("images/absence.png");
    } else if (typeLower.contains('retard')) {
      return Image.asset("images/Flag.png");
    } else if (typeLower.contains('warning') ||
        typeLower.contains('avertissement')) {
      return Image.asset("images/warnning.png");
    } else {
      return Image.asset("images/positive.png");
    }
  }

  // Get color based on behavior type
  Color _getColorForBehaviorType(String type) {
    final typeLower = type.toLowerCase();
    if (typeLower.contains('positive') || typeLower.contains('félicitations')) {
      return Colors.green;
    } else if (typeLower.contains('absence')) {
      return Colors.red;
    } else if (typeLower.contains('retard')) {
      return Colors.orange;
    } else if (typeLower.contains('warning') ||
        typeLower.contains('avertissement')) {
      return Colors.amber;
    } else {
      return Colors.blue;
    }
  }

  // Format date from API
  String _formatDate(String dateStr) {
    try {
      final date = DateTime.parse(dateStr);
      return DateFormat('dd-MM-yyyy').format(date);
    } catch (e) {
      return dateStr; // Return original if parsing fails
    }
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        // Back button, title, and language toggle row
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 16.0),
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
                "Comportement",
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
        const SizedBox(height: 16),

        // Filters section - Year & Trimester
        Container(
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            children: [
              Expanded(
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.2),
                        spreadRadius: 1,
                        blurRadius: 3,
                      ),
                    ],
                  ),
                  child: DropdownButton<int>(
                    value: _selectedTrimestrId,
                    isExpanded: true,
                    underline: Container(),
                    onChanged: (value) {
                      if (value != null) {
                        setState(() {
                          _selectedTrimestrId = value;
                          _loadData();
                        });
                      }
                    },
                    items: _trimesterOptions.entries.map((entry) {
                      return DropdownMenuItem<int>(
                        value: entry.key,
                        child: Text(entry.value),
                      );
                    }).toList(),
                  ),
                ),
              ),
              SizedBox(width: 12),
              Expanded(
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.2),
                        spreadRadius: 1,
                        blurRadius: 3,
                      ),
                    ],
                  ),
                  child: DropdownButton<int>(
                    value: _selectedAnneeId,
                    isExpanded: true,
                    underline: Container(),
                    onChanged: (value) {
                      if (value != null) {
                        setState(() {
                          _selectedAnneeId = value;
                          _loadData();
                        });
                      }
                    },
                    items: _yearOptions.entries.map((entry) {
                      return DropdownMenuItem<int>(
                        value: entry.key,
                        child: Text(entry.value),
                      );
                    }).toList(),
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),

        Container(
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            children: [
              // Search bar
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(25),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.2),
                      spreadRadius: 1,
                      blurRadius: 3,
                    ),
                  ],
                ),
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  children: [
                    const Icon(Icons.search, color: Colors.grey),
                    const SizedBox(width: 8),
                    Expanded(
                      child: TextField(
                        decoration: const InputDecoration(
                          hintText: 'Recherche',
                          border: InputBorder.none,
                          hintStyle: TextStyle(color: Colors.grey),
                        ),
                        onChanged: (value) {
                          setState(() {
                            _searchQuery = value;
                            _applyFilter();
                          });
                        },
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),

              // Loading indicator
              if (_isLoading)
                Center(
                    child: CircularGradientSpinner(
                  color: Colors.blue,
                  size: 50,
                  strokeWidth: 20,
                ))
              // Error message
              else if (_error.isNotEmpty)
                Container(
                  padding: EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.red[50],
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    'Erreur: $_error',
                    style: TextStyle(color: Colors.red),
                  ),
                )
              // No records found
              else if (_filteredRecords.isEmpty)
                Container(
                  padding: EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.blue[50],
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    'Aucun comportement trouvé pour cette période',
                    style: TextStyle(color: Colors.blue),
                    textAlign: TextAlign.center,
                  ),
                )
              // Behavior records list
              else
                Column(
                  children: _filteredRecords.map((record) {
                    return Container(
                      width: double.infinity,
                      margin: EdgeInsets.only(bottom: 16),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.2),
                            spreadRadius: 1,
                            blurRadius: 4,
                            offset: Offset(0, 2),
                          ),
                        ],
                      ),
                      padding: const EdgeInsets.all(16),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                              padding: const EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                color: _getColorForBehaviorType(record.type)
                                    .withOpacity(0.1),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Container(
                                width: 50,
                                height: 50,
                                child: _getIconForBehaviorType(record.type),
                              )),
                          const SizedBox(width: 16),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  record.type,
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color:
                                        _getColorForBehaviorType(record.type),
                                  ),
                                ),
                                Text(
                                  record.description,
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.black87,
                                  ),
                                ),
                                SizedBox(height: 8),
                                Row(
                                  children: [
                                    Icon(
                                      Icons.calendar_today,
                                      size: 14,
                                      color: Colors.grey,
                                    ),
                                    SizedBox(width: 4),
                                    Text(
                                      'Date: ${_formatDate(record.dateCmp)}',
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: Colors.grey,
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 12),
                                Container(
                                  decoration: BoxDecoration(
                                    color: const Color(0xFFE6F7E7),
                                    borderRadius: BorderRadius.circular(16),
                                  ),
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 12,
                                    vertical: 6,
                                  ),
                                  child: const Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Icon(
                                        Icons.arrow_forward,
                                        color: Colors.green,
                                        size: 14,
                                      ),
                                      SizedBox(width: 4),
                                      Text(
                                        'Plus d\'informations',
                                        style: TextStyle(
                                          color: Colors.green,
                                          fontWeight: FontWeight.w500,
                                          fontSize: 12,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                  }).toList(),
                ),
            ],
          ),
        ),
        SizedBox(height: 16),
      ],
    );
  }
}
