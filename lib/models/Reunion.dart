class Reunion {
  final int id;
  final int parent_id;
  final String title;
  final String description;
  final String date_meeting;
  final String location;
  final String type;
  final String status;
  final int? confirmation;

  Reunion(
      {required this.id,
      required this.parent_id,
      required this.title,
      required this.description,
      required this.date_meeting,
      required this.location,
      required this.type,
      required this.status,
      required this.confirmation});

  factory Reunion.fromJson(Map<String, dynamic> json) {
    return Reunion(
        id: json['id'],
        parent_id: json['parent_id'],
        title: json['title'],
        description: json['description'],
        date_meeting: json['date_meeting'],
        location: json['location'],
        type: json['type'],
        status: json['status'],
        confirmation: json['confirmation']);
  }
}
