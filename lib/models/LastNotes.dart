class Lastnotes {
  final String subject;
  final String date;
  final double grade;

  Lastnotes({required this.subject, required this.date, required this.grade});

  factory Lastnotes.fromJson(Map<String, dynamic> json) {
    return Lastnotes(
        subject: json['subject'],
        date: json['date'],
        grade: (json['grade'] as num).toDouble());
  }
}
