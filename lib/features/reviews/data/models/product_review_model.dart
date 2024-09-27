class ProductReviewModel {
  final int id;
  final int rate;
  final String description;
  final DateTime date;
  final int productId;
  final int userId;
  final DateTime createdAt;
  final DateTime updatedAt;

  ProductReviewModel({
    required this.id,
    required this.rate,
    required this.description,
    required this.date,
    required this.productId,
    required this.userId,
    required this.createdAt,
    required this.updatedAt,
  });

  factory ProductReviewModel.fromJson(Map<String, dynamic> json) {
    return ProductReviewModel(
      id: json['id'],
      rate: json['rate'],
      description: json['description'],
      date: DateTime.parse(json['date']),
      productId: json["product_id"].runtimeType == int
          ? json["product_id"]
          : int.parse(json['product_id']),
      userId: json['user_id'],
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'rate': rate,
      'description': description,
      'date': date.toIso8601String(),
      'product_id': productId,
      'user_id': userId,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
    };
  }
}
