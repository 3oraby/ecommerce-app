class OrderStateModel {
  final String state;
  final bool payment;
  final int id;
  final int orderId;
  final DateTime createdAt;
  final DateTime updatedAt;

  OrderStateModel({
    required this.state,
    required this.payment,
    required this.id,
    required this.orderId,
    required this.createdAt,
    required this.updatedAt,
  });

  factory OrderStateModel.fromJson(Map<String, dynamic> json) {
    return OrderStateModel(
      state: json['state'],
      payment: json['payment'],
      id: json['id'],
      orderId: json['order_id'],
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
    );
  }
}
