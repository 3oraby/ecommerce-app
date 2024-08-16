class CategoryModel {
  final int id;
  final String name;
  final String photo;
  final DateTime createdAt;
  final DateTime updatedAt;

  CategoryModel({
    required this.id,
    required this.name,
    required this.photo,
    required this.createdAt,
    required this.updatedAt,
  });

  factory CategoryModel.fromJson({required Map<String, dynamic> json}) {
    return CategoryModel(
      id: json['id'],
      name: json['name'],
      photo: json['photo'],
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'photo': photo,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
    };
  }
}
