class OrderModel {
  final int id;
  final int userId;
  final int addressId;
  final double total;
  final String addressInDetails;
  final DateTime createdAt;
  final DateTime updatedAt;

  OrderModel({
    required this.id,
    required this.userId,
    required this.addressId,
    required this.total,
    required this.addressInDetails,
    required this.createdAt,
    required this.updatedAt,
  });

  factory OrderModel.fromJson(Map<String, dynamic> json) {
    return OrderModel(
      id: json['id'],
      userId: json['user_id'],
      addressId: json['address_id'],
      total: json['total'].toDouble(),
      addressInDetails: json['addressInDetails'],
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
    );
  }
}
