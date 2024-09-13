class OrdersAddressModel {
  String? addressInDetails;
  int? addressId;
  String? country;
  String? city;

  OrdersAddressModel({
    this.addressId,
    this.country = "Egypt",
    this.city,
    this.addressInDetails,
  });

  factory OrdersAddressModel.fromJson(Map<String, dynamic> json) {
    return OrdersAddressModel(
      addressInDetails: json["addressInDetails"],
      addressId: json["Address"]["id"],
      country: json["Address"]["country"],
      city: json["Address"]["city"],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'addressInDetails': addressInDetails,
      'Address': {
        'id': addressId,
        'country': country,
        'city': city,
      },
    };
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is OrdersAddressModel &&
        other.addressId == addressId &&
        other.addressInDetails == addressInDetails &&
        other.country == country &&
        other.city == city;
  }

  @override
  int get hashCode {
    return addressId.hashCode ^
        addressInDetails.hashCode ^
        country.hashCode ^
        city.hashCode;
  }
}
