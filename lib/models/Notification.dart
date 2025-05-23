class Notification {
  final int id;
  final int parent_id;
  final String title;
  final String content;
  final String created_at;
  final int is_read;
  final String type;
  final String image;

  Notification({
    required this.id,
    required this.parent_id,
    required this.title,
    required this.content,
    required this.created_at,
    required this.is_read,
    required this.type,
    required this.image,
  });

  factory Notification.fromJson(Map<String, dynamic> json) {
    return Notification(
      id: json['id'] ?? 0,
      parent_id: json['parent_id'] ?? 0,
      title: json['title'] ?? '',
      content: json['content'] ?? '',
      created_at: json['created_at'] ?? DateTime.now().toIso8601String(),
      is_read: json['is_read'] ?? 0,
      type: json['type'] ?? 'info',
      image: json['image'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'parent_id': parent_id,
      'title': title,
      'content': content,
      'created_at': created_at,
      'is_read': is_read,
      'type': type,
      'image': image,
    };
  }

  // Create a copy of this notification with updated fields
  Notification copyWith({
    int? id,
    int? parent_id,
    String? title,
    String? content,
    String? created_at,
    int? is_read,
    String? type,
    String? image,
  }) {
    return Notification(
      id: id ?? this.id,
      parent_id: parent_id ?? this.parent_id,
      title: title ?? this.title,
      content: content ?? this.content,
      created_at: created_at ?? this.created_at,
      is_read: is_read ?? this.is_read,
      type: type ?? this.type,
      image: image ?? this.image,
    );
  }
}
