class ApiEndpoints {
  static final String baseUrl = 'http://10.0.2.2:8000/api';
  static AuthEndpoints authEndpoints = AuthEndpoints();
}

class AuthEndpoints {
  final String register = '/register';
  final String login = '/login';
  final String checkToken = '/check-token';
  final String items = '/items';
  final String logout = '/logout';
  final String wishlists = '/wishlists';
  final String userWishlists = '/user/wishlists';
  final String removeWishlist = '/wishlists/items';
  final String userItems = '/user/items';
}
