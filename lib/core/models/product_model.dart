class ProductModel {
  final int id;
  final double price;
  final String photo;
  final String name;
  final String description;
  final String createdAt;
  final String updatedAt;
  int isFavorite;
  bool isLoading;

  ProductModel({
    required this.id,
    required this.price,
    required this.photo,
    required this.name,
    required this.description,
    required this.createdAt,
    required this.updatedAt,
    required this.isFavorite,
    this.isLoading = false,
  });

  factory ProductModel.fromJson({
    required Map<String, dynamic> json,
  }) {
    return ProductModel(
      id: json['id'],
      price: json['price'].toDouble(),
      photo: json['photo'],
      name: json['name'],
      description: json['description'],
      createdAt: json["createdAt"],
      updatedAt: json["updatedAt"],
      isFavorite: (json["is_favorite"] is String)
          ? int.parse(json["is_favorite"])
          : json["is_favorite"] ?? 1,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'price': price,
      'photo': photo,
      'name': name,
      'description': description,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
      'is_favorite': isFavorite,
    };
  }
}
