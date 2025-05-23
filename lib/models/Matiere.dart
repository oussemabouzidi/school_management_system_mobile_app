class Matiere {
  final int id;
  final String nomMatiereFr;
  final String nomMatiereAr;
  final String imageAsset; // We'll map images based on matiere name

  Matiere({
    required this.id,
    required this.nomMatiereFr,
    required this.nomMatiereAr,
    required this.imageAsset,
  });

  factory Matiere.fromJson(Map<String, dynamic> json) {
    String imageAsset = "images/homework/book.png"; // Default image

    // Map specific images based on subject name
    if (json['nom_matiere_fr'].toString().toLowerCase().contains('math')) {
      imageAsset = "images/homework/math.png";
    } else if (json['nom_matiere_fr']
            .toString()
            .toLowerCase()
            .contains('français') ||
        json['nom_matiere_fr'].toString().toLowerCase().contains('francais')) {
      imageAsset = "images/homework/francais.png";
    } else if (json['nom_matiere_fr']
        .toString()
        .toLowerCase()
        .contains('informatique')) {
      imageAsset = "images/homework/informatique.png";
    }

    return Matiere(
      id: json['id'],
      nomMatiereFr: json['nom_matiere_fr'] ?? '',
      nomMatiereAr: json['nom_matiere_ar'] ?? '',
      imageAsset: imageAsset,
    );
  }
}
