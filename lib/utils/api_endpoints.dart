class ApiEndpoints {
  static const baseUrl =
      'https://8d68-2404-8000-1024-13ce-148d-2bbd-275c-2d56.ngrok-free.app/api';

  // Auth
  static const register = "$baseUrl/register";
  static const login = "$baseUrl/login";
  static const logout = "$baseUrl/logout";
  static const checkToken = "$baseUrl/check-token";

  // Users
  static const currentUser = "$baseUrl/user";
  static String getUserById(int userId) => "$baseUrl/users/$userId";

  // Items
  static const getUserItems = "$baseUrl/user/items";
  static const items = "$baseUrl/items";
  static String getItemsByCategory(String category) =>
      "$baseUrl/items?category=$category";
  static String seearchItems(String query) => "$baseUrl/items?seearch=$query";
  static String itemsById(int itemId) => "$baseUrl/items/$itemId";

  // Wishlists
  static const getUserWishlists = "$baseUrl/user/wishlists";
  static const addWishlist = "$baseUrl/wishlists";
  static String removeWishlistByItemId(int itemId) =>
      "$baseUrl/wishlists/items/$itemId";
}
