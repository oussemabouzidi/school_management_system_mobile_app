class Studentinfo {
  final int id;
  final String? tel;
  final String? email;
  final String? adresse;
  final String? name;
  final String? prenom;
  final String? image;
  final String? father_name;
  final String? father_prenom;
  final String? father_tel;
  final String? father_email;
  final String? father_adresse;
  final String? mother_name;
  final String? mother_prenom;
  final String? mother_tel;
  final String? mother_email;
  final String? mother_adresse;

  Studentinfo(
      {required this.id,
      required this.tel,
      required this.email,
      required this.adresse,
      required this.name,
      required this.prenom,
      required this.image,
      required this.father_name,
      required this.father_prenom,
      required this.father_tel,
      required this.father_email,
      required this.father_adresse,
      required this.mother_name,
      required this.mother_prenom,
      required this.mother_tel,
      required this.mother_email,
      required this.mother_adresse});

  factory Studentinfo.fromJson(Map<String, dynamic> json) {
    return Studentinfo(
        id: json['eleve_id'],
        tel: json['eleve_tel'],
        email: json['eleve_email'],
        adresse: json['eleve_adresse'],
        name: json['eleve_nom'],
        prenom: json['eleve_prenom'],
        image: json['image'],
        father_name: json['pere_nom'],
        father_prenom: json['pere_prenom'],
        father_tel: json['pere_tel'],
        father_email: json['pere_email'],
        father_adresse: json['pere_adresse'],
        mother_name: json['mere_nom'],
        mother_prenom: json['mere_prenom'],
        mother_tel: json['mere_tel'],
        mother_email: json['mere_email'],
        mother_adresse: json['mere_adresse']);
  }
}
