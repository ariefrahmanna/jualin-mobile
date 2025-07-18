class ApiEndpoints {
  static const baseUrl = 'http://10.0.2.2:8000/api';

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
  static String getItemsByUsername(String username) =>
      "$baseUrl/items?username=$username";
  static String getItemsByCategory(String category) =>
      "$baseUrl/items?category=$category";
  static String seearchItems(String query) => "$baseUrl/items?search=$query";
  static String itemsById(int itemId) => "$baseUrl/items/$itemId";

  // Wishlists
  static const getUserWishlists = "$baseUrl/user/wishlists";
  static const addWishlist = "$baseUrl/wishlists";
  static String removeWishlistByItemId(int itemId) =>
      "$baseUrl/wishlists/items/$itemId";

  //PendingItems
  static const getPendingPurchases = "$baseUrl/user/pending-purchases";
  static const buyItems = "$baseUrl/pending-purchases";
  static String deletePendingPurchases(int itemId) => "$baseUrl/pending-purchases/items/$itemId";
}
