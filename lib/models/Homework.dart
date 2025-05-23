import 'dart:convert';

class Homework {
  final int id;
  final int enseignant_id;
  final int matiere_id;
  final String titre;
  final String description;
  final DateTime date;
  final DateTime datelimite;
  final String etat;
  final String compterendu;
  final List<String> ressources;

  Homework(
      {required this.id,
      required this.enseignant_id,
      required this.matiere_id,
      required this.titre,
      required this.description,
      required this.date,
      required this.datelimite,
      required this.etat,
      required this.compterendu,
      required this.ressources});

  // Factory constructor to create a Homework object from JSON
  factory Homework.fromJson(Map<String, dynamic> json) {
    // Parse ressources from JSON string to List<String>
    List<String> resourcesList = [];
    if (json['ressources'] != null) {
      try {
        final List<dynamic> parsedList = jsonDecode(json['ressources']);
        resourcesList = parsedList.map((item) => item.toString()).toList();
      } catch (e) {
        print('Error parsing ressources: $e');
      }
    }

    return Homework(
      id: json['id'],
      enseignant_id: json['enseignant_id'],
      matiere_id: json['matiere_id'],
      titre: json['titre'],
      description: json['description'],
      date: DateTime.parse(json['date']),
      datelimite: DateTime.parse(json['datelimite']),
      etat: json['etat'],
      compterendu: json['compterendu'] ?? "",
      ressources: resourcesList,
    );
  }
}
