class Devoir {
  final String date_test;
  final String heure;
  final String salle;
  final String description;
  final String matiere;
  final String enseignant_nom;
  final String enseignant_prenom;

  Devoir(
      {required this.date_test,
      required this.heure,
      required this.salle,
      required this.description,
      required this.matiere,
      required this.enseignant_nom,
      required this.enseignant_prenom});

  factory Devoir.fromJson(Map<String, dynamic> json) {
    return Devoir(
        date_test: json['date_test'],
        heure: json['heure'],
        salle: json['salle'],
        description: json['description'],
        matiere: json['matiere'],
        enseignant_nom: json['enseignant_nom'],
        enseignant_prenom: json['enseignant_prenom']);
  }
}
