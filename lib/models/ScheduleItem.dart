class ScheduleItem {
  final String jour;
  final int semaine;
  final String seanceDebut;
  final String seanceFin;
  final String salle;
  final String nomMatiereFr;
  final String enseignantNom;
  final String enseignantPrenom;

  ScheduleItem({
    required this.jour,
    required this.semaine,
    required this.seanceDebut,
    required this.seanceFin,
    required this.salle,
    required this.nomMatiereFr,
    required this.enseignantNom,
    required this.enseignantPrenom,
  });

  factory ScheduleItem.fromJson(Map<String, dynamic> json) {
    return ScheduleItem(
      jour: json['jour'] ?? '',
      semaine: json['semaine'] ?? 0,
      seanceDebut: json['seance_debut'] ?? '',
      seanceFin: json['seance_fin'] ?? '',
      salle: json['salle'] ?? '',
      nomMatiereFr: json['nom_matiere_fr'] ?? '',
      enseignantNom: json['enseignant_nom'] ?? '',
      enseignantPrenom: json['enseignant_prenom'] ?? '',
    );
  }
}
