
class ApiConstants {
  static const String baseUrl = "http://10.0.2.2:1020/api/v1/";
  // auth
  static const String loginEndPoint = "auths/login";
  static const String registerEndPoint = "auths/signUp";
  static const String verifyEmailEndPoint = "auths/verify?";
  static const String logOutEndPoint = "auths/logout";
  // photo
  static const String getPhotoEndPoint = "uploads/";
  // category
  static const String getCategoriesEndPoint = "categories";
  // products
  static const String getProductsEndPoint = "products";
  static const String getCategoryProductsEndPoint = "products/category/";
  static const String getProductDetailsEndPoint = "products/";
  // favorites
  static const String getFavoritesEndPoint = "favorites";
}