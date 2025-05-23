class Course {
  final int id;
  final String title;
  final String details;
  final List<String>? ressources;
  final String type;
  final int week;
  final String created_at;
  final String? video_url;
  final int class_id;
  final int matiere_id;

  Course(
      {required this.id,
      required this.title,
      required this.details,
      required this.ressources,
      required this.type,
      required this.week,
      required this.created_at,
      required this.video_url,
      required this.class_id,
      required this.matiere_id});

  factory Course.fromJson(Map<String, dynamic> json) {
    return Course(
        id: json['id'],
        title: json['title'],
        details: json['details'],
        ressources: json['ressources'],
        type: json['type'],
        week: json['week'],
        created_at: json['created_at'],
        video_url: json['video_url'],
        class_id: json['class_id'],
        matiere_id: json['matiere_id']);
  }
}
