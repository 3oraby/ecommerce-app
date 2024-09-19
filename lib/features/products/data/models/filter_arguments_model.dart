class FilterArgumentsModel {
  double? minPrice;
  double? maxPrice;
  String? sort;
  String? sortOrder;
  int? page;
  int? limit;

  FilterArgumentsModel({
    this.minPrice,
    this.maxPrice,
    this.sort,
    this.sortOrder,
    this.page,
    this.limit,
  });

  // Convert the model to JSON (Map)
  Map<String, dynamic> toJson() {
    return {
      if (minPrice != null) 'minPrice': minPrice,
      if (maxPrice != null) 'maxPrice': maxPrice,
      if (sort != null) 'sort': sort,
      if (sortOrder != null) 'sortOrder': sortOrder,
      if (page != null) 'page': page,
      if (limit != null) 'limit': limit,
    };
  }

  factory FilterArgumentsModel.fromJson(Map<String, dynamic> json) {
    return FilterArgumentsModel(
      minPrice: json['minPrice']?.toDouble(),
      maxPrice: json['maxPrice']?.toDouble(),
      sort: json['sort'],
      sortOrder: json['sortOrder'],
      page: json['page'] != null ? json['page'] as int : null,
      limit: json['limit'] != null ? json['limit'] as int : null,
    );
  }
}
