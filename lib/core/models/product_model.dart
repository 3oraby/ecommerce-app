class ProductModel {
  final int id;
  final double price;
  final String photo;
  final String name;
  final String description;
  final String categoryId;
  final String createdAt;
  final String updatedAt;

  ProductModel({
    required this.id,
    required this.price,
    required this.photo,
    required this.name,
    required this.categoryId,
    required this.description,
    required this.createdAt,
    required this.updatedAt,
  });

  factory ProductModel.fromJson({required Map<String, dynamic> json}) {
    return ProductModel(
      id: json['id'],
      price: json['price'].toDouble(),
      photo: json['photo'],
      name: json['name'],
      description: json['description'],
      categoryId: json['category_id'],
      createdAt: json["createdAt"],
      updatedAt: json["updatedAt"],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'price': price,
      'photo': photo,
      'name': name,
      'category_id': categoryId,
      'description': description,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
    };
  }
}
