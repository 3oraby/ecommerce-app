class ErrorModel {
  final int statusCode;
  final String status;
  final bool isOperational;

  ErrorModel({
    required this.statusCode,
    required this.status,
    required this.isOperational,
  });

  factory ErrorModel.fromJson(Map<String, dynamic> json) {
    return ErrorModel(
      statusCode: json['statusCode'],
      status: json['status'],
      isOperational: json['isOperational'],
    );
  }
}