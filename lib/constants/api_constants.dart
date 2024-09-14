class ApiConstants {
  static const String baseUrl = "http://10.0.2.2:1020/api/v1/";
  // auth
  static const String loginEndPoint = "auths/login";
  static const String registerEndPoint = "auths/signUp";
  static const String verifyEmailEndPoint = "auths/verify?";
  static const String logOutEndPoint = "auths/logout";

  // user
  static const String getUserEndPoint = "users/me";
  static const String updateUserEndPoint = "users/";

  // photo
  static const String getPhotoEndPoint = "uploads/";

  // category
  static const String getCategoriesEndPoint = "categories";

  // products
  static const String getProductsEndPoint = "products";
  static const String getCategoryProductsEndPoint = "products/category/";
  static const String getProductDetailsEndPoint = "products/";
  static const String getHomeDataEndPoint = "products/homepage";
  static const String checkProductInCartEndPoint =
      "products/checkProductInCart/";

  // favorites
  static const String getFavoritesEndPoint = "favorites";
  static const String addOrDeleteFavoritesEndPoint = "favorites/";

  // cart
  static const String showCartEndPoint = "carts/showCart";
  static const String addToCartEndPoint = "carts/addToCart/";
  static const String deleteFromCartEndPoint = "carts/deleteFromCart/";
  static const String updateCartItemEndPoint = "carts/updateCartItem/";
  static const String showPriceEndPoint = "carts/showPrice";
  static const String showCartItemEndPoint = "carts/getCartItem/";

  // addresses
  static const String getAllAddressesEndPoint = "addresses";
  static const String getOrdersAddressesEndPoint =
      "orders/getOrdersAddressForUser";

  //orders
  static const String checkoutEndPoint = "orders/checkOut";
  static const String getOrderEndPoint = "orders/";
  static const String getAllOrdersEndPoint = "orders/getUserOrders/";
  static String cancelItemFromOrder({
    required int orderId,
    required int orderItemId,
  }) {
    return "orders/deleteFromOrder/$orderId/$orderItemId";
  }

  // reviews
  static String getProductAverageRatingEndPoint(int productId) {
    return "products/$productId/review/getAverageRating";
  }

  static String getProductReviewsEndPoint(int productId) {
    return "products/$productId/review";
  }

  static String createReviewEndPoint(int productId) {
    return "products/$productId/review";
  }

  static String getReviewDetailsEndPoint(int productId, int reviewId) {
    return "products/$productId/review/$reviewId";
  }

  static String deleteReviewEndPoint(int productId, int reviewId) {
    return "products/$productId/review/$reviewId";
  }

  static String updateReviewEndPoint(int productId, int reviewId) {
    return "products/$productId/review/$reviewId";
  }

  static String checkUserReviewForProductEndPoint({required int productId,required int userId}) {
    return "reviews/checkUserReview/$productId/$userId";
  }
}
