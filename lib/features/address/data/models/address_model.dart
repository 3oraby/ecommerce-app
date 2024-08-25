class AddressModel {
  final int id;
  final String country;
  final String city;

  AddressModel({
    required this.id,
    required this.country,
    required this.city,
  });

  factory AddressModel.fromJson({
    required Map<String, dynamic> json,
  }) {
    return AddressModel(
      id: json["id"],
      country: json["country"],
      city: json["city"],
    );
  }
}
