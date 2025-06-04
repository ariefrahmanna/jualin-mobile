class ApiEndpoints {
  static final String baseUrl = 'https://8454-2001-448a-3023-248a-c05e-e841-9646-7817.ngrok-free.app/api/';
  static AuthEndpoints authEndpoints = AuthEndpoints();
}

class AuthEndpoints {
  final String register = 'register';
  final String login = 'login';
  final String items = 'items';
}
