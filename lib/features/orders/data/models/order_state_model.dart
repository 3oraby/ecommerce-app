class OrderStateModel {
  final String state;
  final bool payment;
  final int id;
  final int orderId;

  OrderStateModel({
    required this.state,
    required this.payment,
    required this.id,
    required this.orderId,
  });

  factory OrderStateModel.fromJson(Map<String, dynamic> json) {
    return OrderStateModel(
      state: json['state'],
      payment: json['payment'],
      id: json['id'],
      orderId: json['order_id'],
    );
  }
}
