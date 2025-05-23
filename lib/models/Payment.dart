class Payment {
  final int id;
  final int parent_id;
  final String title;
  final int paye;
  final int price;
  final String type;
  final String image;

  Payment(
      {required this.id,
      required this.parent_id,
      required this.title,
      required this.paye,
      required this.price,
      required this.type,
      required this.image});

  factory Payment.fromJson(Map<String, dynamic> json) {
    return Payment(
        id: json['id'],
        parent_id: json['parent_id'],
        title: json['title'],
        paye: json['paye'],
        price: json['price'],
        type: json['type'],
        image: json['image']);
  }
}
